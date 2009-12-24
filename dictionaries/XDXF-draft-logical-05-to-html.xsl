<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE stylesheet [
<!ENTITY brvbar  "&#166;" >
<!ENTITY ndash  "&#8211;" >
<!ENTITY mdash  "&#8212;" >
<!ENTITY lsaquo "&#8249;" >
<!ENTITY rsaquo "&#8250;" >
<!ENTITY larr   "&#8592;" >
<!ENTITY lang   "&#9001;" >
<!ENTITY rang   "&#9002;" >
<!ENTITY middot  "&#183;" >
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

   <xsl:template match="abbreviations">
     <span>
       <xsl:attribute name="id">
	 <xsl:value-of select="/xdxf/@lang_from"/>
       </xsl:attribute>
       <h4>
	 <xsl:call-template name="getRepresentation">
	   <xsl:with-param name="TOKEN"><xsl:value-of select="name(.)"/></xsl:with-param>
	   <xsl:with-param name="LANG"><xsl:value-of select="/xdxf/@lang_from"/></xsl:with-param>
	 </xsl:call-template>
       </h4>
     </span>
     <span>
       <xsl:attribute name="id">
	 <xsl:value-of select="/xdxf/@lang_to"/>
       </xsl:attribute>
       <h4>
	 <xsl:call-template name="getRepresentation">
	   <xsl:with-param name="TOKEN"><xsl:value-of select="name(.)"/></xsl:with-param>
	   <xsl:with-param name="LANG"><xsl:value-of select="/xdxf/@lang_to"/></xsl:with-param>
	 </xsl:call-template>
       </h4>
     </span>
     <table border="0" rules="none">
       <xsl:for-each select="child::abr_def">
	 <tr>
	   <td style="padding-right:10px;">
	     <span style="font-style:italic">
	       <xsl:attribute name="id">
		 <xsl:value-of select="@lang_user"/>
	       </xsl:attribute>
	       <xsl:apply-templates select="k"/>
	     </span>
	   </td>
	   <td>
	     <span>
	       <xsl:attribute name="id">
		 <xsl:value-of select="@lang_user"/>
	       </xsl:attribute>
	       <xsl:apply-templates select="v"/>
	     </span>
	   </td>
         </tr>
       </xsl:for-each>
     </table>
     <br/>
   </xsl:template>
   
  <xsl:template match="abr_def">
      <xsl:apply-templates select="@*|node()"/>
      <br/>
  </xsl:template>

  <xsl:template match="k">
    <xsl:choose>
      <xsl:when test="attribute::highlight">
	<span style="color:#0000ff; background-color:#ffff00">
	  <xsl:apply-templates select="@*|node()"/>
	</span>
      </xsl:when>
      <xsl:otherwise>
	<span style="color:#0000ff">
	  <xsl:apply-templates select="@*|node()"/>
	</span>
    </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="following-sibling::k[position()=1]">/</xsl:if>
    <xsl:if test="following-sibling::*[position()=1 and name()!='k']" xml:space="preserve"> </xsl:if>
  </xsl:template>

  <xsl:template match="opt">
    <span style="color:#7777ff">
      <xsl:value-of select="."/>
    </span>
  </xsl:template>

  <xsl:template match="v">
      <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="kref">
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="@url"/><xsl:if test="string-length(@url)!=0">&amp;native=<xsl:value-of select="/xdxf/@lang_native"/></xsl:if>
      </xsl:attribute>
<!--       <xsl:value-of select="."/> -->
      <xsl:apply-templates/>
    </a>
  </xsl:template>

  <xsl:template match="em">
    <em><xsl:value-of select="."/></em>
  </xsl:template>
  
  <xsl:template match="iref">
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="."/>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </a>
  </xsl:template>

  <xsl:template match="full_name">
    <span>
      <xsl:attribute name="id">
	<xsl:value-of select="@lang_user"/>
      </xsl:attribute>
      <h2>
	<xsl:apply-templates select="@*|node()"/>
      </h2>
      <br/>
      <br/>
    </span>
  </xsl:template>
  
  <xsl:template match="description">
    <span>
      <xsl:attribute name="id">
	<xsl:value-of select="@lang_user"/>
      </xsl:attribute>
      <xsl:call-template name="toggleLanguageButton"/>
      <h4>
	<xsl:call-template name="getRepresentation">
	  <xsl:with-param name="TOKEN"><xsl:value-of select="name(.)"/></xsl:with-param>
	  <xsl:with-param name="LANG"><xsl:value-of select="@lang_user"/></xsl:with-param>
	</xsl:call-template>
      </h4>
<!--       <span xml:space="preserve"> -->
      <span style="white-space: pre;">
	<xsl:apply-templates select="@*|node()"/>
      </span>
      <br/>
      <br/>
    </span>
  </xsl:template>
  
  <xsl:template match="head">
    <xsl:for-each select="k">
      <big>
	<xsl:choose>
	  <xsl:when test="attribute::highlight">
	    <span style="color:#0000ff; font-weight:bold; background-color:#ffff00">
	      <xsl:apply-templates select="@*|node()"/>
	    </span>
	    </xsl:when>
	    <xsl:otherwise>
	      <span style="color:#0000ff; font-weight:bold">
		<xsl:apply-templates select="@*|node()"/>
	      </span>
	    </xsl:otherwise>
	</xsl:choose>
      </big>
      <br/>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template match="etym">
    <br/>
    <table border="1" bordercolor="#eeeeff" rules="all" cellpadding="3">
      <tr>
	<th valign="top" style="background-color:transparent;">
	  <span style="color:#009999">
	    <xsl:call-template name="elementNames">
	      <xsl:with-param name="ELEMENTNAME"><xsl:value-of select="name(.)"/></xsl:with-param>
	    </xsl:call-template>
	  </span>
	</th>
	<td style="background-color:transparent;">
	  <xsl:apply-templates select="@*|node()"/>
	</td>
      </tr>
    </table>
  </xsl:template>
  
  <xsl:template match="related">
    (~<xsl:apply-templates select="@*|node()"/>)
  </xsl:template>


  <xsl:template match="text()[normalize-space(.)][name(..)='from' or name(..)='related']">
    <span style="color:#000088"><xsl:value-of select="."/></span>
  </xsl:template>

  <xsl:template match="alternatives">
    <xsl:apply-templates select="@*|node()"/>
  </xsl:template>

<!--   <xsl:template mode="tabledata" match="alternatives"> -->
<!--     <xsl:apply-templates mode="tabledata" select="@*|node()"/> -->
<!--   </xsl:template> -->

  <xsl:template match="from">
    <table border="0" cellpadding="0" rules="none" style="background-color:transparent">
      <tr>
	<td valign="top" style="padding-right:3px;">
<!-- 	  &larr;<xsl:if test="parent::alternatives">?</xsl:if>&ndash; -->
	  <xsl:if test="parent::alternatives">?</xsl:if>←
	</td>
	<td>
	  <xsl:apply-templates select="@*|node()"/>
	</td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="date|lang">
    <span>
      <xsl:attribute name="id">
	<xsl:value-of select="@lang_user"/>
      </xsl:attribute>
      <span class="properties">
	<xsl:apply-templates select="@*|node()"/>
      </span>
      ·
    </span>
  </xsl:template>


  <xsl:template match="idiom">
    <xsl:apply-templates select="@*|node()"/>
  </xsl:template>

  <xsl:template match="idiom[name(..)!=name(.)]">
    <br/>
    <table border="1" bordercolor="#eeeeff" rules="all" cellpadding="3">
      <tr>
	<td valign="top">
	  <span style="color:#009999; font-weight:bold">
	    <xsl:call-template name="elementNames">
	      <xsl:with-param name="ELEMENTNAME"><xsl:value-of select="name(.)"/></xsl:with-param>
	    </xsl:call-template>
	  </span>
	</td>
	<td>
	  <xsl:apply-templates select="@*|node()"/>
	</td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="elementNames">
    <xsl:param name="ELEMENTNAME"/>
    <span>
      <xsl:attribute name="id">
	<xsl:value-of select="/xdxf/@lang_from"/>
      </xsl:attribute>
      <xsl:call-template name="getRepresentation">
	<xsl:with-param name="TOKEN"><xsl:value-of select="$ELEMENTNAME"/></xsl:with-param>
	<xsl:with-param name="LANG"><xsl:value-of select="/xdxf/@lang_from"/></xsl:with-param>
      </xsl:call-template>
    </span>
    <xsl:if test="/xdxf/@lang_to!=/xdxf/@lang_from">
      <span>
	<xsl:attribute name="id">
	  <xsl:value-of select="/xdxf/@lang_to"/>
	</xsl:attribute>
	<xsl:call-template name="getRepresentation">
	  <xsl:with-param name="TOKEN"><xsl:value-of select="$ELEMENTNAME"/></xsl:with-param>
	  <xsl:with-param name="LANG"><xsl:value-of select="/xdxf/@lang_to"/></xsl:with-param>
	</xsl:call-template>
      </span>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="attributeValues">
    <xsl:param name="VALUE"/>
    <xsl:param name="ATTRIBUTE"/>
    <xsl:param name="ELEMENT"/>
    <span>
      <xsl:attribute name="id">
	<xsl:value-of select="/xdxf/@lang_from"/>
      </xsl:attribute>
      <xsl:call-template name="getRepresentation">
	<xsl:with-param name="TOKEN"><xsl:value-of select="$VALUE"/></xsl:with-param>
	<xsl:with-param name="ATTR_OF"><xsl:value-of select="$ELEMENT"/></xsl:with-param>
	<xsl:with-param name="VALUE_OF"><xsl:value-of select="$ATTRIBUTE"/></xsl:with-param>
	<xsl:with-param name="LANG"><xsl:value-of select="/xdxf/@lang_from"/></xsl:with-param>
      </xsl:call-template>
    </span>
    <xsl:if test="/xdxf/@lang_to!=/xdxf/@lang_from">
      <span>
	<xsl:attribute name="id">
	  <xsl:value-of select="/xdxf/@lang_to"/>
	</xsl:attribute>
	<xsl:call-template name="getRepresentation">
	  <xsl:with-param name="TOKEN"><xsl:value-of select="$VALUE"/></xsl:with-param>
	  <xsl:with-param name="ATTR_OF"><xsl:value-of select="$ELEMENT"/></xsl:with-param>
	  <xsl:with-param name="VALUE_OF"><xsl:value-of select="$ATTRIBUTE"/></xsl:with-param>
	  <xsl:with-param name="LANG"><xsl:value-of select="/xdxf/@lang_to"/></xsl:with-param>
	</xsl:call-template>
      </span>
    </xsl:if>
  </xsl:template>
  
  
  <xsl:template match="antonym|synonym">
    <xsl:apply-templates select="@*|node()"/>
    <xsl:if test="name(following-sibling::*[1])=name(.)">
      <xsl:text> ¦ </xsl:text>
    </xsl:if>
  </xsl:template>


  <xsl:template match="proverb|colloc|usage">
    <tr>
      <td>
	<span>
	  <xsl:attribute name="id">
	    <xsl:value-of select="@lang_user"/>
	  </xsl:attribute>
	<xsl:apply-templates select="@*|node()"/>
	</span>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="antonym[name(..)!=name(.)]|synonym[name(..)!=name(.)]">
    <span>
      <xsl:attribute name="id">
	<xsl:value-of select="@lang_user"/>
      </xsl:attribute>
    <br/>
    <table border="1" bordercolor="#eeeeff" rules="all" cellpadding="3">
      <tr>
	<td valign="top">
	  <span style="color:#009999; font-weight:bold">
	    <xsl:call-template name="elementNames">
	      <xsl:with-param name="ELEMENTNAME"><xsl:value-of select="name(.)"/></xsl:with-param>
	    </xsl:call-template>
	  </span>
	</td>
	<td>
	  <xsl:apply-templates select="@*|node()"/>
	</td>
      </tr>
    </table>
    </span>
  </xsl:template>

  <xsl:template match="proverb[name(..)!=name(.)]|colloc[name(..)!=name(.)]|usage[name(..)!=name(.)]">
    <br/>
    <table border="1" bordercolor="#eeeeff" rules="all" cellpadding="3">
      <tr>
	<td valign="top">
	  <span style="color:#009999; font-weight:bold">
	    <xsl:call-template name="elementNames">
	      <xsl:with-param name="ELEMENTNAME"><xsl:value-of select="name(.)"/></xsl:with-param>
	    </xsl:call-template>
	  </span>
	</td>
	<td>
	  <table border="0">
	    <xsl:apply-templates select="@*|node()"/>
	  </table>
	</td>
      </tr>
    </table>
  </xsl:template>

  
  <xsl:template match="tr">
    [<xsl:apply-templates select="@*|node()"/>]
    <xsl:if test="following-sibling::tr[position()=1]">/</xsl:if>
  </xsl:template>

  <xsl:template match="ex">
    <span>
      <xsl:attribute name="id">
	<xsl:value-of select="@lang_user"/>
      </xsl:attribute>
      ‹
      <span style="color:#888888">
	<xsl:apply-templates select="@*|node()"/>
      </span>
      ›
    </span>
  </xsl:template>

  <xsl:template match="dtrn">

    <xsl:if test="@type and @type!='explanation'">
      <span class="properties">
	<xsl:call-template name="attributeValues">
	  <xsl:with-param name="VALUE"><xsl:value-of select="@type"/></xsl:with-param>
	  <xsl:with-param name="ATTRIBUTE">type</xsl:with-param>
	  <xsl:with-param name="ELEMENT">dtrn</xsl:with-param>
	</xsl:call-template>
      </span>
      <xsl:text> </xsl:text>
    </xsl:if>
    
    <span>
      <xsl:attribute name="id">
	<xsl:value-of select="@lang_user"/>
      </xsl:attribute>
      <xsl:choose>
	<xsl:when test="@type='explanation'">
	  〈<xsl:apply-templates select="@*|node()"/>〉
	</xsl:when>
	<xsl:otherwise>
	  <xsl:apply-templates select="@*|node()"/>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="LANG"><xsl:value-of select="@lang_user"/></xsl:variable>
      <xsl:if test="following-sibling::dtrn[@lang_user=$LANG or not(@lang_user)]">
	<xsl:text> ¦ </xsl:text>
      </xsl:if>
    </span>

  </xsl:template>

  <xsl:template match="text()[parent::dtrn]">
    <b><xsl:value-of select="."/></b>
  </xsl:template>

  <xsl:template match="co">
    <span>
      <xsl:attribute name="id">
	<xsl:value-of select="@lang_user"/>
      </xsl:attribute>
      {<xsl:apply-templates select="@*|node()"/>}
    </span>
  </xsl:template>


  <xsl:template match="abr">
    <xsl:variable name="NAME"><xsl:value-of select="name(.)"/></xsl:variable>
    <xsl:variable name="NATIVE"><xsl:choose><xsl:when test="@lang_user=/xdxf/@lang_to">lang_to</xsl:when><xsl:when test="@lang_user=/xdxf/@lang_from">lang_from</xsl:when></xsl:choose></xsl:variable>

    <xsl:choose>
      
      <xsl:when test="@lang_user">
	<span>
	  <xsl:attribute name="id">
	    <xsl:value-of select="@lang_user"/>
	  </xsl:attribute>
	  <a style="font-style:italic">
	    <xsl:attribute name="href">
	      <xsl:value-of select="@url"/><xsl:if test="string-length(@url)!=0">&amp;native=<xsl:value-of select="$NATIVE"/></xsl:if>
	    </xsl:attribute>
	    <xsl:value-of select="."/>
	  </a>
	</span>
      </xsl:when>

      <xsl:otherwise>
	
	<xsl:choose>

	   <xsl:when test="/xdxf/representations/represent[@token=$NAME and @attribute_of='' and @value_of='']">
	     <span>
	       <xsl:attribute name="id">
		 <xsl:value-of select="/xdxf/@lang_from"/>
	       </xsl:attribute>
	       <a style="font-style:italic">
		 <xsl:attribute name="href">
		   <xsl:value-of select="@url"/><xsl:if test="string-length(@url)!=0">&amp;native=<xsl:value-of select="$NATIVE"/></xsl:if>
		 </xsl:attribute>
		 <xsl:value-of select="."/>
	       </a>
	     </span>
	     <xsl:if test="/xdxf/@lang_to!=/xdxf/@lang_from">
	       <span>
		 <xsl:attribute name="id">
		   <xsl:value-of select="/xdxf/@lang_to"/>
		 </xsl:attribute>
		 <a style="font-style:italic">
		   <xsl:attribute name="href">
		     <xsl:value-of select="@url"/><xsl:if test="string-length(@url)!=0">&amp;native=<xsl:value-of select="$NATIVE"/></xsl:if>
		   </xsl:attribute>
		   <xsl:value-of select="."/>
		 </a>
	       </span>
	     </xsl:if>
	   </xsl:when>
	  
	  <xsl:otherwise>
	    <span>
	      <a style="font-style:italic">
		<xsl:attribute name="href">
		  <xsl:value-of select="@url"/><xsl:if test="string-length(@url)!=0">&amp;native=<xsl:value-of select="$NATIVE"/></xsl:if>
		</xsl:attribute>
		<xsl:value-of select="."/>
	      </a>
	    </span>
	  </xsl:otherwise>
	  
	</xsl:choose>
	
      </xsl:otherwise>
      
    </xsl:choose>
    

  </xsl:template>

<!--   <xsl:template match="style"> -->
<!--     <span style="color:#aaaa00"> -->
<!--       <xsl:attribute name="id"> -->
<!-- 	<xsl:value-of select="@lang_user"/> -->
<!--       </xsl:attribute> -->
<!--       <em> -->
<!-- 	<xsl:value-of select="."/> -->
<!--       </em> -->
<!--     </span> -->
<!--   </xsl:template> -->

<!--   <xsl:template match="field"> -->
<!--     <span style="color:#aa8800"> -->
<!--       <xsl:attribute name="id"> -->
<!-- 	<xsl:value-of select="@lang_user"/> -->
<!--       </xsl:attribute> -->
<!--       <em> -->
<!-- 	<xsl:apply-templates select="@*|node()"/> -->
<!--       </em> -->
<!--     </span> -->
<!--   </xsl:template> -->

  <xsl:template name="getRepresentation">
    <xsl:param name="TOKEN"/>
    <xsl:param name="LANG"/>
    <xsl:param name="ATTR_OF"/>
    <xsl:param name="VALUE_OF"/>
    <xsl:choose>
      <xsl:when test="/xdxf/representations/represent[@token=$TOKEN and @attribute_of=$ATTR_OF and @value_of=$VALUE_OF and @lang_user=$LANG]">
	<xsl:for-each select="/xdxf/representations/represent[@token=$TOKEN and @attribute_of=$ATTR_OF and @value_of=$VALUE_OF and @lang_user=$LANG]">
	  <xsl:apply-templates/>
	</xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="$TOKEN"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="propertySeparator">
    <xsl:choose>
      <xsl:when test="parent::alternatives and following-sibling::* and name(following-sibling::*/@lang_user)=name(@lang_user)">
	<xsl:text>/</xsl:text>
      </xsl:when>
      <xsl:otherwise>
	<xsl:text> · </xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="of">
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="@*|node()"/>
    <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="auxiliary|field|gender|number|pos|separability|style|transitivity">

      <xsl:choose>

	<xsl:when test="@lang_user">

	  <span>
	    <xsl:attribute name="id">
	      <xsl:value-of select="@lang_user"/>
	    </xsl:attribute>
	    <span class="properties">
<!-- 	      <xsl:call-template name="getRepresentation"> -->
<!-- 		<xsl:with-param name="TOKEN"><xsl:value-of select="name(.)"/></xsl:with-param> -->
<!-- 		<xsl:with-param name="LANG" ><xsl:value-of select="@lang_user"/></xsl:with-param> -->
<!-- 	      </xsl:call-template>:  -->
	      <xsl:value-of select="."/>
	    </span>
	    <xsl:call-template name="propertySeparator"/>
<!-- 	    <xsl:text> &middot; </xsl:text> -->
	  </span>

	</xsl:when>

	<xsl:otherwise>

	  <xsl:variable name="NAME"><xsl:value-of select="name(.)"/></xsl:variable>
	  <xsl:choose>

	    <xsl:when test="/xdxf/representations/represent[@token=$NAME and @attribute_of='' and @value_of='']">

	      <span>
		<xsl:attribute name="id">
		  <xsl:value-of select="/xdxf/@lang_from"/>
		</xsl:attribute>
		<span class="properties">
<!-- 		  <xsl:call-template name="getRepresentation"> -->
<!-- 		    <xsl:with-param name="TOKEN"><xsl:value-of select="name(.)"/></xsl:with-param> -->
<!-- 		    <xsl:with-param name="LANG" ><xsl:value-of select="/xdxf/@lang_from"/></xsl:with-param> -->
<!-- 		  </xsl:call-template>:  -->
		  <xsl:value-of select="."/>
		</span>
		<xsl:call-template name="propertySeparator"/>
<!-- 		<xsl:text> &middot; </xsl:text> -->
	      </span>


	      <span>
		<xsl:attribute name="id">
		  <xsl:value-of select="/xdxf/@lang_to"/>
		</xsl:attribute>
		<span class="properties">
<!-- 		  <xsl:call-template name="getRepresentation"> -->
<!-- 		    <xsl:with-param name="TOKEN"><xsl:value-of select="name(.)"/></xsl:with-param> -->
<!-- 		    <xsl:with-param name="LANG" ><xsl:value-of select="/xdxf/@lang_to"/></xsl:with-param> -->
<!-- 		  </xsl:call-template>:  -->
		  <xsl:value-of select="."/>
		</span>
		<xsl:call-template name="propertySeparator"/>
<!-- 		<xsl:text> &middot; </xsl:text> -->
	      </span>

	    </xsl:when>

	    <xsl:otherwise>

	      <span class="properties">
		<xsl:value-of select="."/>
	      </span>
	      <xsl:call-template name="propertySeparator"/>
<!-- 	      <xsl:text> &middot; </xsl:text> -->

	    </xsl:otherwise>

	  </xsl:choose>

	</xsl:otherwise>

      </xsl:choose>
      
  </xsl:template>



  <xsl:template mode="tablehead" match="aspect|case|definiteness|degree|form|gender|mood|number|person|pos|style|tense|verbal|voice">

      <xsl:choose>

	<xsl:when test="@lang_user">
	  <td class="mtableattr">
	    <span>
	      <xsl:attribute name="id">
		<xsl:value-of select="@lang_user"/>
	      </xsl:attribute>
	      <xsl:call-template name="getRepresentation">
		<xsl:with-param name="TOKEN"><xsl:value-of select="name(.)"/></xsl:with-param>
		<xsl:with-param name="LANG"><xsl:value-of select="@lang_user"/></xsl:with-param>
	      </xsl:call-template>
	    </span>
	  </td>
	</xsl:when>

	<xsl:otherwise>

	  <xsl:variable name="NAME"><xsl:value-of select="name(.)"/></xsl:variable>
	  <xsl:choose>

	    <xsl:when test="/xdxf/representations/represent[@token=$NAME and @attribute_of='' and @value_of='']">
	      <td class="mtableattr">
		<span>
		  <xsl:attribute name="id">
		    <xsl:value-of select="/xdxf/@lang_from"/>
		  </xsl:attribute>
		  <xsl:call-template name="getRepresentation">
		    <xsl:with-param name="TOKEN"><xsl:value-of select="name(.)"/></xsl:with-param>
		    <xsl:with-param name="LANG"><xsl:value-of select="/xdxf/@lang_from"/></xsl:with-param>
		  </xsl:call-template>
		</span>
	      </td>
	      <td class="mtableattr">
		<span>
		  <xsl:attribute name="id">
		    <xsl:value-of select="/xdxf/@lang_to"/>
		  </xsl:attribute>
		  <xsl:call-template name="getRepresentation">
		    <xsl:with-param name="TOKEN"><xsl:value-of select="name(.)"/></xsl:with-param>
		    <xsl:with-param name="LANG"><xsl:value-of select="/xdxf/@lang_to"/></xsl:with-param>
		  </xsl:call-template>
		</span>
	      </td>
	    </xsl:when>

	    <xsl:otherwise>
	      <td class="mtableattr">
		<xsl:value-of select="name(.)"/>
	      </td>
	    </xsl:otherwise>

	  </xsl:choose>

	</xsl:otherwise>

      </xsl:choose>
      
  </xsl:template>



  <xsl:template mode="tabledata" match="aspect|case|definiteness|degree|form|gender|mood|number|person|pos|style|tense|verbal|voice">

    <xsl:variable name="NAME"><xsl:value-of select="name(.)"/></xsl:variable>
    <xsl:variable name="LANG"><xsl:value-of select="@lang_user"/></xsl:variable>
    
    <xsl:choose>
      
      <xsl:when test="@lang_user">
	<td class="mtableattr">
	  <span class="properties">
	    <xsl:attribute name="id">
	      <xsl:value-of select="@lang_user"/>
	    </xsl:attribute>
	    <xsl:apply-templates select="@*|node()"/>
    <xsl:if test="parent::alternatives and following-sibling::* and name(following-sibling::*/@lang_user)=name(@lang_user)">
      <xsl:text>/</xsl:text>
    </xsl:if>
	  </span>
	</td>
      </xsl:when>
      
      <xsl:otherwise>
	
	<xsl:choose>

	   <xsl:when test="/xdxf/representations/represent[@token=$NAME and @attribute_of='' and @value_of='']">
	     <td class="mtableattr">
	       <span class="properties">
		 <xsl:attribute name="id">
		   <xsl:value-of select="/xdxf/@lang_from"/>
		 </xsl:attribute>
		 <xsl:apply-templates select="@*|node()"/>
    <xsl:if test="parent::alternatives and following-sibling::* and name(following-sibling::*/@lang_user)=name(@lang_user)">
      <xsl:text>/</xsl:text>
    </xsl:if>
	       </span>
	     </td>
	     <xsl:if test="/xdxf/@lang_to!=/xdxf/@lang_from">
	     <td class="mtableattr">
	       <span class="properties">
		 <xsl:attribute name="id">
		   <xsl:value-of select="/xdxf/@lang_to"/>
		 </xsl:attribute>
		 <xsl:apply-templates select="@*|node()"/>
    <xsl:if test="parent::alternatives and following-sibling::* and name(following-sibling::*/@lang_user)=name(@lang_user)">
      <xsl:text>/</xsl:text>
    </xsl:if>
	       </span>
	     </td>
	     </xsl:if>
	   </xsl:when>
	  
	  <xsl:otherwise>
	    <td class="mtableattr">
	      <span class="properties">
		<xsl:apply-templates select="@*|node()"/>
    <xsl:if test="parent::alternatives and following-sibling::* and name(following-sibling::*/@lang_user)=name(@lang_user)">
      <xsl:text>/</xsl:text>
    </xsl:if>
	      </span>
	    </td>
	  </xsl:otherwise>
	  
	</xsl:choose>
	
      </xsl:otherwise>
      
    </xsl:choose>
    
  </xsl:template>


  <xsl:template match="m[not(parent::m)]">
    <br/>
    <table border="0" bordercolor="#ffffff" rules="all" cellpadding="2">
      <tr>
	<td class="mtableattr">
	  <xsl:apply-templates mode="tabledata" select="alternatives[not(child::k)]|aspect|case|definiteness|degree|form|gender|mood|number|person|pos|style|tense|verbal|voice"/>
	</td>
	<td class="mtableattr">
	  <table border="0" bordercolor="#ffffff" rules="all" cellpadding="2">
	    <xsl:apply-templates select="abr|alternatives/k|co|def|dtrn|etym|ex|iref|k|kref|m|style|text()|tr"/>
	  </table>
	</td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="m">
    <tr>
      <td class="mtableattr">
	  <xsl:apply-templates mode="tabledata" select="alternatives[not(child::k)]|aspect|case|definiteness|degree|form|gender|mood|number|person|pos|style|tense|verbal|voice"/>
      </td>
      <td class="mtableattr">
	<table border="0" bordercolor="#ffffff" rules="all" cellpadding="2">
	  <xsl:apply-templates select="abr|alternatives/k|co|def|dtrn|etym|ex|iref|k|kref|m|style|text()|tr"/>
	</table>
      </td>
    </tr>
  </xsl:template>


  <xsl:template match="def">
    <xsl:call-template name="def"/>
  </xsl:template>

  <xsl:template name="def">
    <xsl:apply-templates select="tr|alternatives/tr"/>
    <xsl:apply-templates select="pos"/>
    <xsl:apply-templates select="gender|alternatives/gender"/>
    <xsl:apply-templates select="transitivity"/>
    <xsl:apply-templates select="reflexivity"/>
    <xsl:apply-templates select="separability|alternatives/separability"/>
    <xsl:apply-templates select="auxiliary|alternatives/auxiliary"/>
    <xsl:apply-templates select="field"/>
    <xsl:apply-templates select="style"/>
    <xsl:apply-templates select="dtrn|co"/>
    <xsl:apply-templates select="ex|iref|kref|quote|rref"/>

    <xsl:if test="count(./def[attribute::l])&gt;0">
      <table cellpadding="3px" cellspacing="5px">
	<xsl:for-each select="child::def">
	  <tr>
	    <th valign="top" style="background-color:#eeeeee">
	      <xsl:value-of select="attribute::l"/>
	    </th>
	    <td>
	      <xsl:call-template name="def"/>
	    </td>
	  </tr>
	</xsl:for-each>
      </table>
    </xsl:if>

    <xsl:if test="count(child::def[not(attribute::l)])&gt;0">
      <xsl:for-each select="child::def[not(attribute::l)]">
	      <xsl:call-template name="def"/>
      </xsl:for-each>
    </xsl:if>

    <xsl:apply-templates select="m"/>
    <xsl:apply-templates select="etym"/>
    <xsl:apply-templates select="usage"/>
    <xsl:apply-templates select="synonym"/>
    <xsl:apply-templates select="antonym"/>
    <xsl:apply-templates select="idiom"/>
    <xsl:apply-templates select="proverb"/>
    <xsl:apply-templates select="colloc"/>

  </xsl:template>
  
  <xsl:template match="//quote/text()[normalize-space(.)][../*]">
    "<xsl:value-of select="."/>"
  </xsl:template>

  <xsl:template match="quote">
    <xsl:apply-templates select="@*|node()"/>
  </xsl:template>

  <xsl:template match="author">
    —<xsl:apply-templates select="@*|node()"/>
  </xsl:template>


  <xsl:template match="ar">
    <xsl:call-template name="toggleLanguageButton"/>
    <dl>
      <dt style="background-color:#eeeeee; padding-left:10px; padding-top:3px; padding-bottom:3px">
	<xsl:apply-templates select="head"/>
      </dt>
      <dd>
	<xsl:apply-templates select="def|m"/>
      </dd>
    </dl>
    <br/>
    <br/>
  </xsl:template>

  <xsl:template name="toggleLanguageButton">
    <form>
      <div align="right">
      <input type="button" value="Toggle user's language" onclick="toggleLanguage()"/>
      </div>
    </form>
  </xsl:template>

  <xsl:template match="/xdxf">
<!--     <![CDATA[<!DOCTYPE html -->
<!--     PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" -->
<!--     "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">]]> -->
    <html>
<!--     <html xmlns="http://www.w3.org/1999/xhtml"> -->
      <head>
	<title>XDXF dictionary query result</title>
	<script type="text/javascript">
	  function selectLanguage()
	  {
	  var spans = document.getElementsByTagName('span')

	  <!-- Find out which is the native language and which the foreign one: -->
	  var native_lang  = '<xsl:value-of select="/xdxf/@lang_to"/>'
	  var foreign_lang = '<xsl:value-of select="/xdxf/@lang_from"/>'
	  if ( '<xsl:value-of select="/xdxf/@lang_native"/>' == 'lang_from' )
	  {
	  native_lang = '<xsl:value-of select="/xdxf/@lang_from"/>'
	  foreign_lang = '<xsl:value-of select="/xdxf/@lang_to"/>'
	  }
	  <!-- alert('native: '+native_lang+' foreign: '+foreign_lang) -->


	  <!-- Make everything intended for speakers of the other language disappear: -->
	  for (i=0; i&lt;spans.length; i++)
	  {
	  if ('<xsl:value-of select="/xdxf/@lang_from"/>'!='<xsl:value-of select="/xdxf/@lang_to"/>')
	  {
	  if ( spans.item(i).getAttribute('id')==foreign_lang )
	  {
	  spans.item(i).setAttribute('style','display:none')
	  }
	  }
	  }

	  }

	  function toggleLanguage()
	  {
	  if ('<xsl:value-of select="/xdxf/@lang_from"/>'!='<xsl:value-of select="/xdxf/@lang_to"/>')
	  {
	  var spans = document.getElementsByTagName('span')
	  for (i=0; i&lt;spans.length; i++)
	  {
	  if ( spans.item(i).getAttribute('style') &amp;&amp; spans.item(i).getAttribute('style').indexOf( 'display', 0 ) &gt;= 0 &amp;&amp; spans.item(i).getAttribute('style').indexOf( 'none', 0 ) &gt;= 0 )
	  {
	  spans.item(i).setAttribute('style','')
	  }
	  else if ( spans.item(i).getAttribute('id') &amp;&amp; ( spans.item(i).getAttribute('id')=='<xsl:value-of select="/xdxf/@lang_from"/>' ) || ( spans.item(i).getAttribute('id')=='<xsl:value-of select="/xdxf/@lang_to"/>' ) )
	  {
	  spans.item(i).setAttribute('style','display:none')
	  }
	  }
	  }
	  }
	</script>
	<style type="text/css" id="css">
	  a{text-decoration: underline;}
	  a:active, a:hover{
	  color: #ff8800;
	  }	  
<!-- 	  table.mtableattr{ -->
<!-- 	  border-width: 0px; -->
<!-- 	  border-spacing: 1px; -->
<!-- 	  border-color: #ffffff; -->
<!-- 	  background-color: #ffffff; -->
<!-- 	  } -->
	  td.mtableattr, th.mtableattr{
	  background-color:#eeffdd;
<!-- 	  padding: 0px; -->
	  }
	  span.properties{
	  color:#007700;
	  font-style:italic;
	  }
	</style>
      </head>
      <body onload="selectLanguage()">
        <xsl:apply-templates select="full_name"/>
        <xsl:apply-templates select="description"/>
        <xsl:apply-templates select="abbreviations"/>
        <xsl:apply-templates select="ar"/>
      </body>
    </html>
  </xsl:template>
  
</xsl:stylesheet>