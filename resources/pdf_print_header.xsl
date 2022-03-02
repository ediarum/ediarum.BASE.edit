<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:telota="http://www.telota.de"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="#all"
    version="2.0">
    
    
    <!-- pdf_print_header.xsl - Sammlung der Templates und Funktionen für die Header-Elemente. -->
    <!--                        Werden über Namen in pdf_print.xsl aufgerufen.                 -->
    
    
    <!-- ########################### -->
    <!-- ### Header - Funktionen ### -->
    <!-- ########################### -->
    
    <!-- # getCreationalData - Nimmt ein correspAction- oder creation-Element entgegen und gibt die Daten formatiert aus. -->
    <xsl:function name="telota:getCreationalData">
        <xsl:param name="input"/>
        <xsl:param name="typePlace"/>
        <xsl:param name="typeDate"/>
        
        <p class="creationalData">
            <xsl:for-each select="$input/tei:persName">
                <xsl:value-of select="telota:getPerson(.)"/>
                <br/>
            </xsl:for-each>            
            <xsl:for-each select="$input/tei:orgName">
                <xsl:value-of select="."/>
                <br/>
            </xsl:for-each>            
            <xsl:for-each select="$input/tei:placeName">
                <xsl:value-of select="$typePlace"/>
                <xsl:text>: </xsl:text>
                <xsl:value-of select="."/>
                <br/>
            </xsl:for-each>            
            <xsl:value-of select="$typeDate"/>
            <xsl:text>: </xsl:text>
            <xsl:value-of select="telota:getDate($input/tei:date)">                
            </xsl:value-of>
        </p>        
    </xsl:function>
    
    <!-- # getDate - Nimmt ein Datum entgegen und gibt je nach Attribut die richtige Beschreibung zurück. -->
    <xsl:function name="telota:getDate">
        <xsl:param name="date"/>
        <xsl:choose>
            <xsl:when test="$date[@when]">
                <xsl:value-of select="$date/@when"/>
            </xsl:when>
            <xsl:when test="$date[@from and @to]">
                <xsl:text>zwischen </xsl:text>
                <xsl:value-of select="$date/@from"/>
                <xsl:text> und </xsl:text>
                <xsl:value-of select="$date/@to"/>
            </xsl:when>
            <xsl:when test="$date[@from]">
                <xsl:text>nach </xsl:text>
                <xsl:value-of select="$date/@from"/>
            </xsl:when>
            <xsl:when test="$date[@to]">
                <xsl:text>vor </xsl:text>
                <xsl:value-of select="$date/@to"/>
            </xsl:when>
            <xsl:when test="$date[@notBefore and @notAfter]">
                <xsl:text>nicht vor </xsl:text>
                <xsl:value-of select="$date/@notBefore"/>
                <xsl:text> und nicht nach </xsl:text>
                <xsl:value-of select="$date/@notAfter"/>
            </xsl:when>
            <xsl:when test="$date[@notBefore]">
                <xsl:text>nicht vor </xsl:text>
                <xsl:value-of select="$date/@notBefore"/>
            </xsl:when>
            <xsl:when test="$date[@notAfter]">
                <xsl:text>nicht nach </xsl:text>
                <xsl:value-of select="$date/@notAfter"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>DATUMSATTRIBUT PRÜFEN</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <!-- # getMsDesc - Nimmt msDesc/@rend entgegen und gibt die aufgelöste Bedeutung zurück. -->
    <xsl:function name="telota:getMsDesc">
        <xsl:param name="msDesc"/>
        <xsl:variable name="msDescType">
            <xsl:choose>
                <xsl:when test="$msDesc/(@rend|@type) eq 'concept'"><xsl:text>Entwurf: </xsl:text></xsl:when>
                <xsl:when test="$msDesc/(@rend|@type) eq 'manuscript'"><xsl:text>Handschrift: </xsl:text></xsl:when>
                <xsl:when test="$msDesc/(@rend|@type) eq 'notExtant'"><xsl:text>Erschlossen: </xsl:text></xsl:when>
                <xsl:when test="$msDesc/(@rend|@type) eq 'copy'"><xsl:text>Abschrift: </xsl:text></xsl:when>
                <xsl:when test="$msDesc/(@rend|@type) eq 'print'"><xsl:text>Nur Druckzeuge vorhanden: </xsl:text></xsl:when>
                <xsl:when test="$msDesc/(@rend|@type) eq 'print-as-print'"><xsl:text>Druck (als solcher): </xsl:text></xsl:when>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="msDescIdent">
            <xsl:value-of select="$msDesc//tei:msIdentifier//*"/>
        </xsl:variable>
        <xsl:sequence select="$msDescType, $msDescIdent"/>
    </xsl:function>
    
    <!-- # getPerson - Nimmt ein persName-Element entgegen und formatiert, falls vorhanden, nach "Nachnache, Vorname". -->
    <xsl:function name="telota:getPerson">
        <xsl:param name="person"/>
        <xsl:choose>
            <xsl:when test="$person[tei:surname and tei:forename]">
                <xsl:value-of select="$person/tei:surname"/>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="$person/tei:forename"/>
            </xsl:when>
            <xsl:when test="$person[tei:surname]">
                <xsl:value-of select="$person/tei:surname"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$person"/>
            </xsl:otherwise>
        </xsl:choose>        
    </xsl:function>
    
    
    
    
    
    <!-- ###################################### -->
    <!-- ### Header - Template-Definitionen ### -->
    <!-- ###################################### -->
    
    <!-- # Dokumentenkopf -->        
    <!-- ## Titel des Dokuments -->
    <xsl:template name="ediarum_headerTitle">
        <h1 class="title">
            <xsl:if test=".//tei:titleStmt/tei:title/tei:idno">
                <xsl:value-of select=".//tei:titleStmt/tei:title/tei:idno/text()"/>
                <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:value-of select=".//tei:titleStmt/tei:title/text()"/>
        </h1>
    </xsl:template>
    
    <!-- ## Verantwortlichkeiten -->
    <xsl:template name="ediarum_headerAuthor">
        <xsl:for-each select=".//tei:titleStmt/tei:author">
            <span class="author">
                <xsl:value-of select=".//tei:surname"/>
                <xsl:text>, </xsl:text>
                <xsl:value-of select=".//tei:forename"/>
                <xsl:if test="./tei:note">
                    <span class="authorEditorNote">
                        <xsl:apply-templates select="./tei:note"/>
                    </span>
                </xsl:if>
            </span>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="ediarum_headerEditor">
        <xsl:for-each select=".//tei:titleStmt/tei:editor">
            <span class="editor">
                <xsl:value-of select=".//tei:surname"/>
                <xsl:text>, </xsl:text>
                <xsl:value-of select=".//tei:forename"/>
                <xsl:if test="./tei:note">
                    <span class="authorEditorNote">
                        <xsl:apply-templates select="./tei:note"/>
                    </span>
                </xsl:if>
            </span>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="ediarum_headerResp">
        <xsl:for-each select=".//tei:titleStmt/tei:respStmt">
            <span class="respStmt">
                <xsl:value-of select=".//tei:surname"/>
                <xsl:text>, </xsl:text>
                <xsl:value-of select=".//tei:forename"/>
                <xsl:text> (</xsl:text>
                <xsl:value-of select=".//tei:resp//text()"/>
                <xsl:text>)</xsl:text>
            </span>
        </xsl:for-each>
    </xsl:template>
    
    <!-- ## Titel des Vorhabens -->
    <xsl:template name="ediarum_headerEditionStmt">
        <p class="editionStmt"><xsl:value-of select=".//tei:editionStmt/tei:edition/tei:title"/></p>
    </xsl:template>
    
    <!-- ## Herausgebende Instition -->
    <xsl:template name="ediarum_headerPublicationStmt">
        <p class="publicationStmt"><xsl:value-of select=".//tei:publicationStmt/tei:publisher"/></p>
    </xsl:template>
    
    <!-- ## Hinweise aus noteStmt -->
    <xsl:template name="ediarum_headerNote">
        <p class="noteStmt">
            <xsl:for-each select=".//tei:noteStmt/tei:note">
                <span class="headerNote"><xsl:value-of select="."/></span>
            </xsl:for-each>
        </p>
    </xsl:template>
    
    <!-- ## Dokumentenbeschreibung -->
    <xsl:template name="ediarum_headerMsDesc">
        <p class="msDesc">
            <xsl:value-of select="telota:getMsDesc(.//tei:sourceDesc/tei:msDesc)"/>
            <br/>
            <xsl:value-of select=".//tei:sourceDesc/tei:msDesc//tei:physDesc//*"/>
            <xsl:if test=".//tei:sourceDesc/tei:listWit">
                <br/>
                <xsl:for-each select=".//tei:sourceDesc/tei:listWit/tei:witness">
                    <xsl:choose>
                        <xsl:when test="./tei:msDesc">
                            <xsl:value-of select="telota:getMsDesc(./tei:msDesc)"/>
                            <br/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select=".//*"/>
                            <br/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:if>
        </p>
    </xsl:template>
    
    <!-- # Metadaten zum Inhalt -->
    <!-- ## Angaben zur Korrespondenz (Brief) -->
    <xsl:template name="ediarum_headerCorresp">
        <xsl:for-each select=".//tei:correspDesc//tei:correspAction">
            <xsl:choose>
                <xsl:when test=".[@type='sent']">
                    <xsl:sequence select="telota:getCreationalData(., 'Schreibort', 'Schreibdatum')"/>
                </xsl:when>
                <xsl:when test=".[@type='received']">
                    <xsl:sequence select="telota:getCreationalData(., 'Empfangsort', 'Empfangsdatum')"/>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
        <p class="correspContext">
            <xsl:if test=".//tei:correspDesc//tei:correspContext">
                <span class="infoTitle"><xsl:text>Korrespondenzkontext: </xsl:text></span>
                <br/>
                <xsl:for-each select=".//tei:correspDesc//tei:correspContext/tei:ref">
                    <xsl:choose>
                        <xsl:when test=".[@type='prev']">
                            <xsl:text>vorherige Korrespondenz: </xsl:text>
                            <xsl:value-of select="./@target"/>
                            <xsl:text> (</xsl:text>
                            <xsl:value-of select="."/>
                            <xsl:text>) </xsl:text>
                            <br/>
                        </xsl:when>
                        <xsl:when test=".[@type='next']">
                            <xsl:text>folgende Korrespondenz: </xsl:text>
                            <xsl:value-of select="./@target"/>
                            <xsl:text> (</xsl:text>
                            <xsl:value-of select="."/>
                            <xsl:text>) </xsl:text>
                            <br/>
                        </xsl:when>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:if>
            <xsl:for-each select=".//tei:correspDesc/tei:note">
                <span class="infoTitle"><xsl:text>Anmerkung: </xsl:text></span>
                <xsl:value-of select="."/>
                <br/>
            </xsl:for-each>
        </p>
    </xsl:template>
    
    <!-- ## Angaben zur Entstehung (Dokument) -->
    <xsl:template name="ediarum_headerCreation">
        <xsl:sequence select="telota:getCreationalData(.//tei:creation, 'Schreibort', 'Schreibdatum')"/>
    </xsl:template>
    <xsl:template name="ediarum_headerAbstract">
        <xsl:if test=".//tei:profileDesc/tei:abstract">
            <div class="abstract">
                <span class="infoTitle"><xsl:text>Regest: </xsl:text></span><br/>
                <xsl:apply-templates select=".//tei:profileDesc/tei:abstract"/>
            </div>
        </xsl:if>
    </xsl:template>
    
    <!-- ## Schlagworte -->
    <xsl:template name="ediarum_headerKeywords">
        <p class="keywords">
            <xsl:if test=".//tei:profileDesc/tei:textClass/tei:keywords">
                <span class="infoTitle"><xsl:text>Schlagworte: </xsl:text></span>
                <xsl:for-each select=".//tei:profileDesc/tei:textClass/tei:keywords/tei:term">
                    <xsl:value-of select="."/>
                    <xsl:if test="not(position() = last())">
                        <xsl:text>, </xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </xsl:if>
        </p>
    </xsl:template>
    
    <!-- # Bearbeitungsstatus und Änderungen -->
    <xsl:template name="ediarum_headerRevisionDesc">
        <xsl:if test=".//tei:revisionDesc/tei:listChange/tei:change">
            <p class="revision">
                <xsl:for-each select=".//tei:revisionDesc/tei:listChange/tei:change">
                    <span class="infoTitle">
                        <xsl:value-of select="./@when"/>
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="./@who"/>
                        <xsl:text>: </xsl:text>
                    </span>
                    <xsl:value-of select="."/>
                    <br/>
                </xsl:for-each>
            </p>
        </xsl:if>
    </xsl:template>
    
    <!-- # Faksimiles -->
    <xsl:template name="ediarum_facsimile">
        <xsl:if test=".//tei:facsimile">
            <span class="infoTitle"><xsl:text>Zugehörige Digitalisate: </xsl:text></span><br/>
            <xsl:for-each select=".//tei:facsimile/tei:graphic">
                <xsl:value-of select="./@url"/>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="ediarumIntro_author">
        <xsl:if test=".//tei:titleStmt/tei:author[ancestor::tei:TEI[@telota:doctype='introduction']]">
            <xsl:for-each select=".//tei:titleStmt/tei:author">
                <xsl:value-of select="./tei:persName/tei:surname"/><xsl:text>, </xsl:text><xsl:value-of select="./tei:persName/tei:forename"/>
                <xsl:if test="./tei:affiliation"><xsl:text> (</xsl:text><xsl:value-of select="./tei:affiliation"/><xsl:text>)</xsl:text></xsl:if>
                <xsl:if test="./tei:email"><br/><xsl:value-of select="./tei:email"/></xsl:if>
                <xsl:if test="./tei:note"><br/><xsl:value-of select="./tei:note"/></xsl:if>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>

