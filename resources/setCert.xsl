<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    <!-- persName -->
    
    <xsl:template match="tei:persName[not(@cert)]">
        <persName xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="cert">low</xsl:attribute>
            <xsl:attribute name="key"><xsl:value-of select="@key"/></xsl:attribute>
            <xsl:value-of select="./text()"/>            
        </persName>
    </xsl:template>
    
    <xsl:template match="tei:persName[@cert='low']">
        <persName xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="key"><xsl:value-of select="@key"/></xsl:attribute>
            <xsl:value-of select="./text()"/>            
        </persName>
    </xsl:template>
    
    <!-- placeName -->
    
    <xsl:template match="tei:placeName[not(@cert)]">
        <placeName xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="cert">low</xsl:attribute>
            <xsl:attribute name="key"><xsl:value-of select="@key"/></xsl:attribute>
            <xsl:value-of select="./text()"/>            
        </placeName>
    </xsl:template>
    
    <xsl:template match="tei:placeName[@cert='low']">
        <placeName xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="key"><xsl:value-of select="@key"/></xsl:attribute>
            <xsl:value-of select="./text()"/>            
        </placeName>
    </xsl:template>
    
</xsl:stylesheet>