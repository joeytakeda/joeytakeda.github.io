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
    <xsl:param name="date"/>
    
    
    <xsl:template match="/">
        <root font-family="CormorantGaramond">
            <layout-master-set>
                <simple-page-master master-name="A4-portrait"
                    page-height="11.00in" page-width="8.50in" margin="1in">
                    <region-body/>
                </simple-page-master>
            </layout-master-set>
            <declarations>
                <x:xmpmeta xmlns:x="adobe:ns:meta/">
                    <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
                        <rdf:Description rdf:about=""
                            xmlns:dc="http://purl.org/dc/elements/1.1/">
                            <!-- Dublin Core properties go here -->
                            <dc:title>Joseph Takeda's Curriculum Vitae</dc:title>
                            <dc:creator>Joseph Takeda</dc:creator>
                            <dc:description>CV</dc:description>
                            <dc:date><xsl:value-of select="$date"/></dc:date>
                        </rdf:Description>
                        <rdf:Description rdf:about=""
                            xmlns:xmp="http://ns.adobe.com/xap/1.0/">
                            <xmp:CreatorTool>XSL-FOP.</xmp:CreatorTool>
                        </rdf:Description>
                    </rdf:RDF>
                </x:xmpmeta>
            </declarations>
            <page-sequence master-reference="A4-portrait">
                <flow flow-name="xsl-region-body">
                    <xsl:apply-templates/>
                </flow>
            </page-sequence>
        </root>
    </xsl:template>
    
    <!--Header stuff-->
    <xsl:template match="cv/name">
        <block font-size="24pt">
            <xsl:value-of select="."/>
        </block>
    </xsl:template>
    
    <xsl:template match="cv/email">
        <block font-size="10pt">
            <basic-link external-destination="mailto:{.}"><xsl:value-of select="."/></basic-link>
        </block>
        <!--Little HR-->
       <block><leader leader-pattern="rule" leader-length="100%" rule-style="solid" rule-thickness=".5pt"/></block>
    </xsl:template>
    
    <!--Each section-->
    
    <xsl:template match="title[not(@level='m')]">
        <block font-weight="600" font-size="16pt" padding=".5em 0">
            <xsl:value-of select="."/>
        </block>
    </xsl:template>
    
    <!--Make these tables-->
    <xsl:template match="education | awards | teaching | service | employment">
        <block page-break-inside="avoid">
        <xsl:apply-templates select="title"/>
        <!--Switch for if the dates should be on the left 
            or right-->
        <xsl:variable name="dateCol" select="2"/>
        <table table-layout="fixed" width="100%">
            <xsl:variable name="dateColWidth">
                <xsl:choose>
                    <xsl:when test="$dateCol=1">
                        <xsl:value-of select="if (descendant::*[@to or @from]) then 18 else 14.5"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="18"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            
            <table-column column-number="{$dateCol}" column-width="{$dateColWidth}%"/>
            <table-column column-number="{if ($dateCol=1) then 2 else 1}" column-width="{98-$dateColWidth}%"/>
            <table-body>
                <xsl:apply-templates select="award | degree | conference | job">
                    <xsl:with-param name="dateCol" select="$dateCol"/>
                </xsl:apply-templates>
            </table-body>
        </table>
        </block>
    </xsl:template>
    
   
    <!--Table rows-->
    <xsl:template match="award | degree | job">
        <xsl:param name="dateCol"/>
        <table-row>
            <xsl:variable name="content">
                <table-cell>
                    <block padding-top="{if (self::award) then .175 else .25}em" padding-right=".5em" padding-bottom="{if (self::award) then .175 else .25}em">
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
    
    <xsl:template match="degree_name | discipline | institution | class | role | instructor | workplace">
        <block>
            <xsl:apply-templates/>
        </block>
    </xsl:template>
    
    <xsl:template match="employment/job/job_title">
        <block>
            <xsl:text>Job title: </xsl:text><xsl:apply-templates/>
        </block>
    </xsl:template>
    
    <xsl:template match="service/job/job_title">
        <block>
            <xsl:apply-templates/>
        </block>
    </xsl:template>
    
    <xsl:template match="supervisor">
        <block>
            <xsl:text>Supervisor</xsl:text><xsl:if test="contains(.,' and ')">s</xsl:if>: <xsl:apply-templates/>
        </block>
    </xsl:template>
    
    <!--    Publications and conferences are formatted differently-->
    <xsl:template match="publications | conferences">
        <block>
            <xsl:apply-templates/>
        </block>
    </xsl:template>
    
    <xsl:template match="publication | conference">
        <block padding-bottom=".5em" margin-left="1.5em" text-indent="-1.5em" margin-right="3em" text-align="justify" page-break-inside="avoid">
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
        <xsl:choose>
<!--            When's a string referring to me, then bold it (usually in presentations/conferences)-->
            <xsl:when test="@target='#me'">
                <inline font-weight="600">
                    <xsl:apply-templates/>
                </inline>
            </xsl:when>
<!--            Otherwise, link outwards. -->
            <xsl:otherwise>
                <basic-link external-destination="{@target}" text-decoration="underline">
                    <xsl:apply-templates/>
                </basic-link>
            </xsl:otherwise>
        </xsl:choose>
        
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