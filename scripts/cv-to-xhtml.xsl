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
    <xd:doc>
        
    </xd:doc>
    
    <xsl:template match="cv">
       
            <html>
                <head>
                    <title><xsl:value-of select="name"/>: CV</title>
                    <script src="css/CV.css"/>
                </head>
                <body>
                    <h1><xsl:value-of select="name"/></h1>
                    <span class="email"><a href="mailto:{email}"><xsl:value-of select="email"/></a></span>
                    <xsl:apply-templates/>
                </body>
            </html>
        
    </xsl:template>
    
    <xsl:template match="name">
    </xsl:template>
    
    <xsl:template match="education|awards|publications|conferences|teaching|employment|service|references">
        <div>
            <h2><xsl:value-of select="title"/></h2>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
</xsl:stylesheet>