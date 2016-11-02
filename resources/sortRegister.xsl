<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="tei:body/tei:listPerson">
        <xsl:copy>
            <xsl:apply-templates select="./tei:person">
                <xsl:sort select=".//tei:persName[@type = 'reg']/(tei:surname|tei:name)/normalize-space()" lang="de"/>
                <xsl:sort select=".//tei:persName[@type = 'reg']/tei:forename/normalize-space()" lang="de"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="tei:body/tei:listPlace">
        <xsl:copy>
            <xsl:apply-templates select="./tei:place">
                <xsl:sort select="tei:placeName[@type = 'reg']/normalize-space()" lang="de"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:body/tei:listOrg">
        <xsl:copy>
            <xsl:apply-templates select="./tei:org">
                <xsl:sort select="tei:orgName[@type = 'reg']/normalize-space()" lang="de"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="tei:body/tei:listBibl">
        <xsl:copy>
            <xsl:apply-templates select="tei:bibl">
                <xsl:sort select="tei:author/tei:persName[@type = 'reg']/normalize-space()" lang="de"/>
                <xsl:sort select="tei:author/tei:title" lang="de"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:body/tei:list">
        <xsl:copy>
            <xsl:apply-templates select="./tei:item">
                <xsl:sort select="tei:label[@type = 'reg']/normalize-space()" lang="de"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
