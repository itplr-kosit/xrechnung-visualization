<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xsla="http://example.com/xslt-alias"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:output indent="yes"/>
    
    <xsl:namespace-alias stylesheet-prefix="xsla" result-prefix="xsl"/>
    
    <xsl:template match="/">
        <xsla:stylesheet version="3.0">
            <xsla:mode on-no-match="shallow-copy"/> 
            <xsl:apply-templates/>
        </xsla:stylesheet>
    </xsl:template>
    
    <xsl:template match="*:model/*:definitions/*:term">        
        <xsla:template match="//div[@data-title='{@id}']">
            <div data-title="{@id}&#013;&#010;{./*:description}">
                <xsla:apply-templates select="@*[not(name()='data-title')]"/>
                <xsla:apply-templates select="*"/>
            </div>            
            
            <!--<xsla:comment>TermID: <xsl:value-of select="@ref"/></xsla:comment>
            <xsla:text><xsl:text>&#10;</xsl:text></xsla:text>-->            
            <!--<xsla:next-match/>-->
        </xsla:template>
    </xsl:template>
    
    <xsl:template match="text()"/>
    
</xsl:stylesheet>