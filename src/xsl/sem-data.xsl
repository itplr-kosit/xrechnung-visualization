<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xr="urn:ce.eu:en16931:2017:xoev-de:kosit:standard:xrechnung-1"
    exclude-result-prefixes="xs" version="2.0">

    <xsl:output indent="yes"/>

    <xsl:template match="/xr:invoice">
        <xsl:apply-templates select="node()"/>
    </xsl:template>

    <xsl:template match="xr:*[starts-with(@xr:id, 'BT')]">
        <xsl:element name="sem-data">
            <xsl:element name="type">term</xsl:element>
            <xsl:call-template name="sem-data-field">
                <xsl:with-param name="id" select="@xr:id"/>
                <xsl:with-param name="name" select="local-name()"/>
                <xsl:with-param name="src" select="./@xr:src"/>
                <xsl:with-param name="value" select="text()"/>
            </xsl:call-template>
            <xsl:element name="pos"><xsl:value-of select="../position()"/></xsl:element>
            <xsl:apply-templates select="element()"/>
        </xsl:element>
    </xsl:template>


    <xsl:template match="xr:*[starts-with(@xr:id, 'BG')]">
        <xsl:element name="sem-data">
            <xsl:element name="type">group</xsl:element>
            <xsl:call-template name="sem-data-field">
                <xsl:with-param name="id" select="@xr:id"/>
                <xsl:with-param name="name" select="local-name()"/>
                <xsl:with-param name="src" select="./@xr:src"/>
                <xsl:with-param name="value" select="''"/>
            </xsl:call-template>
            <xsl:apply-templates select="element()"/>
        </xsl:element>
    </xsl:template>

    <xsl:template name="sem-data-field">
        <xsl:param name="name" required="yes"/>
        <xsl:param name="id" required="yes"/>
        <xsl:param name="src" required="yes"/>
        <xsl:param name="value" required="yes"/>

        <xsl:element name="name">
            <xsl:value-of select="$name"/>
        </xsl:element>
        <xsl:element name="id">
            <xsl:value-of select="$id"/>
        </xsl:element>
        <xsl:element name="xpath">
            <xsl:value-of select="$src"/>
        </xsl:element>
        <xsl:element name="value">
            <xsl:value-of select="$value"/>
        </xsl:element>

    </xsl:template>

    <!--<xsl:template match="element()[starts-with(local-name(@id), 'BG')]">
    <xsl:value-of select="'group'"/>
</xsl:template>-->

</xsl:stylesheet>
