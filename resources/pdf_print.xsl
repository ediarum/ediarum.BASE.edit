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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    <!-- Template-Definitionen -->
    
    <!-- ALTE DEFINITIONEN; KANN NACH ABSCHLUSS WEG!!!; SIEHE pdf_print_content_templates -->
    
    <!--

    
    <!-\- Register-Verknüpfung -\->
    <xsl:template mode="#all" match="tei:persName">
        <xsl:variable name="id">
            <xsl:value-of select="@key"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="@cert='low'">
                <span class="tooltip">
                    <span class="fussnote">
                        <span class="fussnotenpfeil"> </span>
                        <xsl:text>Identifizierung der Person unsicher</xsl:text>
                    </span>
                    <a href="https://xmledit.bbaw.de/ediarum/rest/db/projects/mop/web/register/personen/detail.xql?id={$id}">
                        <xsl:apply-templates mode="#current"/>
                    </a>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <a href="https://xmledit.bbaw.de/ediarum/rest/db/projects/mop/web/register/personen/detail.xql?id={$id}">
                    <xsl:apply-templates mode="#current"/>
                </a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template mode="#all" match="tei:orgName">
        <a href="https://xmledit.bbaw.de/ediarum/rest/db/projects/mop/web/register/institutionen/detail.xql?id={./@key}">
            <xsl:apply-templates mode="#current"/>
        </a>
    </xsl:template>
    <xsl:template mode="#all" match="tei:placeName">
        <a href="https://xmledit.bbaw.de/ediarum/rest/db/projects/mop/web/register/orte/detail.xql?id={./@key}">
            <xsl:apply-templates mode="#current"/>
        </a>
    </xsl:template>
        
    
    <!-\- ###Einführungstexte### -\->
    <xsl:template mode="comment" match="tei:head">
        <xsl:variable name="headid">
            <xsl:value-of select="count(preceding::tei:head)+1"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="@type='h2'">
                <h2 id="section{$headid}">
                    <xsl:apply-templates mode="#current"/>
                </h2>
            </xsl:when>
            <xsl:when test="@type='h3'">
                <h3 id="section{$headid}">
                    <xsl:apply-templates mode="#current"/>
                </h3>
            </xsl:when>
            <xsl:when test="@type='h4'">
                <h4 id="section{$headid}">
                    <xsl:apply-templates mode="#current"/>
                </h4>
            </xsl:when>
            <xsl:otherwise>
                <p style="color: red;">
                    <xsl:apply-templates mode="#current"/>
                </p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template mode="comment" match="tei:p">
        <p>
            <xsl:call-template name="paragraphNumber"/>
            <xsl:apply-templates mode="#current"/>
        </p>
    </xsl:template>
    <xsl:template name="paragraphNumber">
        <xsl:variable name="nr">
            <xsl:value-of select="count(preceding::tei:p[ancestor::tei:text and not(parent::tei:note)]) + 1"/>
        </xsl:variable>
        <span class="paragraphNumber" title="Absatznummer">
            <a name="{./@n}">
                <xsl:value-of select="$nr"/>
            </a>
        </span>
    </xsl:template>
    <xsl:template mode="comment" match="tei:p[.//tei:note[not(ancestor::tei:quote)]/@place='foot']">
        <p>
            <xsl:call-template name="paragraphNumber"/>
            <xsl:apply-templates mode="#current"/>
            <span class="footnoteContainer">
                <xsl:apply-templates select=".//tei:note[not(ancestor::tei:quote)]" mode="footnote"/>
            </span>
        </p>
    </xsl:template>
    <xsl:template mode="comment" match="tei:note[@place='foot' and matches(@xml:id, 'ftn')]">
        <span class="number">[<xsl:value-of select="@n"/>]</span>
    </xsl:template>
    <xsl:template mode="footnote" match="tei:note">
        <span class="footnote">
            <span class="number">[<xsl:value-of select="@n"/>]</span>
            <span id="{@n}" class="truncate" style="font-style: italic;">
                <xsl:apply-templates mode="comment"/>
            </span>
        </span>
    </xsl:template>
    <xsl:template mode="comment" match="tei:p[parent::tei:note/@place='foot']">
        <xsl:apply-templates mode="comment"/>
    </xsl:template>
    <xsl:template mode="comment" match="tei:author/tei:note">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    <xsl:template name="endnotes">
        <div id="endnotes">
            <h3>Anmerkungen</h3>
            <ul>
                <xsl:for-each select="//tei:text//tei:note">
                    <li id="endnote{@n}">
                        <span class="number">
                            <a href="#{@n}">[<xsl:value-of select="@n"/>]</a>
                        </span>
                        <xsl:apply-templates select="child::node()" mode="comment"/>
                    </li>
                </xsl:for-each>
            </ul>
        </div>
    </xsl:template>
    <xsl:template mode="comment" match="tei:quote">
        <p class="{@type}">
            <xsl:apply-templates mode="#current"/>
            <xsl:if test=".//tei:note">
                <span class="footnoteContainer">
                    <xsl:apply-templates select=".//tei:note" mode="footnote"/>
                </span>
            </xsl:if>
        </p>
    </xsl:template>-->
    
</xsl:stylesheet>