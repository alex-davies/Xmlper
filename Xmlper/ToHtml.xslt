<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">


  <xsl:template match="/">
    <ul>
      <xsl:apply-templates/>
    </ul>
  </xsl:template>
  
  <!-- Template for pis not handled elsewhere -->
  <xsl:template match="processing-instruction()">
    <span class="tag">
      <span class="syntax">&lt;?</span>
      <span class="processing-instruction">
        <xsl:value-of select="name()"/>&#160;<xsl:value-of select="."/>
      </span>
      <span class="syntax">?&gt;</span>
    </span>
  </xsl:template>
  
  <!-- Display for comments-->
  <xsl:template match="comment()">
    <xsl:call-template name="Collapse"/>
     <span class="comment">
       <span>&lt;!--</span>
       <pre><xsl:value-of select="."/></pre>
       <span>--&gt;</span>
     </span>
  </xsl:template>
  
  <!-- Display for text-->
  <xsl:template match="text()">
      <xsl:call-template name="Collapse"/>
      <span clas="text"><xsl:value-of select="."/></span>

  </xsl:template>
  
  
  <!-- Display for attributes-->
   <xsl:template match="@*">
    <span class="attribute-name"><xsl:value-of select="name()" /></span>
    <span class="syntax equals">=</span>
    <span class="syntax quote">"</span>
    <span class="attribute-value"><xsl:value-of select="."/></span>
    <span class="syntax quote">"</span>
  </xsl:template>
  
  
  
  
  <!--
    The general principle is to look ahead at the type of children nodes
    an element has in order to better display its contents. elements with
    different nodes are treated by different templates
  -->
  
  <!-- Template for elements not handled elsewhere (leaf nodes) -->
  <xsl:template match="*">
    <xsl:call-template name="EmptyTag"/>
  </xsl:template>
  
   <!-- Template for elements with comment, pi and/or cdata children -->
   <xsl:template match="*[comment() | processing-instruction()]">
     <xsl:call-template name="Collapse"/>
     <xsl:call-template name="OpenTag"/>
     <xsl:apply-templates/>
     <xsl:call-template name="CloseTag"/>
   </xsl:template>
  

  <!-- Template for elements with only text children -->
  <xsl:template match="*[text() and not(comment() | processing-instruction())]">
    <li>
      <xsl:call-template name="Collapse"/>
      <xsl:call-template name="OpenTag"/>
      <span clas="text"><xsl:value-of select="."/></span>
      <xsl:call-template name="CloseTag"/>
    </li>
  </xsl:template>

  <!-- Template for elements with element children -->
  <xsl:template match="*[*]">
    <li>
      <xsl:call-template name="Collapse"/>
      <xsl:call-template name="OpenTag"/>
      <ul>
        <xsl:apply-templates/>
      </ul>
      <xsl:call-template name="CloseTag"/>
    </li>
  </xsl:template>
  
  
  
  
  
  <!--Templates for the tag creation-->
  <xsl:template name="Collapse">
    <span class="collapse open"/>    
  </xsl:template>
  
  <xsl:template name="OpenTag">
    <span class="tag">
      <span class="syntax">&lt;</span>
        <xsl:value-of select="name()"/>
        <xsl:apply-templates select="@*"/>
      <span class="syntax">&gt;</span>
    </span>
  </xsl:template>
  
   <xsl:template name="EmptyTag">
    <span class="tag">
      <span class="syntax">&lt;</span>
        <xsl:value-of select="name()"/>
        <xsl:apply-templates select="@*"/>
      <span class="syntax">/&gt;</span>
    </span>
  </xsl:template>
  
  <xsl:template name="CloseTag">
    <span class="tag">
      <span class="syntax">&lt;/</span>
        <xsl:value-of select="name()"/>
      <span class="syntax">&gt;</span>
    </span>
  </xsl:template>
  
</xsl:stylesheet>
