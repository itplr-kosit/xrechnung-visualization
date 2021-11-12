# Usage

There are various configuration options for the XSLT transformations.


## PDF 

### Choice of FO engine 

The FO engine used can be specified. Specific extensions will be then enabled. 

Supported values are: 
* axf - Antenna House XSL Formatter
* fop - Apache FOP

```
  <xsl:param name="foengine"/>
```

### Choice of Language

German (de) is default and an English tranlsation is also shipped.

```
<xsl:param name="lang" select="'de'"/>
```
If one wants to add different language then an XML Properties file and/or change the existing translation
  
  <!-- Layout of invoce lines: 
            normal - default behaviour
            tabular - table like
       -->
  <xsl:param name="invoiceline-layout">normal</xsl:param>

  <!-- Numbering of invoice line/sub lines 
            normal - use numbers from invoice
            1.1    - use multilevel arabic numbering
            1.i    - use mixture of arabic and roman numbering
            00001  - use arabic numbering and align them
                   - any picture string supported by xsl:number instruction can be used
       -->
  <xsl:param name="invoiceline-numbering">normal</xsl:param>
  
  <!-- This parameter can be used when different proportions of table columns
       are needed for tabular layout
       -->
  <xsl:param name="tabular-layout-widths">2 7 2 2 2 2 1.3 2</xsl:param>
  
  <xsl:param name="axf.extensions" select="if ($foengine eq 'axf') then true() else false()"/>
  <xsl:param name="fop.extensions" select="if ($foengine eq 'fop') then true() else false()"/>
