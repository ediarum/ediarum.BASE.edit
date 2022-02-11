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
    
    <!-- ## Pfad Personenregister -->
    <xsl:param name="p_registerPersons">
        <xsl:value-of select="$p_pathToRegister"/>
        <xsl:text>personen/detail.xql</xsl:text>
    </xsl:param>
    
    <!-- ## Pfad Orteregister -->
    <xsl:param name="p_registerPlaces">
        <xsl:value-of select="$p_pathToRegister"/>
        <xsl:text>orte/detail.xql</xsl:text>
    </xsl:param>
    
    <!-- ## Pfad Einrichtungsregister -->
    <xsl:param name="p_registerInstitutions">
        <xsl:value-of select="$p_pathToRegister"/>
        <xsl:text>institutionen/detail.xql</xsl:text>
    </xsl:param>
    
    <!-- ## Pfad Werkeregister -->
    <xsl:param name="p_registerBibls">
        <xsl:value-of select="$p_pathToRegister"/>
        <xsl:text>werke/detail.xql</xsl:text>
    </xsl:param>
    
    <!-- ## Pfad Sachbegriffsregister -->
    <xsl:param name="p_registerItems">
        <xsl:value-of select="$p_pathToRegister"/>
        <xsl:text>hoefe/detail.xql</xsl:text>
    </xsl:param>
    
    
    <!-- # Parameter Anpassungen -->
    <!-- Parameter zur weiteren Anpassung der Ausgabe. -->
    
    <!-- ## Einstellung Fußnoten: notesAsFootnotes - Erhält einen bool-Wert, ob Sachanmerkungen als Fußnoten (true) oder Endnoten (false) dargestellt werden. -->
    <xsl:param name="p_notesAsFootnotes" select="true()"/>
    
    <!-- ## Kennzeichnung Schreibakt: p_showWritingSession - Soll jeder Schreibakt mit einer Zwischenüberschrift "Schreibakt Nr. " begonnen werden? -->
    <xsl:param name="p_showWritingSession" select="true()"/>
    
    
    
    <!-- TEST -->
    <xsl:variable name="test">
        <test>
            <key1>VAL1</key1>
            <key2>VAL2</key2>
            <key3>VAL3</key3>
        </test>
    </xsl:variable>
    
    <!-- TEST ENDE -->
    
    
    
    
    
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

