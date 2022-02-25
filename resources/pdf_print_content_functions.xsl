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
        <span>
            <xsl:attribute name="name">
                <xsl:text>criticalAppRef_</xsl:text><xsl:value-of select="$criticalAppCounter"/>
            </xsl:attribute>
            <xsl:attribute name="href">
                <xsl:text>#criticalApp_</xsl:text><xsl:value-of select="$criticalAppCounter"/>
            </xsl:attribute>
            <span class="endnote">
                <xsl:value-of select="$criticalAppCounter"/>
                <xsl:text>)</xsl:text>
            </span>
        </span>
        <xsl:text> </xsl:text>
    </xsl:function>
    
    <!-- ## endnoteInText - Im Fließtext hochgestelltes Referenzzeichen (Buchstabe; aus Parameter criticalAppCounter) auf Endnote. -->
    <xsl:function name="telota:endnoteInText">
        <xsl:param name="criticalAppCounter"/>
        <span>
            <xsl:attribute name="name">
                <xsl:text>criticalAppRef_</xsl:text><xsl:value-of select="$criticalAppCounter"/>
            </xsl:attribute>
            <xsl:attribute name="href">
                <xsl:text>#criticalApp_</xsl:text><xsl:value-of select="$criticalAppCounter"/>
            </xsl:attribute>
            <span class="sup"><xsl:value-of select="$criticalAppCounter"/><xsl:text> </xsl:text></span>
        </span>
    </xsl:function>
    
    
    <!-- # Funktionen Verarbeitung Sachanmerkungen in Fußnoten/Kritischem Apparat -->
    <!-- ## ediarum_noteContent_anchor - Ausgabe des referenzierten Index-Elements (tei:index/tei:term) eines Ankers (tei:anchor). -->
    <xsl:function name="telota:ediarum_noteContent_anchor">
        <xsl:param name="node"/>
        
        <xsl:value-of select="$node//ancestor::node()//tei:index[contains(@spanTo, $node/@xml:id)]/tei:term"/>
        
    </xsl:function>
    
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
        
        <xsl:apply-templates select="$node"/>
        <xsl:text>] </xsl:text>
        <span class="additionLabel">
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
        </span>
        
    </xsl:function>
    
    <!-- ## ediarum_noteContent_choice - Ausgabe Fußnote von Herausgeberkorrekturen (tei:choice) -->
    <xsl:function name="telota:ediarum_noteContent_choice">
        <xsl:param name="node"/>
        
        <xsl:choose>
            <!-- ### Abkürzungsauflösung -->
            <xsl:when test="$node[tei:abbr]">
                <xsl:text>Abkürzung durch Herausgeber aufgelöst.</xsl:text>
            </xsl:when>
            <!-- ### Hrsg.-Korrekturen -->
            <xsl:when test="$node[tei:corr[not(@type='deleted')]]">
                <xsl:value-of select="$node/tei:corr"/>
                <xsl:text>] </xsl:text>
                <xsl:value-of select="$node/tei:sic"/>
            </xsl:when>
            <!-- ### Streichung durch Hrsg. -->
            <xsl:when test="$node[tei:corr[(@type='deleted')]]">
                <span class="italic"><xsl:text>folgt </xsl:text></span>
                <xsl:text>&lt;&lt;</xsl:text>
                <xsl:value-of select="$node/tei:sic"/>
                <xsl:text>&gt;&gt;</xsl:text>
            </xsl:when>
            <!-- ### Normalisierung -->
            <xsl:when test="$node[tei:orig]">
                <xsl:value-of select="$node/tei:reg"/>
                <xsl:text>] </xsl:text>
                <xsl:value-of select="$node/tei:orig"/>
            </xsl:when>
        </xsl:choose>
        
    </xsl:function>
    
    <!-- ## ediarum_noteContent_del - Ausgabe Fußnote von Streichung (tei:del) -->
    <xsl:function name="telota:ediarum_noteContent_del">
        <xsl:param name="node"/>
        
        <xsl:text>||] </xsl:text>
        <xsl:choose>
            <xsl:when test="$node[tei:gap]">
                
                <span class="deletedGap">
                    <span class="angleBracket">&#x2329;</span>
                    <xsl:apply-templates select="$node/tei:gap//preceding-sibling::node()"/>
                    <span class="gapSymbol"> &#8970;&#8969; </span>
                    <xsl:apply-templates select="$node/tei:gap//following-sibling::node()"/>
                    <span class="angleBracket">&#x232A;</span>
                </span>
                
            </xsl:when>
            <xsl:otherwise>
                
                <span class="deleted">
                    <xsl:apply-templates select="$node/string()"/>
                </span>
                <xsl:text> </xsl:text>
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
                
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:function>
        
    <!-- ## ediarum_noteContent_gap - Ausgabe Fußnote von Schäden (tei:gap) -->
    <xsl:function name="telota:ediarum_noteContent_gap">
        <xsl:param name="node"/>
        
        <span class="gapSymbol">&#8970;&#8969;</span>
        <xsl:text>] </xsl:text>
        <xsl:choose>
            <xsl:when test="$node[@reason = 'lost']">
                <xsl:text>Verlust</xsl:text>
            </xsl:when>
            <xsl:when test="$node[@reason = 'illegible']">
                <xsl:text>unleserlich</xsl:text>
            </xsl:when>
            <xsl:when test="$node[@reason = 'covered']">
                <xsl:text>schwer leserlich duch Überschreibung/Überzeichnung</xsl:text>
            </xsl:when>
            <xsl:when test="$node[@reason = 'empty']">
                <xsl:text>Leerraum</xsl:text>
            </xsl:when>
            <xsl:when test="$node[@reason = 'fm']">
                <xsl:text>fremdsprachlicher Text</xsl:text>
            </xsl:when>
            <xsl:when test="$node[@reason = 'insignificant']">
                <xsl:text>Für das Korpus unwichtiger Text</xsl:text>
            </xsl:when>
        </xsl:choose>
        
        <xsl:if test="$node[@unit and @quantity]">
            <xsl:choose>
                <xsl:when test="$node[@unit = 'chars']">
                    <xsl:text>: </xsl:text>
                    <xsl:value-of select="$node/@quantity/data()"/>
                    <xsl:text> Zeichen</xsl:text>
                </xsl:when>
                <xsl:when test="$node[@unit = 'lines']">
                    <xsl:text>: </xsl:text>
                    <xsl:value-of select="$node/@quantity/data()"/>
                    <xsl:choose>
                        <xsl:when test="$node/@quantity = 1">
                            <xsl:text> Zeile</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text> Zeilen</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="$node[@unit = 'words']">
                    <xsl:text>: </xsl:text>
                    <xsl:value-of select="$node/@quantity/data()"/>
                    <xsl:choose>
                        <xsl:when test="$node/@quantity = 1">
                            <xsl:text> Wort</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text> Wörter</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="$node[@unit = 'pages']">
                    <xsl:text>: </xsl:text>
                    <xsl:value-of select="$node/@quantity/data()"/>
                    <xsl:choose>
                        <xsl:when test="$node/@quantity = 1">
                            <xsl:text> Seite</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text> Seiten</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
            </xsl:choose>
        </xsl:if>
        
    </xsl:function>
    
    <!-- ## telota:ediarum_noteContent_metamark - Ausgabe Fußnote von Einweisungszeichen (tei:metamark) -->
    <xsl:function name="telota:ediarum_noteContent_metamark">
        <xsl:param name="node"/>
        
        <span class="metamark">
            <xsl:choose>
                <xsl:when test="$node[@function='used']">
                    <xsl:text>Textpassage im Manuskript als erledigt markiert</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>folgt Einweisungszeichen</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </span>
        
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
        
    <!-- ## ediarum_noteContent_space - Ausgabe Fußnote von Leerräumen (tei:space) -->
    <xsl:function name="telota:ediarum_noteContent_space">
        <xsl:param name="node"/>
        
        <span class="spaceFootnote">
            <xsl:choose>
                <xsl:when test="$node/@dim/data() = 'horizontal'">
                    <xsl:text>Horizontale </xsl:text>
                </xsl:when>
                <xsl:when test="$node/@dim/data() = 'vertical'">
                    <xsl:text>Vertikale </xsl:text>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <xsl:text>Lücke</xsl:text>
            
            <xsl:if test="$node[@quantity and @unit]">
                <xsl:text> von </xsl:text>
                
                <xsl:value-of select="$node/@quantity"/>
                
                <xsl:choose>
                    <xsl:when test="$node/@unit/data() = 'chars'">
                        <xsl:text> Zeichen</xsl:text>
                    </xsl:when>
                    <xsl:when test="$node/@unit/data() = 'lines'">
                        <xsl:choose>
                            <xsl:when test="$node/@quantity/data() = 1">
                                <xsl:text> Zeile</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text> Zeilen</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="$node/@unit/data() = 'words'">
                        <xsl:choose>
                            <xsl:when test="$node/@quantity/data() = 1">
                                <xsl:text> Wort</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text> Wörtern</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                </xsl:choose>
            </xsl:if>
            
            
            
        </span>
        
    </xsl:function>
    
    <!-- ## ediarum_noteContent_subst - Ausgabe Fußnote einer zeitgenössischen Korrektur (tei:subst) -->
    <xsl:function name="telota:ediarum_noteContent_subst">
        <xsl:param name="node"/>
        
        <xsl:value-of select="$node/tei:add"/>
        <span class="substition">
            <xsl:text> korr. aus </xsl:text>
        </span>
        <span class="angleBracket">&#x2329;</span>
        <xsl:value-of select="$node/tei:del"/>
        <span class="angleBracket">&#x232A;</span>
        
    </xsl:function>
    
    <!-- ## ediarum_noteContent_supplied - Ausgabe Fußnoten eines fehlenden Wortes oder Satzzeichens (nur bei geringer Wahrscheinlichkeit) (tei:supplied[@cert='low']) -->
    <xsl:function name="telota:ediarum_noteContent_supplied">
        <xsl:param name="node"/>
        
        <span class="supplied"><xsl:text>wohl ergänzt</xsl:text></span>
        
    </xsl:function>
        
</xsl:stylesheet>

