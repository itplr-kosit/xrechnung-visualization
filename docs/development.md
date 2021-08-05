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
