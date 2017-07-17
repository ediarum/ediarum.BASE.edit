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
along with ediarum.EDIT. If not, see <http://www.gnu.org/licenses/>.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:saxon="http://saxon.sf.net/" exclude-result-prefixes="saxon">
       
    <xsl:template match="tei:cb">
        <xsl:element name="cb" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:if test="@type!=''">
                <xsl:attribute name="type">
                    <xsl:value-of select="@type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@n!=''">
                <xsl:attribute name="n">
                    <xsl:value-of select="@n"/>
                </xsl:attribute>
            </xsl:if>
        </xsl:element>
    </xsl:template>
    
        
</xsl:stylesheet>