# Usage

There are various configuration options for the XSLT transformations.

## PDF Transformation

### Choice of FO engine 

The FO engine used can be specified. Engine specific extensions will then be enabled. 

```xml
<xsl:param name="foengine"/>
```

Supported values are: 
* axf - Antenna House XSL Formatter
* fop - Apache FOP

### Layout options

**Configuration of the general layout of the invoice**

```xml
<xsl:param name="invoiceline-layout">normal</xsl:param>
```
Supported values are: 
* normal - Similar to HTML layout incl. box layout of invoice lines 
* tabular - Tabular layout of invoice lines

**Configuration of table column width**

```xml
<xsl:param name="tabular-layout-widths">2 7 2 2 2 2 1.3 2</xsl:param>
```

Change column proportions according to your tabular layout.

**Configuration of the numbering scheme of invoice lines.**

```xml
<xsl:param name="invoiceline-numbering">normal</xsl:param>
```

Supported values are: 
* normal - use numbers from invoice 
* 1.1    - use multilevel arabic numbering
* 1.i    - use mixture of arabic and roman numbering
* 00001  - use arabic numbering and align them
* *other* - any picture string supported by xsl:number instruction can be used

### Choice of Language for HTML and PDF

Default language is German (de), an English (en) translation is also provided.

```xml
<xsl:param name="lang" select="'de'"/>
```

Translation files are located in the [l10n subdirectory](../src/xsl/l10n/) and can be customized according to specific local needs.

Translation files are formatted according to Java Properties in XML (see https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/Properties.html for details).
Additional languages can be included by adding XML Properties files to the [l10n directory](../src/xsl/l10n/). Per default, files have to be named according to ISO 639-1 two letter language codes (e.g. `fr.xml` for French).
