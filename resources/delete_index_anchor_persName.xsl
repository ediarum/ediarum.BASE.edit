<?xml version="1.0" encoding="UTF-8"?>
<!-- 
Copyright 2013 Berlin-Brandenburg Academy of Sciences and Humanities

This file is part of ediarum.FS.

ediarum.FS is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published 
by the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

ediarum.FS is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with ediarum.FS. If not, see <http://www.gnu.org/licenses/>.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns:saxon="http://saxon.sf.net/" exclude-result-prefixes="saxon">
    
    <xsl:param name="currentElementLocation"/>
    
    <!-- Versuchs-XSLT, um persName und index sowie spanTo gleichzeitig zu löschen -->
    
    <!-- Personen-ID aus aktuellem persName beziehen, wo der Corsor derzeit stehen soll -->
    <xsl:variable name="key"><xsl:value-of select="saxon:eval(saxon:expression($currentElementLocation))/@key"/></xsl:variable>
    <!-- Vorangehendes Indexelement mit @corresp=key identifizieren und spanTo abgreifen -->
    <xsl:variable name="spanTo"><xsl:value-of select="saxon:eval(saxon:expression($currentElementLocation))/ancestor-or-self::persName/preceding::index[@corresp/substring-after(., '#')=$key]/@spanTo"/></xsl:variable>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Index löschen, wenn xml:id übereinstimmt, ansonsten auch kopieren -->
    <xsl:template match="index">
        <xsl:choose>
            <xsl:when test="./@spanTo=$spanTo">
                
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                   <xsl:apply-templates select="@*|node()" />
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Anchor löschen, wenn xml:id übereinstimmt, ansonsten auch kopieren -->
    <xsl:template match="anchor">
        <xsl:choose>
            <xsl:when test="./@xml:id=substring-after($spanTo, '#')">
                
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@*|node()" />
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- aktuelles persName müsste gelöscht werden - wie? -->
     
</xsl:stylesheet>