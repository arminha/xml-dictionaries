<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" version="1.0" omit-xml-declaration="no" indent="no"/>

<xsl:template match="xdxf">
  <xsl:text disable-output-escaping="yes"><![CDATA[# Korean; English; Field; Usage; Example
]]></xsl:text>
  <xsl:apply-templates select="ar"/>
</xsl:template>

<xsl:template match="ar">
  <!-- Korean -->
  <xsl:text>"</xsl:text>
  <xsl:for-each select="head/k">
    <xsl:choose>
      <xsl:when test="position() != 1">
        <xsl:text><![CDATA[<br/>]]></xsl:text>
      </xsl:when>
    </xsl:choose>
    <xsl:value-of select="."/>
 	</xsl:for-each>
  <xsl:text>"; </xsl:text>

  <!-- English -->
  <xsl:text>"</xsl:text>
  <xsl:for-each select="def/dtrn">
    <xsl:choose>
      <xsl:when test="position() != 1">
        <xsl:text><![CDATA[<br/>]]></xsl:text>
      </xsl:when>
    </xsl:choose>
    <xsl:value-of select="."/>
 	</xsl:for-each>
  <xsl:text>"; </xsl:text>

  <!-- Field -->
  <xsl:text>"</xsl:text>
  <xsl:value-of select="def/co"/>
  <xsl:text>"; </xsl:text>

  <!-- Usage -->
  <xsl:text>"</xsl:text>
  <xsl:value-of select="def/usage"/>
  <xsl:text>"; </xsl:text>

  <!-- Example -->
  <xsl:text>"</xsl:text>
  <!-- TODO -->
  <xsl:text>"
</xsl:text>
</xsl:template>

</xsl:stylesheet>
