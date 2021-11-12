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

Configuration of the general layout of the invoice. 

```xml
<xsl:param name="invoiceline-layout">normal</xsl:param>
```
Supported values are: 
* normal - Similar to HTML layout incl. box layout of invoice lines 
* tabular - Tabular layout of invoice lines


  Configuration of table clumn width 
  <!-- This parameter can be used when different proportions of table columns
       are needed for tabular layout
       -->
  <xsl:param name="tabular-layout-widths">2 7 2 2 2 2 1.3 2</xsl:param>




Configuration of the numbering scheme of invoice lines. 
  <!-- Numbering of invoice line/sub lines 
            normal - use numbers from invoice
            1.1    - use multilevel arabic numbering
            1.i    - use mixture of arabic and roman numbering
            00001  - use arabic numbering and align them
                   - any picture string supported by xsl:number instruction can be used
       -->
  <xsl:param name="invoiceline-numbering">normal</xsl:param>
  

### Choice of Language for HTML and PDF

German (de) is default and an English (en) translation is also shipped.

```
<xsl:param name="lang" select="'de'"/>
```

The translation files are located in [l10n subdirectory](../src/xsl/l10n/)

The format is according to Java Properties in XML (see https://docs.oracle.com/javase/7/docs/api/java/util/Properties.html for details).

The translation files can be changed to local needs.

If one wants to add an additional  language then an XML Properties file can be added to the above directory. By default it ahs to be named by theISO two letter language code (e.g. `fr.xml` for french).
