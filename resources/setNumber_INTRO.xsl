<?xml version="1.0" encoding="UTF-8"?>
<!-- 
Copyright 2019 Berlin-Brandenburg Academy of Sciences and Humanities

This file is part of ediarum.INTRO.

ediarum.INTRO is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published 
by the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

ediarum.INTRO is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with ediarum.INTRO. If not, see <http://www.gnu.org/licenses/>.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"    
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:saxon="http://saxon.sf.net/" exclude-result-prefixes="saxon"
    version="2.0">
    
    
    
    <xsl:template match="@*|node()">
        <xsl:copy><xsl:apply-templates select="@*|node()" /></xsl:copy>
    </xsl:template>
    
       
    <xsl:template match="tei:p[parent::div]">
        <xsl:variable name="cur-id">
            <xsl:number level="any" from="tei:body" count="tei:p[parent::div]"/>
        </xsl:variable>
        <xsl:variable name="new-xml-id" select="concat('p', format-number($cur-id, '0000'))"/>
        <xsl:copy>
            <xsl:copy-of select="@* except (@xml:id, @n)"/>
            <xsl:attribute name="xml:id" select="$new-xml-id"/>
            <xsl:attribute name="n" select="$cur-id"/>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:div//tei:note">
        <xsl:variable name="cur-id">
            <xsl:number level="any" from="tei:body"/>
        </xsl:variable>
        <xsl:variable name="new-xml-id" select="concat('ftn', format-number($cur-id, '0000'))"/>
        <xsl:copy>
            <xsl:copy-of select="@* except (@xml:id, @n)"/>
            <xsl:attribute name="xml:id" select="$new-xml-id"/>
            <xsl:attribute name="n" select="$cur-id"/>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
    
    
</xsl:stylesheet>