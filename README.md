# XRechnung Visualization Transformators

XSL transformators for web rendering of German CIUS XRechnung or EN16931-1:2017.

The source documents have to be in either UBL Invoice/CreditNote XML and CII XML and have to be conforming to German CIUS XRechnung or EN16931-1:2017.

The transformations have to happen in two steps:

1. Either UBL Invoice/CreditNote XML or CII XML have to be transformed to an intermediate XML which has to be valid to a proprietary simple [XML Schema](src/xsd/xrechnung-semantic-model.xsd)
2. Then you can use either 
   - [xrechnung-html.xsl](src/xsl/xrechnung-html.xsl) to render an HTML document or
   - [xr-pdf.xsl](src/xsl/xr-pdf.xsl) to render an PDF document

See our [architecture documentation](doc/architecture.md) (in German) for a general overview.
Here you can find more details on [configuration and usage options](doc/usage.md)

You can find an example use of these transformations in the [ant build script](build.xml). It also includes some technical tests.

## Notes

The visualization component is part of the technical components that have been published as a bundle together with the XRechnung standard since version 1.2.0.

These components are not software solutions but merely represent optional building blocks in 3rd party software. You are free to use them. The standard XRechnung DOES NOT oblige the use of these components. However, we always publish the components in accordance with the resp. version of XRechnung specification. As such, our components themselves are implementations which claim to be conformant to the standard.

Please also note that only the structured, machine-readable format (XML) is considered the original invoice that must be archived in accordance with legal requirements.
Visualizations generated from an XRechnung are NOT valid instances of XRechnung. They aim to improve readability by the human eye and are NOT meant to serve as formats for long-term archiving.


This GitHub repository is only a mirror of our [GitLab project repository](https://projekte.kosit.org/xrechnung/xrechnung-visualization).

For questions please contact [KoSIT](https://xeinkauf.de/kontakt/#support).
