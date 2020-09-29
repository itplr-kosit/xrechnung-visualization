# Changelog

All notable changes to the Schematron Rules and this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 2020-09-13
### Fixed
- Fixed visualization of BG-20, BG-21, BG-27, BG-28
- Fixed visualization of BT-11 in UBL-CreditNote

## v2020-07-30

### Added
- Sub Invoice Line with recursion in UBL-Invoice
- PDF visualization
- Ids to html divs

### Changed
- Compatible with XRechnung 2.0.0
- Xsl scripts are not generated automatically from xrechnung-model anymore
- Add scheme-ids and scheme-version-ids to div ids
- Show multiple payment terms and payment due days from CII

### Fixed
- Issue double generation of BT-47, BT-86
- Multiple line allowances and line charges (BG-27, BG-28)
- Id of BG-27 fixed in xr-mapping.xsl and xrechnung-html.xsl
- Fixed german decimal seperator and missing zero in decimal smaller than 1
- Fixed visualization of BT-74 and BT-74
- Fixed BT-39 in HTML

## v2019-06-24

### Added

- License

### Changed

- compatible with XRechnung 1.2.1
- Add CEN license statement

### Fixed

- BUG in the creation of `<xsl:template name="identifier-with-scheme-and-version">`
