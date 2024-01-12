<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xsla="http://example.com/xslt-alias"
    xmlns:xslb="http://example.com/xslt-alias-b"
    xmlns:xr="urn:ce.eu:en16931:2017:xoev-de:kosit:standard:xrechnung-1"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:output indent="yes"/>
    
    <xsl:namespace-alias stylesheet-prefix="xsla" result-prefix="xsl"/>
    
    <xsl:template match="/">
        <xsl:variable name="transform-xrechnung-html">            
            <xsla:stylesheet version="3.0">                
                <xsla:mode on-no-match="shallow-copy"/>
                <xsla:namespace-alias stylesheet-prefix="xslb" result-prefix="xsl"/>
                <xsl:apply-templates/>
            </xsla:stylesheet>
        </xsl:variable>
        <!--<xsl:copy-of select="$transform-xrechnung-html"/>-->
        <xsl:sequence select="transform(
            map { 
            'source-node': document('xrechnung-html.xsl'), 
            'stylesheet-node': $transform-xrechnung-html }
            )?output
            "/>
    </xsl:template>
    
    <xsl:template match="*:model/*:definitions/*:term">        
        <xsla:template match="//div[@data-title='{@id}']">
            <div>                
                <xsla:apply-templates select="@*[not(name()='data-title')]"/>
                <xslb:attribute name="data-title">
                    <xsl:value-of select="@id"/>
                    <xsl:text>&#013;&#010;</xsl:text>
                    <xsl:value-of select="./*:description"/>
                    <xsl:text>&#013;&#010;</xsl:text>                    
                    <!--<xsla:if test="matches(xsl:value-of/@select,'(xr:[A-Z_a-z0-9/:]*)')">
                        <xsla:element name="xsl:value-of">
                            <xsla:attribute name="select">
                                <xsla:analyze-string regex="(xr:[A-Z_a-z0-9/:]*)" select="xsl:value-of/@select">
                                    <xsla:matching-substring>
                                        <xsla:value-of select="regex-group(1)"/><xsl:text>/&#64;xr:src</xsl:text>                                        
                                    </xsla:matching-substring>
                                </xsla:analyze-string>
                            </xsla:attribute>
                        </xsla:element>   
                    </xsla:if>-->
                    <xsla:if test="matches(xsl:value-of/@select,'(xr:[A-Z_a-z0-9/:]*)')">                        
                        <xsla:element name="xsl:value-of">
                            <xsla:attribute name="select">
                                <xsla:value-of select="analyze-string(xsl:value-of/@select, '(xr:[A-Z_a-z0-9/:]*)')/*[local-name(.) eq 'match'][1]/*"/><xsl:text>/&#64;xr:src</xsl:text>                                
                            </xsla:attribute>
                        </xsla:element>   
                    </xsla:if>
                </xslb:attribute>
                <xsla:apply-templates select="*"/>
            </div>            
                   
        </xsla:template>
    </xsl:template>
    
    <xsl:template match="text()"/>    
</xsl:stylesheet>