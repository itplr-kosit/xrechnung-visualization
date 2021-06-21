<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xr="urn:ce.eu:en16931:2017:xoev-de:kosit:standard:xrechnung-1"
                xmlns:xrf="https://projekte.kosit.org/xrechnung/xrechnung-visualization/functions"
                xmlns:xrv="http://www.example.org/XRechnung-Viewer">

  <!-- We are emulating older tempate for getting labels in order to maintain backward compatability -->
  <xsl:template name="field-mapping">
    <xsl:param name="identifier"/>
    
    <label><xsl:value-of select="xrf:_($identifier)"/></label>
    <nummer><xsl:value-of select="xrf:get-id($identifier)"/></nummer>
  </xsl:template>


  <xsl:function name="xrf:field-label" as="xs:string">
    <xsl:param name="identifier"/>
    
    <xsl:sequence select="xrf:_($identifier)"></xsl:sequence>
  </xsl:function>

</xsl:stylesheet>
