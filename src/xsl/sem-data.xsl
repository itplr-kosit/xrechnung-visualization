<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xr="urn:ce.eu:en16931:2017:xoev-de:kosit:standard:xrechnung-1"
    exclude-result-prefixes="xs" version="2.0">

    <xsl:output indent="yes"/>



    <xsl:param name="value-uri" select="'display-labels_de.xml'"/>
    <xsl:variable name="label-doc" select="document($value-uri)"/>
    
    <xsl:key name="label" match="entry" use="lower-case(@key)"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="/xr:invoice">
        <xsl:element name="sdf">
            <xsl:apply-templates select="node()"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="xr:*[starts-with(@xr:id, 'BT')]">
        <xsl:call-template name="sem-data-field">
            <xsl:with-param name="type" select="'term'"/>
            <xsl:with-param name="id" select="@xr:id"/>
            <xsl:with-param name="name" select="local-name()"/>
            <xsl:with-param name="src" select="./@xr:src"/>
            <xsl:with-param name="value" select="text()"/>
        </xsl:call-template>

    </xsl:template>


    <xsl:template match="xr:*[starts-with(@xr:id, 'BG')]">

        <xsl:call-template name="sem-data-field">
            <xsl:with-param name="type" select="'group'" as="xs:string"/>
            <xsl:with-param name="id" select="@xr:id"/>
            <xsl:with-param name="name" select="local-name()"/>
            <xsl:with-param name="src" select="./@xr:src"/>
            <xsl:with-param name="value" select="''"/>
        </xsl:call-template>
        <!--<xsl:apply-templates select="element()"/>-->

    </xsl:template>

    <xsl:template name="sem-data-field">
        <xsl:param name="type" required="yes" as="xs:string"/>
        <xsl:param name="name" required="yes" as="xs:string"/>
        <xsl:param name="id" required="yes" as="xs:string"/>
        <xsl:param name="src" required="yes" as="xs:string"/>
        <xsl:param name="value" required="yes" as="xs:string"/>
        <xsl:param name="data-type" select="'unknown'" as="xs:string"></xsl:param>
        <xsl:element name="sem-data">
            <xsl:element name="structure-type">
                <xsl:value-of select="$type"/>
            </xsl:element>
            <xsl:element name="name">
                <xsl:value-of select="replace($name, '_', ' ')"/>
            </xsl:element>
            <xsl:element name="id">
                <xsl:value-of select="$id"/>
            </xsl:element>
            <xsl:element name="display-label"><xsl:value-of select="key('label', lower-case($id), $label-doc)"/></xsl:element>
            <xsl:element name="xpath">
                <xsl:value-of select="$src"/>
            </xsl:element>
            <xsl:element name="semantic-data-type">
                <xsl:value-of select="$data-type"/>
            </xsl:element>
            <xsl:element name="value">
                <xsl:value-of select="$value"/>
            </xsl:element>
            <xsl:element name="parent-group">
                <xsl:value-of select="../@xr:id"/>
            </xsl:element>
            <xsl:apply-templates select="element()"/>
        </xsl:element>
    </xsl:template>


</xsl:stylesheet>
