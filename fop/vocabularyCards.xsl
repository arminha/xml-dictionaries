<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
	exclude-result-prefixes="fo"
>
<xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

<xsl:template match="xdxf">
<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<fo:layout-master-set>
		<fo:simple-page-master master-name="my-page" page-height="4cm" page-width="7.5cm" margin="0.3cm">
			<fo:region-body/>
			<fo:region-after/>
		</fo:simple-page-master>
	</fo:layout-master-set>
	<xsl:apply-templates select="ar"/>
</fo:root>
</xsl:template>

<xsl:template match="ar">
	<fo:page-sequence master-reference="my-page" font-family="Batang">
		<fo:static-content flow-name="xsl-region-after">
			<fo:block text-align="end" font-size="6"><xsl:value-of select="def/co"/></fo:block>
		</fo:static-content>
		<fo:flow flow-name="xsl-region-body">
			<fo:block text-align="center" alignment-baseline="central"><xsl:value-of select="head/k"/></fo:block>
		</fo:flow>
  	</fo:page-sequence>
  	
  	<fo:page-sequence master-reference="my-page" font-family="Batang">
		<fo:static-content flow-name="xsl-region-after">
			<fo:block text-align="end" font-size="6"><xsl:value-of select="def/co"/></fo:block>
		</fo:static-content>
  		<fo:flow flow-name="xsl-region-body" text-align="center">
	  		<xsl:for-each select="def">
				<fo:block><xsl:value-of select="dtrn"/></fo:block>
			</xsl:for-each>
	  	</fo:flow>
  	</fo:page-sequence>
</xsl:template>

</xsl:stylesheet>