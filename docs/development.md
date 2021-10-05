# Development of XRechnung Visualization

## General Approach

The main purpose of this project is to provide xsl transformators for web and pdf rendering of German CIUS XRechnung or EN16931-1:2017.

## Project Structure

* `src` contains the source files.
* `src/test` contains example instances of invoice files and a list of instances for downloading from the testsuite.
* `src/xsd` contains the schematic of the intermediate xml.
* `src/xsl` contains the transformations files.

## The build environment

We recommend `Apache Ant` version 1.10.x or newer (but should work with > 1.8.x).

The main `ant` targets for developing are:

* `test` validates source UBL or CII XML against XRechnung, transforms to XR Sem Model and schema validates results and transforms and test HTML and PDF visualization
* and `dist` (creating the distribution artefact)

## Distribution

The `ant` target `dist` creates the distribution zip Archive for releases.

## Release

### Checklist

* Are all issues scheduled for the release solved?
* Is everything merged to master branch?
* Do Schematron files include correct version of XRechnung Specification? 
* Make sure that CHANGELOG.md is up to date


### Prepare

* Make sure you committed and pushed everything 
 ## Release

### Checklist

* Are all issues scheduled for the release solved?
* Is everything merged to master branch?
* Do Schematron files include correct version of XRechnung Specification? 
* Make sure that CHANGELOG.md is up to date


### Prepare

* Make sure you committed and pushed everything 
* Create the distribution 
 
   * Use the `clean` target to build and test all from scratch

```
ant clean dist
```

* Tag the last commit according to the following naming rule: `v${xr-visu.version.full}` e.g.
  `git tag v2021-07-31 && git push origin v2021-07-31` 

### Publish

* Draft a new release at https://github.com/itplr-kosit/xrechnung-visualization/releases/new
  * Choose the git tag you just created
* Add release title of the following scheme: `XRechnung Visualization ${xr-visu.version.full} compatible with XRechnung ${xrechnung.version}`
* Copy & paste the high quality changelog entries for this release from CHANGELOG.md.
* Upload distribution zip and tick mark this release as a `pre-release`.
* If **all** released componentes are checked to be okay, then uncheck pre-release.

### Post-Release

* Change the version of XRechnung Schematron in `build.xml` to the next release and commit

You are done :smile:
