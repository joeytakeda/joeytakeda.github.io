<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:jt="http://joeytakeda.github.io/ns/"
    exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/1999/XSL/Format"
    xpath-default-namespace="http://joeytakeda.github.io/ns/"
    version="2.0">
   
 
        <xsl:template match="/">
            <root font-family="Times">
                <layout-master-set>
                    <simple-page-master master-name="A4-portrait"
                        page-height="29.7cm" page-width="21.0cm" margin="2cm">
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
    
    <xsl:template match="education | awards | publications | conferences | teaching | service | employment">
        <block font-weight="bold" font-size="14pt" padding=".5em 0">
            <xsl:value-of select="title"/>
        </block>
            <table>
                <table-column column-number="1" column-width="18%"/>
                <table-column column-number="2"/>
                <table-body>
                    <xsl:apply-templates select="award | degree | publication | conference | job"/>
                </table-body>
            </table>
    </xsl:template>
    
    <xsl:template match="award | degree | publication | conference | job">
        <table-row>
            <table-cell>
                <block>
                    <xsl:apply-templates select="@when|@to|@from"/>
                </block>
            </table-cell>
            <table-cell>
                <block>
                    <xsl:apply-templates/>
                </block>
            </table-cell>
        </table-row>
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
<!--    Supress for now-->
    <xsl:template match="references | cv/name | cv/email"/>
    <!--
    <xsl:template match="*[not(self::award)]" priority="-1">
            <block>
                <xsl:apply-templates select="@*|node()"/>
            </block>
    </xsl:template>
    
    <xsl:template match="cv/*/title">
        <block font-size="14pt" font-weight="bold" padding=".5em 0">
            <xsl:apply-templates/>
        </block>
    </xsl:template>
    
    <xsl:template match="list">
        <list-block>
            <xsl:apply-templates/>
        </list-block>
    </xsl:template>
    
    <xsl:template match="list/item">
        <list-item>
            <list-item-body>
                <block>
                    <xsl:text>●</xsl:text><xsl:apply-templates/>
                </block>
            </list-item-body>
        </list-item>
    </xsl:template>
    
    <xsl:template match="workplace | job_title | location | class | role| byline">
        <block>
             <xsl:apply-templates/>
        </block>
    </xsl:template>
    
    <xsl:template match="publication | job | reference |degree | conference">
        <block padding=".5em 0">
            <xsl:apply-templates/>
        </block>
    </xsl:template>
    
    <xsl:template match="publication/*">
        <inline>
            <xsl:apply-templates/>
        </inline>
    </xsl:template>
    
    <xsl:template match="title[@level='m']">
        <inline font-style="italic">
            <xsl:apply-templates/>
        </inline>
    </xsl:template>-->
    
<!--    <xsl:template match="award">
        <table-row border="none">
            <table-cell border="none"><xsl:value-of select="@when"/></table-cell>
            <table-cell border="none"><xsl:value-of select="."/></table-cell>
        </table-row>
    </xsl:template>-->
  
  
    
    
    
    <!--    Inline date templates-->
    
<!--    Use year-from-date since any further specificity is likely unneccessary.-->
    
<!--    <xsl:template match="*[@when|@to|@from]">
            <!-\-<float float="left" clear="both" position="absolute" margin-right="1em">-\->
                <block margin-right="1em" intrusion-displace="block">
                    <xsl:choose>
                        <xsl:when test="@when">
                            <inline margin-right="1em">
                                <xsl:value-of select="jt:yearFromDate(@when)"/>
                            </inline>
                        </xsl:when>
                        <xsl:when test="@to | @from">
                            <xsl:value-of select="jt:yearFromDate(@from)"/><xsl:text>–</xsl:text><xsl:value-of select="jt:yearFromDate(@to)"/>
                        </xsl:when>
                    </xsl:choose>
                </block>
            <!-\-</float>-\->
            <xsl:apply-templates/>
    </xsl:template>-->
  
   <!-- <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xs="http://www.w3.org/2001/XMLSchema"
        xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
        exclude-result-prefixes="#all"
        version="2.0"
        xmlns="http://www.w3.org/1999/xhtml"
        xpath-default-namespace="http://joeytakeda.github.io/ns/"
        xmlns:hcmc="http://hcmc.uvic.ca/ns"
        xmlns:saxon="http://saxon.sf.net/"
        xmlns:jt="http://joeytakeda.github.io/ns/"
        >
        
        <xsl:template match="cv">
            <xsl:message>Creating XHTML5 CV.</xsl:message>
            <html>
                <head>
                    <title><xsl:value-of select="name"/>: CV</title>
                    <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,400,300,600' rel='stylesheet' type='text/css'/>
                    <link rel="stylesheet" href="../css/CV.css" type="text/css"/>
                </head>
                <body>
                    <h1><xsl:value-of select="name"/></h1>
                    <span class="email"><a href="mailto:{email}"><xsl:value-of select="email"/></a></span>
                    <xsl:apply-templates/>
                    <div id="revision">
                        <p>Last revision: <xsl:value-of select="format-date(current-date(),'[MNn] [D1o], [Y0001]')"/></p>
                    </div>
                </body>
                
            </html>
            
        </xsl:template>
        
        <!-\-    We manipulate those throughout.-\->
        <xsl:template match="cv/email | cv/name"/>
        
        <xsl:template match="education|awards|publications|conferences|teaching|employment|service|conferences">
            <div class="section">
                <xsl:apply-templates/>
            </div>
        </xsl:template>
        
        <xsl:template match="references">
            <div class="section">
                <xsl:apply-templates select="title"/>
                <p>References available upon request.</p>
            </div>
        </xsl:template>
        
        <xsl:template match="desc">
            <div class="desc">
                <xsl:apply-templates/>
            </div>
        </xsl:template>
        <xsl:template match="cv/*/title">
            <h2><xsl:value-of select="upper-case(.)"/></h2>
            <hr/>
        </xsl:template>
        
        <xsl:template match="workplace | job_title | location | class | role| institution | byline">
            <div class="desc">
                <xsl:apply-templates/>
            </div>
        </xsl:template>
        
        <xsl:template match="supervisor">
            <div class="desc">
                Supervisor: <xsl:apply-templates/>
            </div>
        </xsl:template>
        
        <!-\-    Suppress-\->
        <xsl:template match="job/desc"/>
        
        
        
        <xsl:template match="publication | job | reference |degree | conference">
            <div class="item">
                <xsl:apply-templates select="@*"/>
                <xsl:apply-templates select="node()"/>
            </div>
        </xsl:template>
        
        <xsl:template match="award">
            <div class="award">
                <xsl:apply-templates select="@*"/>
                <xsl:apply-templates select="node()"/>
            </div>
        </xsl:template>
        
        <xsl:template match="list">
            <ul>
                <xsl:apply-templates/>
            </ul>
        </xsl:template>
        
        <xsl:template match="list/item">
            <li>
                <xsl:apply-templates/>
            </li>
        </xsl:template>
        
        <xsl:template match="@when">
            <span class="date"><xsl:value-of select="."/></span>
        </xsl:template>
        
        <xsl:template match="@from">
            <span class="date"><xsl:value-of select="."/><xsl:if test="parent::*/@to">–<xsl:value-of select="parent::*/@to"/></xsl:if></span>
        </xsl:template>
        
        <xsl:template match="publication/title">
            <span class="title_{@level}"><xsl:apply-templates/></span>
        </xsl:template>
        
        <xsl:template match="ref[@target]">
            <a href="{@target}"><xsl:apply-templates/></a>
        </xsl:template>
        
        <!-\-    Elements to suppress-\->
        <xsl:template match="@to"/>
        
        <xsl:function name="jt:formatDate">
            <xsl:param name="inDate" as="xs:date+"/>
            <xsl:choose>
                <xsl:when test="count($inDate)=1">
                    <xsl:value-of select="format-date($inDate,'[MNn] [D1o], [Y0001]')"/>
                </xsl:when>
            </xsl:choose>
        </xsl:function>
        
    </xsl:stylesheet>-->
    
    
    <xsl:function name="jt:yearFromDate" as="xs:string">
        <xsl:param name="string"/>
        <xsl:variable name="tokens" select="tokenize($string,'-')"/>
        <xsl:value-of select="$tokens[1]"/>
    </xsl:function>
</xsl:stylesheet>