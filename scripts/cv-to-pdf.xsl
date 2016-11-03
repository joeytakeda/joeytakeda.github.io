<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/1999/XSL/Format"
    xpath-default-namespace="http://joeytakeda.github.io/ns/"
    version="2.0">
    
    <xsl:template match="/">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="page"
                    page-height="29.7cm" 
                    page-width="21cm"
                    margin-top="1cm" 
                    margin-bottom="2cm" 
                    margin-left="2.5cm" 
                    margin-right="2.5cm"
                    >
                    <fo:region-before extent="3cm"/>
                    <fo:region-body margin-top="3cm"/>
                    <fo:region-after extent="1.5cm"/>
                </fo:simple-page-master>
                
                <fo:page-sequence-master master-name="all">
                    <fo:repeatable-page-master-alternatives>
                        <fo:conditional-page-master-reference 
                            master-reference="page" page-position="first"/>
                    </fo:repeatable-page-master-alternatives>
                </fo:page-sequence-master>
            </fo:layout-master-set>
            
            <fo:page-sequence master-reference="all">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block><xsl:apply-templates/></fo:block>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    
    <!-- process paragraphs -->
    <xsl:template match="education | awards">
        <fo:block><xsl:apply-templates/></fo:block>
    </xsl:template>

</xsl:stylesheet>