<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:telota="http://www.telota.de"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:variable name="migratingEntry">
        <xsl:copy-of select="//(tei:place|tei:person)[./@telota:merge='2']" />
    </xsl:variable>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:place[./@telota:merge='1']">
        <xsl:variable name="flag">place</xsl:variable>
        <xsl:variable name="id">
            <xsl:choose>
                <xsl:when test="matches(./@xml:id, 'prov_')">
                    <xsl:value-of select="./@xml:id"/>
                </xsl:when>
                <xsl:when test="matches($migratingEntry/(tei:place|tei:person)/@xml:id, 'prov_')">
                    <xsl:value-of select="$migratingEntry/(tei:place|tei:person)/@xml:id"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="./@xml:id"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <place xmlns="http://www.tei-c.org/ns/1.0" xml:id="{$id}">
            <xsl:call-template name="names">
                <xsl:with-param name="flag" select="$flag"/>
            </xsl:call-template>
            <xsl:call-template name="notes"/>
            <xsl:call-template name="linkGrp"/>
            <xsl:call-template name="listPlace"/>
        </place>
    </xsl:template>
    
    <xsl:template match="tei:person[./@telota:merge='1']">
        <xsl:variable name="flag">person</xsl:variable>
        <xsl:variable name="id">
            <xsl:choose>
                <xsl:when test="matches(./@xml:id, 'prov_')">
                    <xsl:value-of select="./@xml:id"/>
                </xsl:when>
                <xsl:when test="matches($migratingEntry/(tei:place|tei:person)/@xml:id, 'prov_')">
                    <xsl:value-of select="$migratingEntry/(tei:place|tei:person)/@xml:id"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="./@xml:id"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>    
        <person xmlns="http://www.tei-c.org/ns/1.0" xml:id="{$id}">
            <xsl:call-template name="names">
                <xsl:with-param name="flag" select="$flag"/>
            </xsl:call-template>
            <xsl:call-template name="lifedates"/>
            <xsl:call-template name="notes"/>
            <xsl:call-template name="linkGrp"/>
        </person>
    </xsl:template>
    
    <xsl:template name="names">
        <xsl:param name="flag"/>
        <xsl:copy-of select="./tei:idno"/>
        <xsl:copy-of select="$migratingEntry/(tei:place|tei:person)/tei:idno"/>
        <xsl:copy-of select="./(tei:placeName|tei:persName)"/>
        <xsl:for-each select="$migratingEntry/(tei:place|tei:person)/(tei:placeName|tei:persName)">
            <xsl:choose>
                <xsl:when test="$flag='place'">
                    <placeName xmlns="http://www.tei-c.org/ns/1.0" type="alt"><xsl:value-of select="./text()"/></placeName>
                </xsl:when>
                <xsl:when test="$flag='person'">
                    <persName xmlns="http://www.tei-c.org/ns/1.0" type="alt"><xsl:copy-of select="./child::*"/></persName>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="lifedates">
        <xsl:copy-of select="(tei:birth|tei:death)"/>       
        <xsl:copy-of select="tei:floruit"/>
        <xsl:copy-of select="$migratingEntry/tei:person/tei:birth"/>
        <xsl:copy-of select="$migratingEntry/tei:person/tei:death"/>
        <xsl:copy-of select="$migratingEntry/tei:person/tei:floruit"/>
    </xsl:template>
    
    <xsl:template name="notes">
        <xsl:if test="tei:note or $migratingEntry/(tei:place|tei:person)/tei:note">
            <note xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:value-of select="tei:note"/>
                <xsl:if test="$migratingEntry/(tei:place|tei:person)/tei:note">
                    <xsl:text>, </xsl:text><xsl:value-of select="$migratingEntry/(tei:place|tei:person)/tei:note"/>
                </xsl:if>
            </note>
        </xsl:if>
    </xsl:template>
   
   <xsl:template name="linkGrp">
       <xsl:if test="tei:linkGrp or $migratingEntry/(tei:place|tei:person)/tei:linkGrp">
           <linkGrp xmlns="http://www.tei-c.org/ns/1.0">
               <xsl:copy-of select="tei:linkGrp/tei:ptr"/>
               <xsl:copy-of select="$migratingEntry/(tei:place|tei:person)/tei:linkGrp/*"/>
           </linkGrp>
       </xsl:if>
   </xsl:template>
    
    <xsl:template name="listPlace">
        <xsl:if test="tei:listPlace or $migratingEntry/tei:place/tei:listPlace">
            <listPlace xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:copy-of select="tei:listPlace/child::*"/>
                <xsl:copy-of select="$migratingEntry/tei:place/tei:listPlace/child::*"/>
            </listPlace>
        </xsl:if>
    </xsl:template>
      
    <xsl:template match="tei:place[./@telota:merge='2']|tei:person[./@telota:merge='2']"/>
    
    
</xsl:stylesheet>