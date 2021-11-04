<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xrf="https://projekte.kosit.org/xrechnung/xrechnung-visualization/functions" 
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:decimal-format name="decimal" decimal-separator="," grouping-separator="." NaN="" />
    
    <xsl:function name="xrf:format-with-at-least-two-digits" as="xs:string">
        <xsl:param name="input-number"/>        
        <xsl:choose>
            <xsl:when test="string-length(substring-after(xs:string($input-number), '.'))>2">
                <xsl:sequence select="format-number($input-number,'###.##0,#################','decimal')"></xsl:sequence>
            </xsl:when>
            <xsl:otherwise>                
                <xsl:sequence select="format-number($input-number,'###.##0,00','decimal')"></xsl:sequence>
            </xsl:otherwise>
        </xsl:choose>                   
    </xsl:function>
</xsl:stylesheet>