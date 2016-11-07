<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/1999/XSL/Format"
    xpath-default-namespace="http://joeytakeda.github.io/ns/"
    version="2.0">
   

        <xsl:template match="/">
            <fo:root>
                <fo:layout-master-set>
                    <fo:simple-page-master master-name="A4-portrait"
                        page-height="29.7cm" page-width="21.0cm" margin="2cm">
                        <fo:region-body/>
                    </fo:simple-page-master>
                </fo:layout-master-set>
                <fo:page-sequence master-reference="A4-portrait">
                    <fo:flow flow-name="xsl-region-body">
                        <xsl:apply-templates/>
                    </fo:flow>
                </fo:page-sequence>
            </fo:root>
        </xsl:template>
    
    <xsl:template match="*">
            <fo:block>
               <xsl:apply-templates/>
            </fo:block>
    </xsl:template>

</xsl:stylesheet>