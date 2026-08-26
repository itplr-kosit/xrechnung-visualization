# Development of XRechnung Visualization


## Project Structure

* `src` contains the source files.
* `src/test` contains example instances of invoice files.
* `src/xsd` contains the schema of the intermediate xml.
* `src/xsl` contains the transformation files.

## Dependencies Overview

Dependencies and their versions are declared in `pom.xml` and resolved by the Maven Artifact
Resolver Ant Tasks, which the xsbi build unit `abu-marant` provides. The POM is never built or
published - it is the dependency declaration only; the build itself stays Ant.

| Dependency | Coordinates | Scope | Used for |
|---|---|---|---|
| Apache FOP | `org.apache.xmlgraphics:fop` | `runtime` | XSL-FO to PDF |
| VNU HTML validator | `nu.validator:validator` | `test` | validating the generated HTML |
| XRechnung testsuite | `de.xeinkauf:xrechnung-<version>-testsuite` (zip) | `provided` | test instances |
| Validator configuration | `de.xeinkauf:xrechnung-<version>-validator-configuration` (zip) | `provided` | validator scenarios |

Two repositories are used: Maven Central and the XSE component repository
(`de.xeinkauf` artifacts). They are declared **twice on purpose**: in `build.xml` as
`<resolver:remoterepos id="xse.repos">`, because the resolver Ant tasks do not read the POM's
`<repositories>` block, and again in `pom.xml` so that POM-consuming tooling can resolve the
same coordinates. Keep the two in sync.

### Why the dependencies carry a scope

A `pomRef` resolve always takes the *whole* POM, so the scope is used as a **grouping
mechanism**: `provide-maven-dependencies` performs one resolution and hands out three disjoint
groups, selected with the resolver's `scopes` attribute. The scope says nothing about how an
artifact is provided.

Keeping the groups apart matters: VNU brings its own `Saxon-HE 9.6.0`, which must never end up
on the FOP or XSLT classpath next to the `Saxon-HE 12.8` this build uses.

### Not (yet) in the POM

Saxon-HE and the KoSIT validator are still downloaded as archives into `lib/` by the xsbi build
units `abu-saxon-provider` and `abu-validator-provider`.

## The build environment

This repository contains an ANT `build.xml` for development and test.

We recommend `Apache Ant` version 1.10.x or newer (but should work with > 1.8.x).

The main `ant` targets for development are:

* `clean` deletes all generated folders i.e. foremost the `build` directory.
* `transform-to-visualization` generates all visualizations from xrechnung-testsuite and test instances in `src/test`
* `test` validates source UBL or CII XML against XRechnung, transforms to XR Sem Model and schema validates results and transforms and test HTML and PDF visualization
* and `dist` (creating the distribution artefact)

However, because of the complex dependencies, you may only expect `transform-to-visualization` target to work without any customizations.

### Target reference

#### Setup and dependencies

| Target | Depends on | What it does |
|---|---|---|
| `init` | `abu-common.init-directories` | Creates the build directory structure and the build date; probes whether the validator jar and a validator repository are already present. |
| `provide-maven-dependencies` | `init`, `abu-marant.load` | Declares the remote repositories and performs the **single** dependency resolution of the whole build: `classpath.fop` (scope `runtime`), `classpath.vnu` (scope `test`) and the `de.xeinkauf` archives into `download/` (scope `provided`). A new dependency is a change to `pom.xml`; only a dependency needing a group of its own also adds a line here. |
| `provide-saxon` | `abu-saxon-provider.provide-saxon` | Downloads Saxon-HE and the XML resolver into `lib/`. Skipped when `saxon.available`. |
| `provide-validator` | `abu-validator-provider.provide-validator` | Downloads the KoSIT validator standalone jar into `lib/`. Skipped when `dep.validator.available`. |
| `provide-validator-configuration` | `provide-maven-dependencies`, `provide-validator` | Unpacks the resolved validator configuration into `build/xrechnung-configuration-repository`. Skipped when `validator.repository.dir.available`, i.e. when you point the build at your own configuration. |
| `retrieve-xr-testsuite-from-local-build` | `provide-maven-dependencies` | **Development only.** Runs only if `develop.local.xr.testsuite` is set and then overwrites the resolved testsuite archive with a build from your local clone - a plain `dist` directory is not a Maven repository, so this stays a direct download. |
| `provide-testsuite` | `provide-maven-dependencies`, `retrieve-xr-testsuite-from-local-build` | Copies the instances from `src/test/instances` and unpacks the testsuite archive into `build/test/instances/positive`. |
| `dependency-resolve` | all of the above | Aggregates the provisioning and registers the `<fop>` Ant task with `classpath.fop` plus Saxon. Every transformation and test target depends on it. |

#### Transformation

| Target | Depends on | What it does |
|---|---|---|
| `compile-negative-tests` | `dependency-resolve` | Copies the deliberately invalid `wrong*.xml` instances into the negative test directory. |
| `transform-ubl-invoice-to-xr` | `dependency-resolve`, `compile-negative-tests` | UBL Invoice to XR, for `*ubl.xml`. |
| `transform-ubl-creditnote-to-xr` | `dependency-resolve`, `compile-negative-tests` | UBL CreditNote to XR, for `*creditnote.xml`. |
| `transform-cii-to-xr` | `dependency-resolve`, `compile-negative-tests` | CII to XR, for `*uncefact.xml`. |
| `transform-to-xr` | the three above | Runs all source format transformations. |
| `transform-xr-to-html` | `transform-to-xr` | XR to HTML, German and English (`build/test/html`, `build/test/html-en`). |
| `transform-xr-to-pdf` | `transform-to-xr`, `dependency-resolve` | XR to XSL-FO to PDF in three variants: default, `tabular`, and `tabular` in English. Uses `conf/fop.xconf`. |
| `transform-to-visualization` | `transform-xr-to-html`, `transform-xr-to-pdf` | **Default target.** All media and variants. |

#### Test

| Target | Depends on | What it does |
|---|---|---|
| `test-testsuite` | `dependency-resolve` | Runs the KoSIT validator over the positive instances and writes HTML reports to `build/test/reports`. Fails early if `validator.repository.dir` is unset. |
| `test-xr-transformation` | `transform-to-xr` | Schema-validates every generated XR document against `src/xsd/xrechnung-semantic-model.xsd`. |
| `test-html` | `dependency-resolve`, `transform-xr-to-html` | Runs VNU over the generated HTML. |
| `test-pdf` | `transform-xr-to-pdf` | Does nothing beyond triggering PDF generation; a FOP failure fails the build. |
| `direct-test-transformation` | - | Convenience: schema-validates whatever is already in `build/test/transformed`, without regenerating it. |
| `test` | `dependency-resolve`, `compile-negative-tests`, `test-testsuite`, `test-xr-transformation`, `test-html`, `test-pdf` | The full test suite. |

#### Distribution and release

| Target | Depends on | What it does |
|---|---|---|
| `release-env-file` | `dependency-resolve` | Writes `build/build.env` with `GROUP_ID`, `ARTIFACT_ID`, `PACKAGE_VERSION`, `PACKAGE_BINARY` and `MAVEN_PACKAGE_NAME`, consumed by the GitLab CI deploy and release components. |
| `dist-only` | - | Zips `src`, `README.md`, `CHANGELOG.md`, `doc` and `conf` into `dist/`. Runs no tests. |
| `dist` | `test`, `dist-only` | Full test suite, then the archive. |
| `release` | `release-env-file`, `dist` | What the CI build job runs. |

#### Inherited from xsbi

Vendored under `_vendor/xsbi-<version>/abu` and pulled in at the top of `build.xml`. Targets of
an included build unit are prefixed with its name; `abu-common` is imported, so its targets are
also available unprefixed.

| Build unit | Provides |
|---|---|
| `abu-common` | Directory conventions and `init-directories`, `clean`, `clean-lib`, `clean-download`, `clean-all`. `ant clean-all` is the reliable way to force everything to be fetched again. |
| `abu-marant` | Downloads `maven-resolver-ant-tasks`, registers the `resolver:*` tasks and reads `pom.xml` as the reference `pom`. Requires a POM in the project directory. |
| `abu-saxon-provider` | Saxon-HE and the XML resolver in `lib/`. |
| `abu-validator-provider` | The KoSIT validator standalone jar in `lib/`. |

## Test dependencies on the fly

If you build own local custom versions of dependencies such as XRechnung Testsuite or Validator Configuration XRechnung, you can customize the ant build at runtime.

### Test with local Validator Configuration XRechnung

If you want to test with a local validator configuration xrechnung installation set the ant property `validator.repository.dir` to the directory (full path) like e.g. `validator.repository.dir=/mnt/c/data/git-repos/validator-configuration-xrechnung/build` (Linux). 
To execute the `test` target, for example, call

```shell
ant -Dvalidator.repository.dir=/home/renzo/projects/validator-configuration-xrechnung/build test
```

For Windows users:

```shell
ant "-Dvalidator.repository.dir=/c:/dev/git/validator-configuration-xrechnung/build" test
```

### Development properties file

In order to configure more complex adoption to the local development needs, you have to load a set of different properties from a file.

We provide the `development.build.properties.example` file for the most common properties to be set different than default. It contains some documentation.

You have to copy the file to e.g. `development.build.properties` and you have to explicitly provide the property file location at CLI for your development (otherwise tests will always fail or not be executed at all).


## Distribution

The `ant` target `dist` creates the distribution zip Archive for releases.

## Release

### Checklist

* Are all issues scheduled for the release solved?
* Is everything merged to master branch?
* Make sure that CHANGELOG.md is up to date
* Make sure all external contributors are mentioned


### Prepare

* Make sure you committed and pushed everything 
* Create the distribution 
 
   * Use the `clean` target to build and test all from scratch

```
ant clean dist
```

### Deploy

* Tag the last commit according to the following naming rule: `${date-of-scheduled-release}-{rc}` e.g.
  `git tag 2026-01-31-rc1 && git push origin 2026-01-31-rc1`

### Publish

* If **all** released components are checked to be okay, tag the last commit according to the following naming rule: 
   `v${date-of-scheduled-release-e.g. 2025-07-10}`
  e.g.
  `git tag v2026-01-31 && git push origin v2026-01-31`

* The tag will trigger a release pipeline and create a GitLab release
* Copy & paste the high quality changelog entries for this release from CHANGELOG.md.
* Add a release title of the following scheme: `XRechnung Visualization ${xr-visu.version.full} compatible with XRechnung ${xrechnung.version}`.

* Publish the new release in GitHub

### Post-Release

* Change the version of this component in `build.xml` to the next release and commit
* bump version
* update CHANGELOG.md

You are done :smile:
