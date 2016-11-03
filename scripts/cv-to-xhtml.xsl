<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="#all"
    version="2.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xpath-default-namespace="http://joeytakeda.github.io/ns/"
    xmlns:hcmc="http://hcmc.uvic.ca/ns"
    xmlns:saxon="http://saxon.sf.net/"
    >
    
    <xsl:template match="cv">
       <xsl:message>Creating XHTML5 CV.</xsl:message>
            <html>
                <head>
                    <title><xsl:value-of select="name"/>: CV</title>
                    <link rel="stylesheet" href="../css/CV.css" type="text/css"/>
                </head>
                <body>
                    <h1><xsl:value-of select="name"/></h1>
                    <span class="email"><a href="mailto:{email}"><xsl:value-of select="email"/></a></span>
                    <xsl:apply-templates/>
                </body>
            </html>
        
    </xsl:template>
    
<!--    We manipulate those throughout.-->
    <xsl:template match="cv/email | cv/name"/>
    
    <xsl:template match="education|awards|publications|conferences|teaching|employment|service|references">
        <div class="section">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="cv/*/title">
        <h2><xsl:value-of select="."/></h2>
    </xsl:template>
    
    <xsl:template match="publication | award | job | reference |degree">
        <div class="item">
            <xsl:apply-templates select="node()"/><xsl:apply-templates select="@*"/>
        </div>
    </xsl:template>
  
  <xsl:template match="@when">
      <span class="date"><xsl:value-of select="."/></span>
  </xsl:template>
    
    <xsl:template match="@from">
        <span class="data"><xsl:value-of select="."/><xsl:if test="parent::*/@to">–<xsl:value-of select="parent::*/@to"/></xsl:if></span>
    </xsl:template>
    
    <xsl:template match="publication/title">
        <span class="title_{@level}"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="ref[@target]">
        <a href="{@target}"><xsl:apply-templates/></a>
    </xsl:template>
    
<!--    Elements to suppress-->
    <xsl:template match="@to"/>
    
</xsl:stylesheet>