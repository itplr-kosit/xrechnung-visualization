<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xr="urn:ce.eu:en16931:2017:xoev-de:kosit:standard:xrechnung-1"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template name="text">
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template name="date">
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template name="identifier">      
        <xsl:if test="@listID | @schemeID">
            <xsl:attribute name="scheme_identifier" select="(@listID, @schemeID)[1]"/>
        </xsl:if>
        <xsl:if test="@schemeVersionID | @listVersionID">
            <xsl:attribute name="scheme_version_identifier"
                select="(@listVersionID, @schemeVersionID)[1]"/>
        </xsl:if>
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template name="code">
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template name="amount">
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template name="percentage">
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template name="binary_object">
        <xsl:if test="@mimeCode">
            <xsl:attribute name="mime_code">
                <xsl:value-of select="@mimeCode"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="@filename">
            <xsl:attribute name="filename">
                <xsl:value-of select="@filename"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template name="unit_price_amount">
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template name="quantity">
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template name="document_reference">
        <xsl:value-of select="."/>
    </xsl:template>
    <xd:doc>
        <xd:desc> Liefert einen XPath-Pfad, welches $n eindeutig identifiziert. </xd:desc>
        <xd:param name="n"/>
    </xd:doc>
    <xsl:function name="xr:src-path" as="xs:string">
        <xsl:param name="n" as="node()"/>
        <xsl:variable name="segments" as="xs:string*">
            <xsl:apply-templates select="$n" mode="xr:src-path"/>
        </xsl:variable>
        <xsl:sequence select="string-join($segments, '')"/>
    </xsl:function>
    <xd:doc>
        <xd:desc> Liefert einen XPath-Pfad, welches $n eindeutig identifiziert. </xd:desc>
        <xd:param name="n"/>
    </xd:doc>
    <xsl:template match="node() | @*" mode="xr:src-path">
        <xsl:for-each select="ancestor-or-self::*">
            <xsl:text>/</xsl:text>
            <xsl:value-of select="name(.)"/>
            <xsl:if test="preceding-sibling::*[name(.) = name(current())] or following-sibling::*[name(.) = name(current())]">
                <xsl:text>[</xsl:text>
                <xsl:value-of select="count(preceding-sibling::*[name(.) = name(current())]) + 1"/>
                <xsl:text>]</xsl:text>
            </xsl:if>
        </xsl:for-each>
        <xsl:if test="not(self::*)">
            <xsl:text/>/@<xsl:value-of select="name(.)"/>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>