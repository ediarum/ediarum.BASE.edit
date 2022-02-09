<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:telota="http://www.telota.de"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="#all"
    version="2.0">
    
    
    <!-- pdf_print_content_functions.xsl - Sammlung der Funktionen, die die Elemente im Text verarbeiten.          -->
    <!--                                   Werden in den Templates von pdf_print_content_functions.xsl aufgerufen. -->
    
    
    <!-- ############################ -->
    <!-- ### Content - Funktionen ### -->
    <!-- ############################ -->
    
    <!-- # drawCell - Ausgabe einer Tabellenzelle, prüft vorher entsprechende Attribute und verarbeitet diese ggf. -->
    <xsl:function name="telota:drawCell">
        <xsl:param name="node"/>
        
        <xsl:choose>
            <xsl:when test="$node/@cols and $node/@rows">
                <xsl:attribute name="colspan">
                    <xsl:value-of select="$node/@cols"/>
                </xsl:attribute>
                <xsl:attribute name="rowspan">
                    <xsl:value-of select="$node/@rows"/>
                </xsl:attribute>
            </xsl:when>
            <xsl:when test="$node/@cols">
                <xsl:attribute name="colspan">
                    <xsl:value-of select="$node/@cols"/>
                </xsl:attribute>
            </xsl:when>
            <xsl:when test="$node/@rows">
                <xsl:attribute name="rowspan">
                    <xsl:value-of select="$node/@rows"/>
                </xsl:attribute>
            </xsl:when>
        </xsl:choose>
        
        <xsl:if test="$node/@rendition='#right'">
            <xsl:attribute name="class">
                <xsl:text>alignRight</xsl:text>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="$node/@role='sum'">
            <xsl:attribute name="style">
                border-top: double;
            </xsl:attribute>
        </xsl:if>
        
    </xsl:function>
    
    <!-- # Funktionen Fußnoten/Kritischer Apparat -->
    <!-- ## createFootnote - Nimmt Node als Parameter, gibt diese Node in footnote-Class (für Print CSS) zurück. -->
    <xsl:function name="telota:createFootnote">
        <xsl:param name="node"/>
        <span class="footnote">
            <xsl:apply-templates select="$node"/>
        </span>
    </xsl:function>
    
    <!-- ## endnoteAtEnd - Referenzzeichen (Buchstabe; aus Parameter criticalAppCounter) in den Endnoten -->
    <xsl:function name="telota:endnoteAtEnd">
        <xsl:param name="criticalAppCounter"/>
        <a>
            <xsl:attribute name="name">
                <xsl:text>criticalAppRef_</xsl:text><xsl:value-of select="$criticalAppCounter"/>
            </xsl:attribute>
            <xsl:attribute name="href">
                <xsl:text>#criticalApp_</xsl:text><xsl:value-of select="$criticalAppCounter"/>
            </xsl:attribute>
            <xsl:value-of select="$criticalAppCounter"/>
        </a>
        <xsl:text> </xsl:text>
    </xsl:function>
    
    <!-- ## endnoteInText - Im Fließtext hochgestelltes Referenzzeichen (Buchstabe; aus Parameter criticalAppCounter) auf Endnote. -->
    <xsl:function name="telota:endnoteInText">
        <xsl:param name="criticalAppCounter"/>
        <a>
            <xsl:attribute name="name">
                <xsl:text>criticalAppRef_</xsl:text><xsl:value-of select="$criticalAppCounter"/>
            </xsl:attribute>
            <xsl:attribute name="href">
                <xsl:text>#criticalApp_</xsl:text><xsl:value-of select="$criticalAppCounter"/>
            </xsl:attribute>
            <span class="sup"><xsl:value-of select="$criticalAppCounter"/><xsl:text> </xsl:text></span>
        </a>
    </xsl:function>
    
    
    <!-- # Funktionen Verarbeitung Sachanmerkungen in Fußnoten/Kritischem Apparat -->
    <!-- ## ediarum_noteContent_noteFoot - Ausgabe Fußnote von Hinweisen in Fußnoten (tei:note[@place='foot']) -->
    <xsl:function name="telota:ediarum_noteContent_noteFoot">
        <xsl:param name="node"/>
        
        <xsl:apply-templates select="$node/node()"/>
        
    </xsl:function>
    
    <!-- ## ediarum_noteContent_seg - Ausgabe Fußnote von Sachanmerkungen (tei:seg) -->
    <xsl:function name="telota:ediarum_noteContent_seg">
        <xsl:param name="node"/>
        
        <xsl:apply-templates select="$node/tei:note"/>
        
    </xsl:function> 
    
    <!-- # Funktionen Verarbeitung Bearbeitungsanmerkungen in Fußnoten/Kritischem Apparat -->
    <!-- ## ediarum_noteContent_add - Ausgabe Fußnote von Hinzufügungen (tei:add) -->
    <xsl:function name="telota:ediarum_noteContent_add">
        <xsl:param name="node"/>
        
        <xsl:choose>
            <xsl:when test="$node[@place = 'superlinear']">
                <xsl:text>über der Zeile eingetragen</xsl:text>
            </xsl:when>
            <xsl:when test="$node[@place = 'sublinear']">
                <xsl:text>unter der Zeile eingetragen</xsl:text>
            </xsl:when>
            <xsl:when test="$node[@place = 'intralinear']">
                <xsl:text>innerhalb der Zeile eingetragen</xsl:text>
            </xsl:when>
            <xsl:when test="$node[@place = 'across']">
                <xsl:text>über den ursprünglichen Text geschrieben</xsl:text>
            </xsl:when>
            <xsl:when test="$node[@place = 'left']">
                <xsl:text>am linken Rand eingetragen</xsl:text>
            </xsl:when>
            <xsl:when test="$node[@place = 'right']">
                <xsl:text>am rechten Rand eingetragen</xsl:text>
            </xsl:when>
            <xsl:when test="$node[@place = 'mTop']">
                <xsl:text>am oberen Rand eingetragen</xsl:text>
            </xsl:when>
            <xsl:when test="$node[@place = 'mBottom']">
                <xsl:text>am unteren Rand eingetragen</xsl:text>
            </xsl:when>
        </xsl:choose>
        
    </xsl:function>
    
    <!-- ## ediarum_noteContent_choice - Ausgabe Fußnote von Herausgeberkorrekturen (tei:choice) -->
    <xsl:function name="telota:ediarum_noteContent_choice">
        <xsl:param name="node"/>
        
        <xsl:choose>
            <!-- ### Abkürzungsauflösung -->
            <xsl:when test="$node[tei:abbr]">
                <xsl:text>Abkürzung durch Herausgeber aufgelöst.</xsl:text>
            </xsl:when>
            <!-- ### Korrektur -->
            <xsl:when test="$node[tei:corr]">
                <xsl:text>Korrektur durch Herausgeber</xsl:text>
                <xsl:choose>
                    <xsl:when test="$node[tei:corr/@type='deleted']">
                        <xsl:text> mittels Streichung</xsl:text>
                    </xsl:when>
                    <xsl:when test="$node[tei:corr/@cert='high']">
                        <xsl:text> mit hoher Wahrscheinlichkeit</xsl:text>
                    </xsl:when>
                    <xsl:when test="$node[tei:corr/@cert='medium']">
                        <xsl:text> mit mittlerer Wahrscheinlichkeit</xsl:text>
                    </xsl:when>
                    <xsl:when test="$node[tei:corr/@cert='low']">
                        <xsl:text> mit geringer Wahrscheinlichkeit</xsl:text>
                    </xsl:when>
                </xsl:choose>
                <xsl:text>.</xsl:text>
            </xsl:when>
            <!-- ### Normalisierung -->
            <xsl:when test="$node[tei:orig]">
                <xsl:text>Durch Herausgeber normalisierte Schreibung.</xsl:text>
            </xsl:when>
        </xsl:choose>
        
    </xsl:function>
    
    <!-- ## ediarum_noteContent_del - Ausgabe Fußnote von Streichung (tei:del) -->
    <xsl:function name="telota:ediarum_noteContent_del">
        <xsl:param name="node"/>
        
        <xsl:choose>
            <xsl:when test="$node[@rendition = '#s']">
                <xsl:text>Tilgung durch Streichung</xsl:text>
            </xsl:when>
            <xsl:when test="$node[@rendition = '#ow']">
                <xsl:text>Tilgung durch Überschreibung des ursprünglichen Textes</xsl:text>
            </xsl:when>
            <xsl:when test="$node[@rendition = '#erased']">
                <xsl:text>Tilgung durch Radieren</xsl:text>
            </xsl:when>
        </xsl:choose>
        
    </xsl:function>
    
    <!-- ## ediarum_noteContent_gap - Ausgabe Fußnote von Schäden (tei:gap) -->
    <xsl:function name="telota:ediarum_noteContent_gap">
        <xsl:param name="node"/>
        
        <xsl:text>Schadhafte Passage</xsl:text>
        <xsl:choose>
            <xsl:when test="$node[@reason = 'lost']">
                <xsl:text>; Grund: Verlust</xsl:text>
            </xsl:when>
            <xsl:when test="$node[@reason = 'illegible']">
                <xsl:text>; Grund: unleserlich</xsl:text>
            </xsl:when>
            <xsl:when test="$node[@reason = 'covered']">
                <xsl:text>; Grund: schwer leserlich duch Überschreibung</xsl:text>
            </xsl:when>
            <xsl:when test="$node[@reason = 'empty']">
                <xsl:text>; Grund: Leerraum</xsl:text>
            </xsl:when>
            <xsl:when test="$node[@reason = 'fm']">
                <xsl:text>; Grund: fremdsprachlicher Text</xsl:text>
            </xsl:when>
            <xsl:when test="$node[@reason = 'insignificant']">
                <xsl:text>; Grund: Für das Korpus unwichtiger Text</xsl:text>
            </xsl:when>
        </xsl:choose>
        <xsl:if test="$node[@unit and @quantity]">
            <xsl:choose>
                <xsl:when test="$node[@unit = 'chars']">
                    <xsl:text>; Umfang: </xsl:text>
                    <xsl:value-of select="$node/@quantity/data()"/>
                    <xsl:text> Zeichen</xsl:text>
                </xsl:when>
                <xsl:when test="$node[@unit = 'lines']">
                    <xsl:text>; Umfang: </xsl:text>
                    <xsl:value-of select="$node/@quantity/data()"/>
                    <xsl:text> Zeilen</xsl:text>
                </xsl:when>
                <xsl:when test="$node[@unit = 'words']">
                    <xsl:text>; Umfang: </xsl:text>
                    <xsl:value-of select="$node/@quantity/data()"/>
                    <xsl:text> Wörter</xsl:text>
                </xsl:when>
                <xsl:when test="$node[@unit = 'pages']">
                    <xsl:text>; Umfang: </xsl:text>
                    <xsl:value-of select="$node/@quantity/data()"/>
                    <xsl:text> Seiten</xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:if>        
        
    </xsl:function>
    
    <!-- ## ediarum_noteContent_note - Ausgabe Fußnote von Anmerkungen (tei:note) -->
    <xsl:function name="telota:ediarum_noteContent_note">
        <xsl:param name="node"/>
        
        <xsl:text>Anmerkung</xsl:text>
        <xsl:choose>
            <xsl:when test="$node[@place='right']">
                <xsl:text> am rechten Rand</xsl:text>
            </xsl:when>
            <xsl:when test="$node[@place='left']">
                <xsl:text> am linken Rand</xsl:text>
            </xsl:when>
            <xsl:when test="$node[@place='mTop']">
                <xsl:text> am oberen Rand</xsl:text>
            </xsl:when>
            <xsl:when test="$node[@place='mBottom']">
                <xsl:text> am unteren Rand</xsl:text>
            </xsl:when>
            <xsl:when test="$node[@place='inline']">
                <xsl:text> innerhalb der Zeile</xsl:text>
            </xsl:when>
        </xsl:choose>
        <xsl:if test="$node[@hand]">
            <xsl:text> durch </xsl:text>
        </xsl:if>
        <xsl:choose>
            <xsl:when test="$node[@hand='#author']">
                <xsl:text>Autor dieses Textes</xsl:text>
            </xsl:when>
            <xsl:when test="$node[@hand='#addressee']">
                <xsl:text>Empfänger des Briefes</xsl:text>
            </xsl:when>
            <xsl:when test="$node[@hand='#index']">
                <xsl:text>Person aus dem Register: </xsl:text>
                <xsl:value-of select="$node/@hand/data()"/>
            </xsl:when>
            <xsl:when test="$node[@hand='#unknown']">
                <xsl:text>unbekannten Schreiber</xsl:text>
            </xsl:when>
        </xsl:choose>
        
    </xsl:function>
    
    <!-- ## ediarum_noteContent_reg_bibl - Ausgabe Fußnote eines Werkregistereintrags (tei:bibl) -->
    <xsl:function name="telota:ediarum_noteContent_reg_bibl">
        <xsl:param name="node"/>
        <xsl:param name="pathToRegister"/>
        
        <xsl:value-of select="$node"/>
        <xsl:text> (</xsl:text>
        <xsl:value-of select="$pathToRegister"/>
        <xsl:text>)</xsl:text>
        
    </xsl:function>

    
    <!-- ## ediarum_noteContent_reg_item - Ausgabe Fußnote eines Sachregistereintrags (tei:item) -->
    <xsl:function name="telota:ediarum_noteContent_reg_item">
        <xsl:param name="node"/>
        <xsl:param name="pathToRegister"/>
        
        <xsl:variable name="registerType">
            <xsl:text>hoefe</xsl:text>
        </xsl:variable>
        
        <xsl:variable name="key">
            <xsl:value-of select="$node/@key/data()"/>
        </xsl:variable>
        
        <xsl:variable name="linkToRegister">
            <xsl:value-of select="$pathToRegister||$registerType||'/detail.xql?id='||$key"/>
        </xsl:variable>
        
        <xsl:text>Sachregister: </xsl:text>
        <a class="regLink" href="{$linkToRegister}"><xsl:value-of select="$key"/></a>
        
    </xsl:function>
    
    <!-- ## ediarum_noteContent_reg_orgName - Ausgabe Fußnote eines Institutionenregistereintrags (tei:orgName) -->
    <xsl:function name="telota:ediarum_noteContent_reg_orgName">
        <xsl:param name="node"/>
        <xsl:param name="pathToRegister"/>
        
        <xsl:variable name="registerType">
            <xsl:text>institutionen</xsl:text>
        </xsl:variable>
        
        <xsl:variable name="key">
            <xsl:value-of select="$node/@key/data()"/>
        </xsl:variable>
        
        <xsl:variable name="linkToRegister">
            <xsl:value-of select="$pathToRegister||$registerType||'/detail.xql?id='||$key"/>
        </xsl:variable>
        
        <xsl:text>Institution: </xsl:text>
        <a class="regLink" href="{$linkToRegister}"><xsl:value-of select="$key"/></a>
        
    </xsl:function>
    
    <!-- ## ediarum_noteContent_reg_persName - Ausgabe Fußnote eines Personenregistereintrags (tei:persName) -->
    <xsl:function name="telota:ediarum_noteContent_reg_persName">
        <xsl:param name="node"/>
        <xsl:param name="pathToRegister"/>
        
        <xsl:variable name="registerType">
            <xsl:text>personen</xsl:text>
        </xsl:variable>
        
        <xsl:variable name="key">
            <xsl:value-of select="$node/@key/data()"/>
        </xsl:variable>
        
        <xsl:variable name="linkToRegister">
            <xsl:value-of select="$pathToRegister||$registerType||'/detail.xql?id='||$key"/>
        </xsl:variable>
        
        <xsl:if test="$node[@cert='low']">
            <xsl:text>Identifizierung der Person unsicher; </xsl:text>
        </xsl:if>
        
        <xsl:text>Person: </xsl:text>
        <a class="regLink" href="{$linkToRegister}"><xsl:value-of select="$key"/></a>
        
    </xsl:function>
    
    <!-- ## ediarum_noteContent_reg_placeName - Ausgabe Fußnote eines Ortsregistereintrags (tei:placeName) -->
    <xsl:function name="telota:ediarum_noteContent_reg_placeName">
        <xsl:param name="node"/>
        <xsl:param name="pathToRegister"/>
        
        <xsl:variable name="registerType">
            <xsl:text>orte</xsl:text>
        </xsl:variable>
        
        <xsl:variable name="key">
            <xsl:value-of select="$node/@key/data()"/>
        </xsl:variable>
        
        <xsl:variable name="linkToRegister">
            <xsl:value-of select="$pathToRegister||$registerType||'/detail.xql?id='||$key"/>
        </xsl:variable>
        
        <xsl:text>Ort: </xsl:text>
        <a class="regLink" href="{$linkToRegister}"><xsl:value-of select="$key"/></a>
        
    </xsl:function>
    
    <!-- ## ediarum_noteContent_unclear - Ausgabe Fußnote von Unleserlich (tei:unclear) -->
    <xsl:function name="telota:ediarum_noteContent_unclear">
        <xsl:param name="node"/>
        
        <xsl:choose>
            <xsl:when test="$node[@reason = 'illegible']">
                <xsl:text>Handschrift unleserlich</xsl:text>
            </xsl:when>
            <xsl:when test="$node[@reason = 'covered']">
                <xsl:text>Text überschrieben</xsl:text>
            </xsl:when>
        </xsl:choose>
        <xsl:if test="$node[@reason and @cert]">
            <xsl:text>; </xsl:text>
        </xsl:if>
        <xsl:choose>
            <xsl:when test="$node[@cert = 'high']">
                <xsl:text>hohe Wahrscheinlichkeit</xsl:text>
            </xsl:when>
            <xsl:when test="$node[@cert = 'low']">
                <xsl:text>niedrige Wahrscheinlichkeit</xsl:text>
            </xsl:when>
        </xsl:choose>
        
    </xsl:function>
        
</xsl:stylesheet>