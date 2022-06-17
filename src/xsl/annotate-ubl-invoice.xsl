<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="/Invoice:Invoice/cbc:DocumentCurrencyCode">
        <xsl:processing-instruction name="xsem">id="<xsl:attribute name="xr:id" select="'BT-5'"/>" name="Invoice_currency_code" value-path="<xsl:attribute name="xr:src" select="xr:src-path(.)"/>"</xsl:processing-instruction>
        <cbc:DocumentCurrencyCode>
            <xsl:call-template name="code"/>
        </cbc:DocumentCurrencyCode>
    </xsl:template>
    
</xsl:stylesheet>