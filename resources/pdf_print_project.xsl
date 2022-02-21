<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:telota="http://www.telota.de"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="#all"
    version="2.0">
    
    
    <!-- ############################## -->
    <!-- ### Project - Einbindungen ### -->
    <!-- ############################## -->
    
    <xsl:import href="pdf_print.xsl"/>
    
    
    
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
    
    <!-- ## CriticalApp-Template (Default/Projekt) -->
    <xsl:param name="p_structureCriticalAppDefault">
        <xsl:value-of select="true()"/>
    </xsl:param>
    
    
    
    <!-- # Parameter Verbindungen -->
    <!-- Welche Verbindungen in die DB (data, register, ...) werden genutzt. -->
    
    <!-- ## Oxygen-Ordner -->
    <!-- TODO: Fallback definieren -->
    <xsl:param name="p_pathToOxygen">
        <xsl:text>https://xmledit.bbaw.de/mop/rest/db/projects/mop/oxygen</xsl:text>
        <!--${ediarum_project_domain}${ediarum_projects_directory}${ediarum_project_name}/oxygen-->
    </xsl:param>
    
    <!-- ## Registerverbindungen -->
    <!-- ### pathToRegister - Erhält den Pfad zum projektspezifischen Register. -->
    <xsl:param name="p_pathToRegister">
        <xsl:text>https://xmledit.bbaw.de/mop/rest/db/projects/mop/web/register</xsl:text>
        <!--${ediarum_website_base}${ediarum_projects_directory}${ediarum_project_name}/web/register-->
    </xsl:param>
    
    <!-- ### Aufruf der Oxygen-Schnittstellen -->
    <xsl:param name="p_index_persons">
        <xsl:text>/ediarum.xql?index=persons</xsl:text>
    </xsl:param>    
    <xsl:param name="p_index_places">
        <xsl:text>/ediarum.xql?index=places</xsl:text>
    </xsl:param>    
    <xsl:param name="p_index_organizations">
        <xsl:text>/ediarum.xql?index=organisations</xsl:text>
    </xsl:param>    
    <xsl:param name="p_index_items">
        <xsl:text>/ediarum.xql?index=items</xsl:text>
    </xsl:param>    
    <xsl:param name="p_index_bibl">
        <xsl:text>/ediarum.xql?index=bibliography</xsl:text>
    </xsl:param>    
    
    
    
    <!-- # Parameter Anpassungen -->
    <!-- Parameter zur weiteren Anpassung der Ausgabe. -->
    
    <!-- ## Einstellung Fußnoten: notesAsFootnotes - Erhält einen bool-Wert, ob Sachanmerkungen als Fußnoten (true) oder Endnoten (false) dargestellt werden. -->
    <xsl:param name="p_notesAsFootnotes" select="false()"/>
    
    
    <!-- ## Kennzeichnung Schreibakt: p_showWritingSession - Soll jeder Schreibakt mit einer Zwischenüberschrift "Schreibakt Nr. " begonnen werden? -->
    <xsl:param name="p_showWritingSession" select="false()"/>
    
    
    
    
    
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
    
    <xsl:template name="ediarum_structure_criticalApp_project">
        <xsl:param name="placeOfNotes"/>
        
    </xsl:template>
    
    
    
    
    <!-- ###################### -->
    <!-- ### Transformation ### -->
    <!-- ###################### -->
    
    <!-- # Für Transformation einer Einzeldatei notwendig -->
    <xsl:template match="tei:TEI">
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            
            <!-- ## Transformationsstruktur für head -->
            <xsl:choose>
                <xsl:when test="$p_structureHeadDefault = true()">
                    <xsl:call-template name="ediarum_structure_head_default">
                        <xsl:with-param name="placeOfNotes" select="$placeOfNotes"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="ediarum_structure_head_project">
                        <xsl:with-param name="placeOfNotes" select="$placeOfNotes"/>
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
            
            <body>
                
                <!-- ## Transformationsstruktur für header -->
                <xsl:choose>
                    <xsl:when test="$p_structureHeaderDefault = true()">
                        <xsl:call-template name="ediarum_structure_header_default">
                            <xsl:with-param name="placeOfNotes" select="$placeOfNotes"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="ediarum_structure_header_project">
                            <xsl:with-param name="placeOfNotes" select="$placeOfNotes"/>
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
                
                <!-- ## Transformationsstruktur für content -->
                <xsl:choose>
                    <xsl:when test="$p_structureContentDefault = true()">
                        <xsl:call-template name="ediarum_structure_content_default">
                            <xsl:with-param name="placeOfNotes" select="$placeOfNotes"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="ediarum_structure_content_project">
                            <xsl:with-param name="placeOfNotes" select="$placeOfNotes"/>
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
                
                <!-- ## Erstellen des kritischen Apparats am Ende des Dokuments -->
                <xsl:choose>
                    <xsl:when test="$p_structureCriticalAppDefault = true()">
                        <xsl:call-template name="ediarum_structure_criticalApp_default">
                            <xsl:with-param name="placeOfNotes" select="$placeOfNotes"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="ediarum_structure_criticalApp_project">
                            <xsl:with-param name="placeOfNotes" select="$placeOfNotes"/>
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
                
            </body>
        </html>
    </xsl:template>
    
    
    
    
    
    <!-- ########################################################################################################################### -->
    <!-- ########################################################################################################################### -->
    <!-- ########################################################################################################################### -->
    
    <!-- ############################## -->
    <!-- ### Footnotes - Funktionen ### -->
    <!-- ############################## -->
    
    <!-- # project_getRegisterLink - Gibt den Link ins jeweilige Register aus. (In Projekt-XSLT definiert, damit leicht anpassbar.) -->
    <xsl:function name="telota:project_getRegisterLink">
        <xsl:param name="node"/>
        
        <xsl:variable name="registerMapWeb">
            <register>
                <pers>
                    <dir>/personen/detail.xql</dir>
                    <data><xsl:value-of select="$p_index_persons"/></data>
                    <desc>Person</desc>
                </pers>
                <place>
                    <dir>/orte/detail.xql</dir>
                    <data><xsl:value-of select="$p_index_places"/></data>
                    <desc>Ort</desc>
                </place>
                <org>
                    <dir>/institutionen/detail.xql</dir>
                    <data><xsl:value-of select="$p_index_organizations"/></data>
                    <desc>Institution</desc>
                </org>
                <bibl>
                    <dir>/werke/detail.xql</dir>
                    <data><xsl:value-of select="$p_index_bibl"/></data>
                    <desc>Werk</desc>
                </bibl>
                <item>
                    <dir>/hoefe/detail.xql</dir>
                    <data><xsl:value-of select="$p_index_items"/></data>
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
        
        <xsl:variable name="registerLink">
            <xsl:value-of select="$p_pathToRegister"/>
            <xsl:value-of select="$registerType//dir/text()"/>
            <xsl:text>?id=</xsl:text>
            <xsl:value-of select="$key"/>
        </xsl:variable>
        
        <xsl:variable name="forRegisterEntry">
            <xsl:value-of select="$p_pathToOxygen"/>
            <xsl:value-of select="$registerType//data/text()"/>
        </xsl:variable>
        
        <xsl:variable name="registerEntry">
            <xsl:choose>
                <xsl:when test="doc($forRegisterEntry)//li[@xml:id=$key]">
                    <xsl:value-of select="doc($forRegisterEntry)//li[@xml:id=$key]"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>Keine Referenz gefunden.</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:value-of select="$registerType//desc/text()"/><xsl:text>: </xsl:text>
        <a class="regLink" href="{$registerLink}"><xsl:value-of select="$registerEntry"/></a>
        
    </xsl:function>
    


    
    
    <!-- ######################################### -->
    <!-- ### Footnotes - Fußnoteneinstellungen ### -->
    <!-- ######################################### -->
    
    <!-- # Einstellung Fußnoten -->
    <!-- notesAsFootnotes/placeOfNotes - Erhält vom Parameter notesAsFootnotes einen bool-Wert, ob Sachanmerkungen 
        als Fußnoten (true) oder Endnoten (false) dargestellt werden. Verarbeitung zur leichteren Lesbarkeit im 
        restlichen Code und Weiterverwendung über Variable placeOfNotes. -->
    <xsl:variable name="placeOfNotes">
        <xsl:choose>
            <xsl:when test="$p_notesAsFootnotes = true()">
                <xsl:text>foot</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>end</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    
    <!-- # Default-Einstellungen für Erstellen des kritischen Apparats -->
    <xsl:template name="ediarum_structure_criticalApp_default">
        <xsl:param name="placeOfNotes"/>
        
        <div>
            <br/>
            <hr/>
            <h4>Kritischer Apparat</h4>
            <ul class="criticalApp">
                
                <xsl:choose>
                    <!-- ### Bearbeitungsanmerkungen als Endnoten -->
                    <xsl:when test="$placeOfNotes = 'foot'">
                        <xsl:apply-templates mode="criticalApp" select="
                            .//tei:add[not(ancestor::tei:subst)] |
                            .//tei:choice[tei:corr | tei:abbr | tei:orig] |
                            .//tei:del[not(tei:gap)][not(ancestor::tei:subst)] |
                            .//tei:gap |
                            .//tei:note[ancestor::tei:div][not(@place='foot') and not(ancestor::tei:seg)] |
                            .//tei:subst |
                            .//tei:unclear"/>
                    </xsl:when>
                    <!-- ### Sachanmerkungen als Endnoten -->
                    <xsl:otherwise>
                        <xsl:apply-templates mode="criticalApp" select="
                            .//tei:note[ancestor-or-self::tei:div and @place='foot'] |
                            .//tei:seg |
                            .//tei:persName[ancestor-or-self::tei:body] |
                            .//tei:placeName[ancestor-or-self::tei:body] |
                            .//tei:orgName[ancestor-or-self::tei:body] |
                            .//tei:bibl[ancestor-or-self::tei:body] |
                            .//tei:item[ancestor-or-self::tei:body and @xml:id]">
                        </xsl:apply-templates>
                    </xsl:otherwise>
                </xsl:choose>
                
            </ul>
        </div>
        
    </xsl:template>
    
    
    <!-- # Sachanmerkungen und Bearbeitungsanmerkungen -->
    <!-- ## Sachanmerkungen - Fließtext -->
    <xsl:template match="tei:note[ancestor-or-self::tei:div and @place='foot'] |
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
    <xsl:template match="tei:add[not(ancestor::tei:subst)] |
                         tei:choice[tei:abbr | tei:corr | tei:orig] |
                         tei:del[not(ancestor::tei:subst)] |
                         tei:gap |
                         tei:note[ancestor::tei:div][not(@place='foot') and not(ancestor::tei:seg)] |
                         tei:subst |
                         tei:unclear">
        
        <xsl:param name="placeOfNotes" tunnel="yes"/>
        
        <xsl:variable name="criticalAppCounter">
            <xsl:number level="any" format="aa" count="tei:add[not(ancestor::tei:subst)] |
                                                       tei:choice[tei:abbr | tei:corr | tei:orig] |
                                                       tei:del[not(tei:gap)][not(ancestor::tei:subst)] |
                                                       tei:gap |
                                                       tei:note[ancestor::tei:div][not(@place='foot') and not(ancestor::tei:seg)] |
                                                       tei:subst |
                                                       tei:unclear"/>
        </xsl:variable>

        <!-- ### Hier Inhalte, die im Fließtext bleiben. -->
        <xsl:choose>
            <!-- #### Hinzufügung -->
            <xsl:when test="self::tei:add[not(ancestor::tei:subst)]">
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
                        <xsl:if test=".[tei:corr[not(@type='deleted')]]">
                            <span>
                                <xsl:apply-templates mode="#current" select="tei:corr"/>
                            </span>
                        </xsl:if>
                        <xsl:if test="$placeOfNotes eq 'end'">
                            <span class="footnote">
                                <xsl:copy-of select="telota:ediarum_noteContent_choice(.)"/>
                            </span>
                        </xsl:if>
                    </xsl:when>
                    <!-- ##### Normalisierung -->
                    <xsl:when test=".[tei:orig]">
                        <xsl:apply-templates mode="#current" select="tei:reg"/>
                        <xsl:if test="$placeOfNotes eq 'end'">
                            <span class="footnote">
                                <xsl:copy-of select="telota:ediarum_noteContent_choice(.)"/>
                            </span>
                        </xsl:if>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <!-- #### Streichung -->
            <xsl:when test="self::tei:del[not(ancestor::tei:subst)]">
                <!-- Wenn tei:del/tei:gap, dann nicht ausgeben. Streichung des Textes in del trotzdem. -->
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
            <!-- #### Zeitgenössische Korrekturen -->
            <xsl:when test="self::tei:subst">
                <xsl:apply-templates mode="#current" select="./tei:add"/>
                <xsl:if test="$placeOfNotes eq 'end'">
                    <span class="footnote">
                        <xsl:copy-of select="telota:ediarum_noteContent_subst(.)"/>
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
                <!-- Wenn tei:del/tei:gap oder tei:del in tei:subst, dann nicht ausgeben. -->
                <xsl:when test="self::tei:del and .[tei:gap] or self::tei:del[(ancestor::tei:subst)]"/>
                <xsl:otherwise>
                    <xsl:copy-of select="telota:endnoteInText($criticalAppCounter)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        
    </xsl:template>
    
    <!-- ## Kritischer Apparat - Endnoten -->
    <xsl:template mode="criticalApp" match="tei:add[not(ancestor::tei:subst)] |
                                            tei:choice[tei:abbr | tei:corr | tei:orig] |
                                            tei:del[not(tei:gap)][not(ancestor::tei:subst)] |
                                            tei:gap |
                                            tei:note[ancestor::tei:div][not(@place='foot') and not(ancestor::tei:seg)] |
                                            tei:subst |
                                            tei:unclear">
        
        <xsl:variable name="criticalAppCounter">
            <xsl:number level="any" format="aa" count="tei:add[not(ancestor::tei:subst)] |
                                                       tei:choice[tei:abbr | tei:corr | tei:orig] |
                                                       tei:del[not(tei:gap)][not(ancestor::tei:subst)] |
                                                       tei:gap |
                                                       tei:note[ancestor::tei:div][not(@place='foot') and not(ancestor::tei:seg)] |
                                                       tei:subst |
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
                <xsl:when test="self::tei:del[not(ancestor::tei:subst)]">
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
                <!-- #### Zeitgenössische Korrekturen -->
                <xsl:when test="self::tei:subst">
                    <xsl:copy-of select="telota:ediarum_noteContent_subst(.)"/>
                </xsl:when>
                <!-- #### Unsichere Lesart -->
                <xsl:when test="self::tei:unclear">
                    <xsl:copy-of select="telota:ediarum_noteContent_unclear(.)"/>
                </xsl:when>
            </xsl:choose>
        </li>
        
    </xsl:template>
    
    
    
</xsl:stylesheet>

