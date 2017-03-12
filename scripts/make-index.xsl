<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:jt="http://joeytakeda.github.io/ns/"
    exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/1999/xhtml"
    version="2.0">
    
    
    <!--Decide whether or not I want to display references online-->
    <xsl:param name="date"/>
    
    <xsl:template match="/">
        <xsl:result-document href="../CV_index.html">
            <html xmlns="http://www.w3.org/1999/xhtml">
                <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
                    <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,400,300,600' rel='stylesheet' type='text/css'/>
                    <link href="css/CV.css" rel="stylesheet" type="text/css"/>
                    <title>CV Index</title>
                </head>
                <body>
                    <p>See the below for versions of my CV</p>
                    <ul>
                        <li><a href="docs/CV.html">XHTML5</a></li>
                        <li><a href="docs/CV.pdf">PDF</a></li>
                        <li><a href="docs/CV.xml">TEI</a></li>
                    </ul>
                </body>
                <hr/>
                <p>This page was last updated: <xsl:value-of select="$date"/></p>
            </html>
        </xsl:result-document>
        
    </xsl:template>
  
</xsl:stylesheet>