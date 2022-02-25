<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE stylesheet [
<!ENTITY nbsp  "&#160;" >
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:telota="http://www.telota.de"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="#all"
    version="2.0">
    
    <!-- # Allgemeine Einstellungen -->
    <xsl:strip-space elements="*"/>    
    <xsl:output method="html"/>
    <xsl:variable name="heute" select="fn:current-date()"/>
    <xsl:variable name="uhrzeit" select="fn:current-time()"/>
    
    <!-- # Einbinden der Stylesheets -->
    <xsl:import href="pdf_print_header.xsl"/>
    <xsl:import href="pdf_print_content_templates.xsl"/>

    <!-- # Parameter und globale Variablen -->
    <xsl:param name="p_showWritingSession"/>
    
    
    
    <!-- ####################################### -->
    <!-- ### Default - Template-Definitionen ### -->
    <!-- ####################################### -->
    
    <!-- # Struktur-Templates -->
    <!-- ## Struktur der Aufrufe für den Head -->
    <xsl:template name="ediarum_structure_head_default">
        <xsl:param name="placeOfNotes"/>
        
        <head>
            <meta name="author" content="Nadine Arndt, Jan Wierzoch"/>
            <meta name="description">
                <xsl:attribute name="content">
                    <xsl:text>PDF-Vorschau vom </xsl:text><xsl:value-of select="format-date($heute,'[D01].[M01].[Y0001]')"/>, <xsl:value-of select="format-time($uhrzeit,'[H01]:[m01]')"/>
                </xsl:attribute>
            </meta>
            <title><xsl:value-of select="//tei:titleStmt/tei:title"/></title>
        </head>
        
    </xsl:template>
    
    <!-- ## Struktur der Aufrufe für den Header -->
    <xsl:template name="ediarum_structure_header_default">
        <xsl:param name="placeOfNotes"/>
        
        <header>
            <xsl:call-template name="ediarum_headerTitle"/>
            <div class="headerInfo">
                <!-- ## ediarum.INTRO Autor*in -->
                <xsl:call-template name="ediarumIntro_author"/>
            </div>
            <div class="headerInfo">
                <!-- ## Informationen zum Vorhaben -->
                <xsl:call-template name="ediarum_headerEditor"/>
                <xsl:call-template name="ediarum_headerResp"/>
                <xsl:call-template name="ediarum_headerEditionStmt"/>
                <xsl:call-template name="ediarum_headerPublicationStmt"/>
            </div>
            <div class="headerInfo">
                <!-- ## Hinweise (noteStmt) -->
                <xsl:call-template name="ediarum_headerNote"/>
            </div>
            <div class="headerInfo">
                <!-- ## Informationen zur Herkunft -->
                <xsl:call-template name="ediarum_headerMsDesc"/>
            </div>
            <div class="contentInfo">
                <!-- ## Informationen zu Absender/Empfänger, Ort, Datum -->
                <xsl:choose>
                    <xsl:when test=".//tei:profileDesc/tei:correspDesc">
                        <xsl:call-template name="ediarum_headerCorresp"/>
                    </xsl:when>
                    <xsl:when test=".//tei:profileDesc/tei:creation">
                        <xsl:call-template name="ediarum_headerCreation"/>
                    </xsl:when>
                </xsl:choose>
                <xsl:call-template name="ediarum_headerAbstract"/>
                <xsl:call-template name="ediarum_headerKeywords"/>
            </div>
            <div class="revisionInfo">
                <!-- ## Informationen zum Bearbeitungsstatus und Änderungen -->
                <xsl:call-template name="ediarum_headerRevisionDesc"/>
            </div>
            <div class="facsimileInfo">
                <!-- ## Zugehörige Faksimiles -->
                <xsl:call-template name="ediarum_facsimile"/>
            </div>
            <hr/>
        </header>
        
    </xsl:template>
    
    <!-- ## Struktur der Aufrufe für den Content -->
    <xsl:template name="ediarum_structure_content_default">
        <xsl:param name="placeOfNotes"/>
        
            <div>
                <!-- ## Klasse des Inhalts-Div -->
                <xsl:attribute name="class">
                    <xsl:choose>
                        <xsl:when test=".//tei:text/@type">
                            <xsl:value-of select=".//tei:text/@type"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>content</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                
                <!-- ## Opener kann außerhalb von div stehen. -->
                <xsl:apply-templates select=".//tei:body/tei:opener">
                    <xsl:with-param name="placeOfNotes" tunnel="yes" select="$placeOfNotes"/>
                </xsl:apply-templates>
                
                <!-- ## Inhalt über jedes div aufrufen, ggf. Schreibakte -->
                <xsl:for-each select=".//tei:text/tei:body/tei:div">
                    <div class="textDiv">
                        
                        <!-- ### Ggf. Schreibakt (oder anderen Typ) ausgeben. -->
                        <xsl:if test="$p_showWritingSession = true()">
                            <xsl:call-template name="ediarum_contentWritingSession"/>
                        </xsl:if>
                        
                        <!-- ### Templates ausführen -->
                        <xsl:apply-templates select=".">
                            <xsl:with-param name="placeOfNotes" tunnel="yes" select="$placeOfNotes"/>
                        </xsl:apply-templates>
                        
                    </div>
                </xsl:for-each>
                
                <!-- ## Closer kann außerhalb von div stehen. -->
                <xsl:apply-templates select=".//tei:body/tei:closer">
                    <xsl:with-param name="placeOfNotes" tunnel="yes" select="$placeOfNotes"/>
                </xsl:apply-templates>
                
                <!-- ## Postscript kann außerhalb von div stehen -->
                <xsl:apply-templates select=".//tei:body/tei:postscript">
                    <xsl:with-param name="placeOfNotes" tunnel="yes" select="$placeOfNotes"/>
                </xsl:apply-templates>
            </div>
        
    </xsl:template>
    
</xsl:stylesheet>

