<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:telota="http://www.telota.de"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="#all"
    version="2.0">
    
    
    <!-- pdf_print_content_templates.xsl - Sammlung der Templates, die die Elemente im Text verarbeiten.              -->
    <!--                                   Werden über <apply-templates (select="XXX")/> in pdf_print.xsl aufgerufen. -->
    
    <xsl:include href="pdf_print_project.xsl"/>
    <xsl:include href="pdf_print_content_functions.xsl"/>


    <!-- ####################################### -->
    <!-- ### Content - Template-Definitionen ### -->
    <!-- ####################################### -->
    
    <!-- ######################################## -->
    <!-- ##### keine Verarbeitung notwendig ##### -->
    
    <!-- # Kommentare -->
    <xsl:template mode="#all" match="tei:comment"/>
    
    <!-- # Indexierung -->
    <xsl:template mode="#all" match="tei:index"/>
    
    
    <!-- ############################ -->
    <!-- ##### Strukturelemente ##### -->
    
    <!-- # Textstruktur -->
    
    <xsl:template mode="#all" match="tei:lb">
        <br/>
    </xsl:template>

    <xsl:template mode="#all" match="tei:milestone[@unit='section' and @rendition='#hr']">
        <hr class="section" title="Abschnittsstrich durch Autor gesetzt"/>
    </xsl:template>
    
    <xsl:template mode="#all" match="tei:p">
        <p>
            <xsl:apply-templates mode="#current"/>
        </p>
    </xsl:template>
    
    <!-- ## Seiten- oder Foliowechsel -->
    <xsl:template mode="#all" match="tei:pb">
        <span class="pb">
            <xsl:text>|</xsl:text>
            <xsl:if test="@n">
                <xsl:text>(</xsl:text>
                <xsl:value-of select="@n/data()"/>
                <xsl:text>) </xsl:text>
            </xsl:if>
        </span>
    </xsl:template>
    
    <xsl:template mode="#all" match="tei:fw[@type='folNum']">
        <span class="fw">
            <xsl:text>|(</xsl:text>
            <xsl:value-of select="./text()"/>
            <xsl:text>) </xsl:text>
        </span>
    </xsl:template>
    
    <!-- ## Einrückungen -->
    <xsl:template mode="#all" match="tei:p[@rendition='#et']">
        <p class="indentation">
            <xsl:apply-templates mode="#current"/>
        </p>
    </xsl:template>
    
    <!-- ## Anfang und Abschluss -->
    <xsl:template mode="#all" match="tei:address">
        <p class="address">
            <xsl:apply-templates mode="#current"/>
        </p>
    </xsl:template>
    <xsl:template mode="#all" match="tei:addrLine">
        <xsl:apply-templates mode="#current"/>
        <br/>
    </xsl:template>
    <xsl:template mode="#all" match="tei:closer">
        <div class="closer">
            <xsl:apply-templates mode="#current"/>
        </div>
    </xsl:template>
    <xsl:template mode="#all" match="tei:dateline">
        <p class="dateline">
            <xsl:choose>
                <xsl:when test="@rendition='#left'">
                    <div class="alignLeft">
                        <xsl:apply-templates mode="#current"/>
                    </div>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates mode="#current"/>
                </xsl:otherwise>
            </xsl:choose>
        </p>
    </xsl:template>
    <xsl:template mode="#all" match="tei:opener">
        <div class="opener">
            <xsl:apply-templates mode="#current"/>
        </div>
    </xsl:template>
    <xsl:template mode="#all" match="tei:postscript">
        <div class="postscript">
            <xsl:apply-templates mode="#current"/>
        </div>
    </xsl:template>
    <xsl:template mode="#all" match="tei:salute">
        <p class="salute">
            <xsl:apply-templates mode="#current"/>
        </p>
    </xsl:template>
    <xsl:template mode="#all" match="tei:signed">
        <p class="signed">
            <xsl:apply-templates mode="#current"/>
        </p>
    </xsl:template>
    
    <!-- ## Schreibakt - ACHTUNG: Aufruf über named-template! -->
    <xsl:template name="ediarum_contentWritingSession">
        <xsl:if test="./@type = 'writingSession'">
            <h4>
                <xsl:text>Schreibakt </xsl:text>
                <xsl:if test="./@n">
                    <xsl:text>Nr. </xsl:text>
                    <xsl:value-of select="./@n"/>
                </xsl:if>
            </h4>
        </xsl:if>
    </xsl:template>
    
    <!-- ## Liste -->
    <xsl:template mode="#all" match="tei:list">
        <ul>
            <xsl:apply-templates mode="#current"/>
        </ul>
    </xsl:template>
    
    <xsl:template mode="#all" match="tei:item[not(.//tei:list)]">
        <li>
            <xsl:apply-templates mode="#current"/>
        </li>
    </xsl:template>
    
    <!-- ## Tabelle -->
    <xsl:template name="table_template" mode="#all" match="tei:table">
        <div class="tableContainer">
            <table>
                <!-- ### Tabelle explizit gezeichnet? -->
                <xsl:if test="@rend='drawn'">
                    <xsl:attribute name="class">
                        <xsl:text>tableDrawn</xsl:text>
                    </xsl:attribute>
                </xsl:if>
                <!-- ### Tabellenüberschrift -->
                <caption>
                    <xsl:for-each select="tei:head">
                        <span class="tableCaption"> 
                            <xsl:apply-templates mode="#current"/>
                        </span>
                    </xsl:for-each>
                </caption>
                <!-- ### Tabelleninhalt -->
                <xsl:for-each select="tei:row">
                    <tr>
                        <xsl:choose>
                            <!-- #### Tabellenüberschrift -->
                            <xsl:when test="@role='label'">
                                <xsl:for-each select="tei:cell">
                                    <th>
                                        <xsl:sequence select="telota:drawCell(.)"/>
                                        <xsl:apply-templates mode="#current"/>
                                    </th>
                                </xsl:for-each>
                            </xsl:when>
                            <!-- #### Normale Tabellenzeilen -->
                            <xsl:otherwise>
                                <xsl:for-each select="tei:cell">
                                    <td>
                                        <xsl:sequence select="telota:drawCell(.)"/>
                                        <xsl:apply-templates mode="#current"/>
                                    </td>
                                </xsl:for-each>
                            </xsl:otherwise> 
                        </xsl:choose>
                    </tr>
                </xsl:for-each>
            </table>
        </div>
    </xsl:template>
    <!-- ## Kennzeichnung vorgedruckte Tabelle -->
    <xsl:template mode="#all" match="tei:table[@rendition='#mPrint']">
        <span class="printed">
            <xsl:call-template name="table_template"/>
        </span>
    </xsl:template>
    
    <!-- ## Gedichte -->
    <xsl:template mode="#all" match="tei:lg[@type='poem']">
        <p class="poem">
            <xsl:apply-templates mode="#current"/>
        </p>
    </xsl:template>
    <xsl:template mode="#all" match="tei:lg[@n]">
        <span class="strophe">
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    <xsl:template mode="#all" match="tei:l">
        <xsl:apply-templates mode="#current"/>
        <br/>
    </xsl:template>
    
    
    <!-- #################################### -->
    <!-- ##### Herausgeberbearbeitungen ##### -->
    
    <!-- # Sachanmerkungen und Bearbeitungsanmerkungen -->
    <!-- ## Sachanmerkungen - Fließtext -->
    <xsl:template mode="#all" match="tei:note[ancestor-or-self::tei:div and @place='foot'] |
                                     tei:seg |
                                     tei:persName[ancestor-or-self::tei:body] |
                                     tei:placeName[ancestor-or-self::tei:body] |
                                     tei:orgName[ancestor-or-self::tei:body] |
                                     tei:bibl[ancestor-or-self::tei:body] |
                                     tei:item[ancestor-or-self::tei:body and @xml:id]">
        
        <xsl:param name="placeOfNotes" tunnel="yes"/>
        
        <xsl:variable name="criticalAppCounter">
            <xsl:number level="any" format="aa" count="tei:note[ancestor-or-self::tei:div and @place='foot'] |
                                                       tei:seg |
                                                       tei:persName[ancestor-or-self::tei:body] |
                                                       tei:placeName[ancestor-or-self::tei:body] |
                                                       tei:orgName[ancestor-or-self::tei:body] |
                                                       tei:bibl[ancestor-or-self::tei:body] |
                                                       tei:item[ancestor-or-self::tei:body and @xml:id]"/>
        </xsl:variable>
        
        <!-- ### Hier Inhalte, die im Fließtext bleiben. -->
        <xsl:choose>
            <!-- #### Sachanmerkungen -->
            <xsl:when test="self::tei:seg">
                <xsl:apply-templates select="./tei:orig"/>
                <xsl:if test="$placeOfNotes eq 'foot'">
                    <span class="footnote">
                        <xsl:copy-of select="telota:ediarum_noteContent_seg(.)"/>
                    </span>
                </xsl:if>
            </xsl:when>
            <!-- #### Hinweise in Fußnoten -->
            <xsl:when test="self::tei:note">
                <xsl:if test="$placeOfNotes eq 'foot'">
                    <span class="footnote">
                        <xsl:copy-of select="telota:ediarum_noteContent_noteFoot(.)"/>
                    </span>
                </xsl:if>
            </xsl:when>
            <!-- #### Verweise auf Register -->
            <xsl:when test=".[self::tei:persName|self::tei:placeName|self::tei:orgName|self::tei:item|self::tei:bibl]">
                <xsl:apply-templates/>
                <xsl:if test="$placeOfNotes eq 'foot'">
                    <span class="footnote">
                        <xsl:copy-of select="telota:project_getRegisterLink(.)"/>
                    </span>
                </xsl:if>
            </xsl:when>
        </xsl:choose>
        
        <!-- ### Endnotenreferenzen Fließtext -->
        <xsl:if test="$placeOfNotes eq 'end'">
            <xsl:copy-of select="telota:endnoteInText($criticalAppCounter)"/>
        </xsl:if>
        
    </xsl:template>
    
    
    <!-- ## Sachanmerkungen - Endnotentext -->
    <xsl:template mode="criticalApp" match="tei:note[ancestor-or-self::tei:div and @place='foot'] |
                                            tei:seg |
                                            tei:persName[ancestor-or-self::tei:body] |
                                            tei:placeName[ancestor-or-self::tei:body] |
                                            tei:orgName[ancestor-or-self::tei:body] |
                                            tei:bibl[ancestor-or-self::tei:body] |
                                            tei:item[ancestor-or-self::tei:body and @xml:id]">
        
        <xsl:param name="placeOfNotes" tunnel="yes"/>
        
        <xsl:variable name="criticalAppCounter">
            <xsl:number level="any" format="aa" count="tei:note[ancestor-or-self::tei:div and @place='foot'] |
                                                       tei:seg |
                                                       tei:persName[ancestor-or-self::tei:body] |
                                                       tei:placeName[ancestor-or-self::tei:body] |
                                                       tei:orgName[ancestor-or-self::tei:body] |
                                                       tei:bibl[ancestor-or-self::tei:body] |
                                                       tei:item[ancestor-or-self::tei:body and @xml:id]"/>
        </xsl:variable>
        
        <li>
            <!-- ### Endnotenreferenz Endnoten -->
            <xsl:copy-of select="telota:endnoteAtEnd($criticalAppCounter)"/>
            
            <!-- ### Hier Text, der in Endnote ausgegeben wird. -->
            <xsl:choose>
                <!-- #### Sachanmerkungen -->
                <xsl:when test="self::tei:seg">
                    <xsl:copy-of select="telota:ediarum_noteContent_seg(.)"/>
                </xsl:when>
                <!-- #### Hinweise in Fußnoten -->
                <xsl:when test="self::tei:note">
                    <xsl:copy-of select="telota:ediarum_noteContent_noteFoot(.)"/>
                </xsl:when>
                <!-- #### Verweise auf Register -->
                <xsl:when test=".[self::tei:persName|self::tei:placeName|self::tei:orgName|self::tei:item|self::tei:bibl]">
                    <xsl:copy-of select="telota:project_getRegisterLink(.)"/>
                </xsl:when>
            </xsl:choose>
        </li>
        
    </xsl:template>
    
    <!-- ## Kritischer Apparat - Fließtext -->
    <xsl:template match="tei:add |
                         tei:choice[tei:abbr | tei:corr | tei:orig] |
                         tei:del |
                         tei:gap |
                         tei:note[ancestor::tei:div][not(@place='foot') and not(ancestor::tei:seg)] |
                         tei:unclear">
        
        <xsl:param name="placeOfNotes" tunnel="yes"/>
        
        <xsl:variable name="criticalAppCounter">
            <xsl:number level="any" format="aa" count="tei:add |
                                                       tei:choice[tei:abbr | tei:corr | tei:orig] |
                                                       tei:del[not(tei:gap)] |
                                                       tei:gap |
                                                       tei:note[ancestor::tei:div][not(@place='foot') and not(ancestor::tei:seg)] |
                                                       tei:unclear"/>
        </xsl:variable>

        <!-- ### Hier Inhalte, die im Fließtext bleiben. -->
        <xsl:choose>
            <!-- #### Hinzufügung -->
            <xsl:when test="self::tei:add">
                <xsl:apply-templates mode="#current"/>
                <xsl:if test="$placeOfNotes eq 'end'">
                    <span class="footnote">
                        <xsl:copy-of select="telota:ediarum_noteContent_add(.)"/>
                    </span>
                </xsl:if>
            </xsl:when>
            <!-- #### Herausgeberkorrekturen -->
            <xsl:when test="self::tei:choice">
                <xsl:choose>
                    <!-- ##### Abkürzungsauflösung -->
                    <xsl:when test=".[tei:abbr]">
                        <span class="expan">
                            <xsl:apply-templates mode="#current" select="tei:expan"/>
                        </span>
                        <xsl:if test="$placeOfNotes eq 'end'">
                            <span class="footnote">
                                <xsl:copy-of select="telota:ediarum_noteContent_choice(.)"/>
                            </span>
                        </xsl:if>
                    </xsl:when>
                    <!-- ##### Korrektur -->
                    <xsl:when test=".[tei:corr]">
                        <span class="corr">
                            <span class="sic">
                                <xsl:text> ([sic]: „</xsl:text>
                                <xsl:apply-templates mode="#current" select="tei:sic"/>
                                <xsl:text>“) </xsl:text>
                            </span>
                            <xsl:apply-templates mode="#current" select="tei:corr"/>
                        </span>
                        <xsl:if test="$placeOfNotes eq 'end'">
                            <span class="footnote">
                                <xsl:copy-of select="telota:ediarum_noteContent_choice(.)"/>
                            </span>
                        </xsl:if>
                    </xsl:when>
                    <!-- ##### Normalisierung -->
                    <xsl:when test=".[tei:orig]">
                        <span class="corr">
                            <span class="sic">
                                <xsl:text> ([sic]: „</xsl:text>
                                <xsl:apply-templates mode="#current" select="tei:orig"/>
                                <xsl:text>“) </xsl:text>
                            </span>
                            <xsl:apply-templates mode="#current" select="tei:reg"/>
                        </span>
                        <xsl:if test="$placeOfNotes eq 'end'">
                            <span class="footnote">
                                <xsl:copy-of select="telota:ediarum_noteContent_choice(.)"/>
                            </span>
                        </xsl:if>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <!-- #### Streichung -->
            <xsl:when test="self::tei:del">
                <!-- Wenn tei:del/tei:gap, dann nicht ausgeben. Streichung des Textes in del trotzdem. -->
                <span class="deleted">
                    <xsl:apply-templates mode="#current"/>
                </span>
                <xsl:if test="$placeOfNotes eq 'end' and not(.[tei:gap])">
                    <span class="footnote">
                        <xsl:copy-of select="telota:ediarum_noteContent_del(.)"/>
                    </span>
                </xsl:if>
            </xsl:when>
            <!-- #### Schäden -->
            <xsl:when test="self::tei:gap">
                [...]
                <xsl:if test="$placeOfNotes eq 'end'">
                    <span class="footnote">
                        <xsl:copy-of select="telota:ediarum_noteContent_gap(.)"/>
                    </span>
                </xsl:if>
            </xsl:when>
            <!-- #### Anmerkung -->
            <xsl:when test="self::tei:note">
                <xsl:apply-templates mode="#current"/>
                <xsl:if test="$placeOfNotes eq 'end'">
                    <span class="footnote">
                        <xsl:copy-of select="telota:ediarum_noteContent_note(.)"/>
                    </span>
                </xsl:if>
            </xsl:when>
            <!-- #### Unleserlich -->
            <xsl:when test="self::tei:unclear">
                <xsl:choose>
                    <xsl:when test="child::*|text()">
                        <span class="unclear">
                            <xsl:apply-templates mode="#current"/>
                            <span class="symbol">(?)</span>
                        </span>
                        <xsl:if test="$placeOfNotes eq 'end'">
                            <span class="footnote">
                                <xsl:copy-of select="telota:ediarum_noteContent_unclear(.)"/>
                            </span>
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <span class="unclear">
                            [...]<span class="symbol">(?)</span>
                        </span>
                        <xsl:if test="$placeOfNotes eq 'end'">
                            <span class="footnote">
                                <xsl:copy-of select="telota:ediarum_noteContent_unclear(.)"/>
                            </span>
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>

        <!-- ### Endnotenreferenzen Fließtext -->
        <xsl:if test="$placeOfNotes eq 'foot'">
            <xsl:choose>
                <!-- Wenn tei:del/tei:gap, dann nicht ausgeben. -->
                <xsl:when test="self::tei:del and .[tei:gap]"/>
                <xsl:otherwise>
                    <xsl:copy-of select="telota:endnoteInText($criticalAppCounter)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        
    </xsl:template>
    
    <!-- ## Kritischer Apparat - Endnoten -->
    <xsl:template mode="criticalApp" match="tei:add |
                                            tei:choice[tei:abbr | tei:corr | tei:orig] |
                                            tei:del[not(tei:gap)] |
                                            tei:gap |
                                            tei:note[ancestor::tei:div][not(@place='foot') and not(ancestor::tei:seg)] |
                                            tei:unclear">
        
        <xsl:variable name="criticalAppCounter">
            <xsl:number level="any" format="aa" count="tei:add |
                                                       tei:choice[tei:abbr | tei:corr | tei:orig] |
                                                       tei:del[not(tei:gap)] |
                                                       tei:gap |
                                                       tei:note[ancestor::tei:div][not(@place='foot') and not(ancestor::tei:seg)] |
                                                       tei:unclear"/>
        </xsl:variable>
        
        <li>
            <!-- ### Endnotenreferenz Endnoten -->
            <xsl:copy-of select="telota:endnoteAtEnd($criticalAppCounter)"/>
            
            <!-- ### Hier Text, der in Endnote ausgegeben wird. -->
            <xsl:choose>
                <!-- #### Hinzufügung -->
                <xsl:when test="self::tei:add">
                    <xsl:copy-of select="telota:ediarum_noteContent_add(.)"/>
                </xsl:when>
                <!-- #### Herausgeberkorrekturen -->
                <xsl:when test="self::tei:choice">
                    <xsl:copy-of select="telota:ediarum_noteContent_choice(.)"/>
                </xsl:when>
                <!-- #### Streichung -->
                <xsl:when test="self::tei:del">
                    <xsl:copy-of select="telota:ediarum_noteContent_del(.)"/>
                </xsl:when>
                <!-- #### Schäden -->
                <xsl:when test="self::tei:gap">
                    <xsl:copy-of select="telota:ediarum_noteContent_gap(.)"/>
                </xsl:when>
                <!-- #### Anmerkung -->
                <xsl:when test="self::tei:note">
                    <xsl:copy-of select="telota:ediarum_noteContent_note(.)"/>
                </xsl:when>
                <!-- #### Unsichere Lesart -->
                <xsl:when test="self::tei:unclear">
                    <xsl:copy-of select="telota:ediarum_noteContent_unclear(.)"/>
                </xsl:when>
            </xsl:choose>
        </li>
        
    </xsl:template>
    


    <!-- # Textberarbeitungen durch Herausgeber -->
    
    <!-- ## fehlendes Wort -->
    <xsl:template mode="#all" match="tei:supplied">
        <span class="supplied">[<xsl:apply-templates mode="#current"/>]</span>
    </xsl:template>

    <!-- ## Korrektur durch Herausgeber -->
    <!-- ### Abkürzungsauflösung durch Herausgeber -->
    <!-- Für Verarbeitung abbr/expan siehe Kritischer Apparat. -->
    
    <!-- ### Streichung durch Herausgeber -->
    <!-- Für Verarbeitung corr/sic siehe Kritischer Apparat. -->
    
    <!-- ### Normalisierte Schreibung -->
    <!-- Für Verarbeitung orig/reg siehe Kritischer Apparat. -->
    
    <!-- ### Ergänzung durch Herausgeber -->
    <xsl:template mode="#all" match="tei:ex">
        <span class="ex">
            <xsl:value-of select="."/>
        </span>
    </xsl:template>

    <!-- ### Streichung überflüssiges Wort -->
    <xsl:template mode="#all" match="tei:surplus">
        <span class="surplus">
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>    

    <!-- ## Zitat in Regest, Kurzabstract, ... -->
    <xsl:template mode="#all" match="tei:quote">
        <span class="quoteInItalicPart">
            "<xsl:apply-templates mode="#current"/>"
        </span>
    </xsl:template>
        
    <!-- ## Unterstreichungen -->
    <xsl:template match="tei:hi[@rendition='#u']" mode="#all">
        <span class="underline">
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    <xsl:template match="tei:hi[@rendition='#uu']" mode="#all">
        <span class="underlineDouble">
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>    

    <!-- ## Textdarstellungen durch Herausgeber -->
    <xsl:template match="tei:hi[@rendition='#i']" mode="#all">
        <span class="italic">
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    <xsl:template match="tei:hi[@rendition='#b']" mode="#all">
        <span class="bold">
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    <xsl:template match="tei:hi[@rendition='#g']" mode="#all">
        <span class="letterspace">
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    <xsl:template match="tei:hi[@rendition='#sub']" mode="#all">
        <span class="sub">
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    <xsl:template match="tei:hi[@rendition='#sup']" mode="#all">
        <span class="sup">
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    <xsl:template match="tei:hi[@rendition='#mMM']" mode="#all">
        <span class="marginLine">
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    <xsl:template match="tei:p[@rendition='#mMM']" mode="#all">
        <p class="marginLine">
            <xsl:apply-templates mode="#current"/>
        </p>
    </xsl:template>
    <xsl:template match="tei:hi[@rendition='#c']" mode="#all">        
        <span class="center">
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    <xsl:template match="tei:hi[@rendition='#mPrint']" mode="#all">
        <span class="printed">
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>    
    
    
    
    <!-- # Weiteres -->
    
    <!-- ## fremdsprachiger Text -->
    <xsl:template mode="#all" match="tei:foreign">
        <span class="foreign">
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    
    <!-- ## Frakturschrift -->
    <xsl:template mode="#all" match="tei:hi[@rendition='#fr']">
        <span class="fraktur">
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    
    <!-- ## Einweisungszeichen -->
    <xsl:template mode="#all" match="tei:metamark[not(@function='used')]">
        <xsl:text>⎡</xsl:text>
    </xsl:template>


    
    <!-- # Register-Verknüpfung -->
    <!-- Für Verarbeitung aller Registereinträge (persName, placeName, orgName, bibl, item[@xml:id]) siehe Fußnoten. -->
    



    
    <!-- ############################ -->
    <!-- ##### Einführungstexte ##### -->
    
    <xsl:template match="tei:div[ancestor::tei:TEI[@telota:doctype='introduction']]">
        <xsl:apply-templates mode="intro"/>
    </xsl:template>
    
    <xsl:template mode="intro" match="tei:head">
        <xsl:variable name="headid">
            <xsl:value-of select="count(preceding::tei:head)+1"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="@type='h1'">
                <h1 id="section{$headid}">
                    <xsl:apply-templates mode="#current"/>
                </h1>
            </xsl:when>
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
    <xsl:template mode="intro" match="tei:p">
        <p>
            <xsl:apply-templates mode="#current"/>
        </p>
    </xsl:template>

    
    <!-- TODO: Hinweis in kritischem Apparat -->
    <xsl:template mode="intro" match="tei:p[.//tei:note[not(ancestor::tei:quote)]/@place='foot']">
        <p>
            <!--<xsl:call-template name="paragraphNumber"/>-->
            <xsl:apply-templates mode="#current"/>
            <span class="footnoteContainer">
                <xsl:apply-templates select=".//tei:note[not(ancestor::tei:quote)]" mode="footnote"/>
            </span>
        </p>
    </xsl:template>
    <xsl:template mode="intro" match="tei:note[@place='foot' and matches(@xml:id, 'ftn')]">
        <span class="number">[<xsl:value-of select="@n"/>]</span>
    </xsl:template>
    <xsl:template mode="footnote" match="tei:note">
        <span class="footnote">
            <span class="number">[<xsl:value-of select="@n"/>]</span>
            <span id="{@n}" class="truncate" style="font-style: italic;">
                <xsl:apply-templates mode="intro"/>
            </span>
        </span>
    </xsl:template>
    <xsl:template mode="intro" match="tei:p[parent::tei:note/@place='foot']">
        <xsl:apply-templates mode="intro"/>
    </xsl:template>
    <xsl:template mode="intro" match="tei:author/tei:note">
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
                        <xsl:apply-templates select="child::node()" mode="intro"/>
                    </li>
                </xsl:for-each>
            </ul>
        </div>
    </xsl:template>
    <xsl:template mode="intro" match="tei:quote">
        <p class="{@type}">
            <xsl:apply-templates mode="#current"/>
            <xsl:if test=".//tei:note">
                <span class="footnoteContainer">
                    <xsl:apply-templates select=".//tei:note" mode="footnote"/>
                </span>
            </xsl:if>
        </p>
    </xsl:template>
    
    <!-- ^^FERTIG MARKER^^ -->
    
    
    
    
    <!-- Braucht man das noch? War bei Intro-p eingebunden (call über apply) -->        
    <!--<xsl:template name="paragraphNumber">
        <xsl:variable name="nr">
            <xsl:value-of select="count(preceding::tei:p[ancestor::tei:text and not(parent::tei:note)]) + 1"/>
        </xsl:variable>
        <span class="paragraphNumber" title="Absatznummer">
            <a name="{./@n}">
                <xsl:value-of select="$nr"/>
            </a>
        </span>
    </xsl:template>-->
    
    
    <!-- Kann das weg? -->
    <!--<xsl:param name="id"/>
    <xsl:param name="filename"/>
    <xsl:param name="print"/>
    <xsl:param name="cacheLetterIndex"/>
    <xsl:function name="telota:labels">
        <xsl:param name="string"/>
        <xsl:param name="quantity"/>
        <xsl:variable name="cleanedString">
            <xsl:choose>
                <xsl:when test="matches($string, '#')">
                    <xsl:value-of select="substring-after($string, '#')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$string"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
    </xsl:function>-->
    
</xsl:stylesheet>