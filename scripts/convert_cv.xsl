<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs math xd"
    xpath-default-namespace="http://joeytakeda.github.io/ns/"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:jt="http://joeytakeda.github.io/ns/"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Nov 20, 2021</xd:p>
            <xd:p><xd:b>Author:</xd:b> takeda</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
   
   <xsl:mode on-no-match="shallow-skip"/>
   
    <xsl:template match="/">
        <person xml:id="JT">
            <persName>
                <forename>Joey</forename>
                <forename type="full">Joseph</forename>
                <surname>Takeda</surname>
                <persPronouns>He/him/his</persPronouns>
            </persName>
            <ptr type="email" target="joey.takeda@gmail.com"/>
            <ptr type="github" target="https://github.com/joeytakeda"/>
            <listEvent>
                <xsl:sequence select="sort(jt:process(.), (), function($event){
                    $event/(@when|@from|@to)[1]
                    })"/>
            </listEvent>
        </person>
    </xsl:template>
    
    <xsl:function name="jt:process" as="element(tei:event)+">
        <xsl:param name="root"/>
        <xsl:apply-templates select="$root"/>
    </xsl:function>
    
    <xsl:template match="award">
        <event type="{local-name()}">
            <xsl:apply-templates select="@*"/>
            <desc>
                <xsl:apply-templates select="node()"/>
            </desc>
        </event>
    </xsl:template>
    
    
    
    <xsl:template match="job">
        <event type="{local-name()}">
            <xsl:apply-templates select="@*"/>
        </event>
    </xsl:template>
    
    <xsl:template match="title">
        <title>
            <xsl:apply-templates select="@*|node()"/>
        </title>
    </xsl:template>
    
    <xsl:template match="@*">
        <xsl:attribute name="{local-name()}" select="."/>
    </xsl:template>
    
    
    
</xsl:stylesheet>