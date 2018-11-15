# XRechnung Visualization Transformators

XSL transformations for web rendering of German CIUS XRechnung or EN16931-1:2017.

The transformations have to in either UBL Invoice/CreditNote XML and CII XML and have to be conforming to German CIUS XRechnung or EN16931-1:2017.

The transformations have to happen in two steps:

1. Either of UBL Invoice/CreditNote XML and CII XML have to be transformed to an intermediate XML valid to a proprietary simple [XML Schema](src/xsd/xrechnung-semantic-model.xsd)
2. Then you can use the [xrechnung-html.xsl](src/xsl/xrechnung-html.xsl) to render an HTML document

You can find an example use of these transformations in the [ant build script](build.xml). It also includes some technical tests.

This GitHub repository is only a mirror of a GitLab project repository.

For questions please contact KoSIT.
