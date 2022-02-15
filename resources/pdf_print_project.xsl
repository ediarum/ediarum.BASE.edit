<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:telota="http://www.telota.de"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="#all"
    version="2.0">
    
    
    <!-- ########################### -->
    <!-- ### Project - Parameter ### -->
    <!-- ########################### -->
    
    <!-- Parameter werden bei Transformation entgegengenommen und als Variablen zur Verfügung gestellt.
        Können so projektspezifisch angepasst werden, ohne das BASE-XSLT "pdf_print.xsl" ändern zu müssen. -->
    
    <!-- # Parameter Quellen -->
    <!-- Welche XSLTs werden genutzt. -->
    
    <!-- ## Head-Template (Default/Projekt) -->
    <xsl:param name="p_structureHeadDefault">
        <xsl:value-of select="true()"/>
    </xsl:param>
    
    <!-- ## Header-Template (Default/Projekt) -->
    <xsl:param name="p_structureHeaderDefault">
        <xsl:value-of select="true()"/>
    </xsl:param>
    
    <!-- ## Content-Template (Default/Projekt) -->
    <xsl:param name="p_structureContentDefault">
        <xsl:value-of select="true()"/>
    </xsl:param>
    
    
    
    <!-- Parameter Verbindungen -->
    <!-- Welche Verbindungen in die DB (data, register, ...) werden genutzt. -->
    
    <!-- ## Datenbankverbindung -->
    <!-- TODO: Fallback definieren -->
    <xsl:param name="p_pathToProject">
        <xsl:text>https://xmledit.bbaw.de/mop/rest/db/projects/mop/</xsl:text>
        <!-- ${ediarum_project_domain}${ediarum_projects_directory}${ediarum_project_name} -->
    </xsl:param>
    
    <!-- ## Registerdaten -->
    <!-- ### dataFromRegister -->
    <xsl:param name="p_dataFromRegister">
        <xsl:value-of select="$p_pathToProject"/>
        <xsl:text>data/Register/</xsl:text>
    </xsl:param>
    
    <!-- ## Registerlink -->
    <!-- ### pathToRegister - Erhält den Pfad zum projektspezifischen Register. -->
    <xsl:param name="p_pathToRegister">
        <xsl:value-of select="$p_pathToProject"/>
        <xsl:text>web/register/</xsl:text>
    </xsl:param>
    
    <!-- ### project_getRegisterLink - Gibt den Link ins jeweilige Register aus. (In Projekt-XSLT definiert, damit leicht anpassbar.) -->
    <xsl:function name="telota:project_getRegisterLink">
        <xsl:param name="node"/>
        
        <xsl:variable name="registerMapWeb">
            <register>
                <pers>
                    <dir>personen/detail.xql</dir>
                    <desc>Person</desc>
                </pers>
                <place>
                    <dir>orte/detail.xql</dir>
                    <desc>Ort</desc>
                </place>
                <org>
                    <dir>institutionen/detail.xql</dir>
                    <desc>Institution</desc>
                </org>
                <bibl>
                    <dir>werke/detail.xql</dir>
                    <desc>Werk</desc>
                </bibl>
                <item>
                    <dir>hoefe/detail.xql</dir>
                    <desc>Sachregister</desc>
                </item>
            </register>
        </xsl:variable>        
        
        <xsl:variable name="registerType">
            <xsl:choose>
                <xsl:when test="$node[self::tei:persName]">
                    <xsl:copy-of select="$registerMapWeb/register/pers"/>
                </xsl:when>
                <xsl:when test="$node[self::tei:placeName]">
                    <xsl:copy-of select="$registerMapWeb/register/place"/>
                </xsl:when>
                <xsl:when test="$node[self::tei:orgName]">
                    <xsl:copy-of select="$registerMapWeb/register/org"/>
                </xsl:when>
                <xsl:when test="$node[self::tei:bibl]">
                    <xsl:copy-of select="$registerMapWeb/register/bibl"/>
                </xsl:when>
                <xsl:when test="$node[self::tei:item]">
                    <xsl:copy-of select="$registerMapWeb/register/item"/>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="key">
            <xsl:value-of select="$node/@key/data()"/>
        </xsl:variable>
        
        <xsl:variable name="linkToRegister">
            <xsl:value-of select="$p_pathToRegister"/>
            <xsl:value-of select="$registerType//dir/text()"/>
            <xsl:text>?id=</xsl:text>
            <xsl:value-of select="$key"/>
        </xsl:variable>
        
        <xsl:value-of select="$registerType//desc/text()"/><xsl:text>: </xsl:text>
        <a class="regLink" href="{$linkToRegister}"><xsl:value-of select="$key"/></a>
        
    </xsl:function>
    
    
    
    
    
    <!-- # Parameter Anpassungen -->
    <!-- Parameter zur weiteren Anpassung der Ausgabe. -->
    
    <!-- ## Einstellung Fußnoten: notesAsFootnotes - Erhält einen bool-Wert, ob Sachanmerkungen als Fußnoten (true) oder Endnoten (false) dargestellt werden. -->
    <xsl:param name="p_notesAsFootnotes" select="true()"/>
    
    <!-- ## Kennzeichnung Schreibakt: p_showWritingSession - Soll jeder Schreibakt mit einer Zwischenüberschrift "Schreibakt Nr. " begonnen werden? -->
    <xsl:param name="p_showWritingSession" select="true()"/>
    
    
    
    
    
    
    <!-- ############################ -->
    <!-- ### Project - Funktionen ### -->
    <!-- ############################ -->
    



    <!-- ####################################### -->
    <!-- ### Project - Template-Definitionen ### -->
    <!-- ####################################### -->
    
    <xsl:template name="ediarum_structure_head_project">
        <xsl:param name="placeOfNotes"/>
        
    </xsl:template>
    
    <xsl:template name="ediarum_structure_header_project">
        <xsl:param name="placeOfNotes"/>
        
    </xsl:template>
    
    <xsl:template name="ediarum_structure_content_project">
        <xsl:param name="placeOfNotes"/>
                
    </xsl:template>
    
    
    
</xsl:stylesheet>

