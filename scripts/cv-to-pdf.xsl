<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:jt="http://joeytakeda.github.io/ns/"
    exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/1999/XSL/Format"
    xpath-default-namespace="http://joeytakeda.github.io/ns/"
    version="2.0">
    
    
    <!--Decide whether or not I want to display references online-->
    <xsl:param name="displayReferences" select="false()"/>
    
    
    <xsl:template match="/">
        <root font-family="Garamond">
            <layout-master-set>
                <simple-page-master master-name="A4-portrait"
                    page-height="29.7cm" page-width="21.0cm" margin="1in">
                    <region-body/>
                </simple-page-master>
            </layout-master-set>
            <page-sequence master-reference="A4-portrait">
                <flow flow-name="xsl-region-body">
                    <xsl:apply-templates/>
                </flow>
            </page-sequence>
        </root>
    </xsl:template>
    
    <xsl:template match="cv/name">
        <block font-weight="bold" font-size="18pt">
            <xsl:value-of select="."/>
        </block>
    </xsl:template>
    
    <xsl:template match="cv/email">
        <block font-size="10pt">
            <basic-link external-destination="mailto:{.}"><xsl:value-of select="."/></basic-link>
        </block>
    </xsl:template>
    <xsl:template match="title[not(@level='m')]">
        <block font-weight="bold" font-size="14pt" padding=".5em 0" font-family="Helvetica">
            <xsl:value-of select="."/>
        </block>
    </xsl:template>
    
    <xsl:template match="education | awards | conferences | teaching | service | employment">
        <xsl:apply-templates select="title"/>
        <xsl:variable name="dateCol" select="2"/>
        <table table-layout="fixed" width="100%">
            <xsl:variable name="dateColWidth" select="if (descendant::*[@to or @from]) then 18 else 14.5"/>
            
            <table-column column-number="{$dateCol}" column-width="{$dateColWidth}%"/>
            <table-column column-number="{if ($dateCol=1) then 2 else 1}" column-width="{100-$dateColWidth}%"/>
            <table-body>
                <xsl:apply-templates select="award | degree | conference | job">
                    <xsl:with-param name="dateCol" select="$dateCol"/>
                </xsl:apply-templates>
            </table-body>
        </table>
    </xsl:template>
    
   
    
    <xsl:template match="award | degree | conference | job">
        <xsl:param name="dateCol"/>
        <table-row>
            <xsl:variable name="content">
                <table-cell>
                    <block padding=".1em 0">
                        <xsl:apply-templates/>
                    </block>
                </table-cell>
            </xsl:variable>
              <xsl:variable name="dateCell">
                  <table-cell>
                    <block padding=".1em 0" text-align="left">
                        <inline text-align="left"><xsl:apply-templates select="@when|@to|@from"/></inline>
                    </block>
                </table-cell>
              </xsl:variable>

            <xsl:choose>
                <xsl:when test="$dateCol=1">
                    <xsl:copy-of select="$dateCell"/>
                    <xsl:copy-of select="$content"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:copy-of select="$content"/>
                    <xsl:copy-of select="$dateCell"/>
                </xsl:otherwise>
            </xsl:choose>
        </table-row>
    </xsl:template>
    
    <xsl:template match="byline | institution">
        <block>
            <xsl:apply-templates/>
        </block>
    </xsl:template>
    
    <!--    Publications are formatted differently-->
    <xsl:template match="publications">
        <block>
            <xsl:apply-templates/>
        </block>
    </xsl:template>
    
    <xsl:template match="publication">
        <block padding-bottom=".5em">
            <xsl:apply-templates/>
        </block>
    </xsl:template>
    
    <xsl:template match="title[@level='m']">
        <inline font-style="italic">
            <xsl:apply-templates/>
        </inline>
    </xsl:template>
    
    <xsl:template match="@when">
        <xsl:value-of select="jt:yearFromDate(.)"/>
    </xsl:template>
    
    <xsl:template match="@from">
        <xsl:value-of select="jt:yearFromDate(.)"/>
        <xsl:if test="not(jt:yearFromDate(parent::*/@to) = jt:yearFromDate(.))">
            <xsl:text>–</xsl:text>
        </xsl:if>
        <xsl:if test="not(parent::*/@to)">
            <xsl:text>present</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="@to">
        <xsl:variable name="preceding-from" select="parent::*/@from"/>
        <xsl:if test="not(jt:yearFromDate($preceding-from)=jt:yearFromDate(.))">
            <xsl:value-of select="jt:yearFromDate(.)"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="ref[@target]">
        <basic-link external-destination="{@target}" text-decoration="underline">
            <xsl:apply-templates/>
        </basic-link>
    </xsl:template>
    
    
    <xsl:template match="references">
        <block>
            <xsl:apply-templates select="title"/>
            <xsl:choose>
                <xsl:when test="$displayReferences">
                    <!--TODO: Make references page and add them dynamically-->
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>References available upon request.</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </block>
    </xsl:template>
    
<!--    TODO: Templates for references-->
    
    
    
    <xsl:function name="jt:yearFromDate" as="xs:string">
        <xsl:param name="string"/>
        <xsl:variable name="tokens" select="tokenize($string,'-')"/>
        <xsl:value-of select="$tokens[1]"/>
    </xsl:function>
</xsl:stylesheet>