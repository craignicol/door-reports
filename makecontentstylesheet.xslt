<?xml version="1.0" encoding="UTF-8"?>
<xslt:stylesheet xmlns:xslt="http://www.w3.org/1999/XSL/Transform" xmlns:xsl="alias" xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0" xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0" xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0" xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0" xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0" xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0" xmlns:chart="urn:oasis:names:tc:opendocument:xmlns:chart:1.0" xmlns:dr3d="urn:oasis:names:tc:opendocument:xmlns:dr3d:1.0" xmlns:math="http://www.w3.org/1998/Math/MathML" xmlns:form="urn:oasis:names:tc:opendocument:xmlns:form:1.0" xmlns:script="urn:oasis:names:tc:opendocument:xmlns:script:1.0" xmlns:ooo="http://openoffice.org/2004/office" xmlns:ooow="http://openoffice.org/2004/writer" xmlns:oooc="http://openoffice.org/2004/calc" xmlns:dom="http://www.w3.org/2001/xml-events" xmlns:xforms="http://www.w3.org/2002/xforms" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:m="http://informatik.hu-berlin.de/merge" version="1.0" exclude-result-prefixes="m">
  <xslt:namespace-alias stylesheet-prefix="xsl" result-prefix="xslt"/>
  <xslt:template match="/">
    <xsl:stylesheet xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0" xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0" xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0" xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0" xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0" xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0" xmlns:chart="urn:oasis:names:tc:opendocument:xmlns:chart:1.0" xmlns:dr3d="urn:oasis:names:tc:opendocument:xmlns:dr3d:1.0" xmlns:math="http://www.w3.org/1998/Math/MathML" xmlns:form="urn:oasis:names:tc:opendocument:xmlns:form:1.0" xmlns:script="urn:oasis:names:tc:opendocument:xmlns:script:1.0" xmlns:ooo="http://openoffice.org/2004/office" xmlns:ooow="http://openoffice.org/2004/writer" xmlns:oooc="http://openoffice.org/2004/calc" xmlns:dom="http://www.w3.org/2001/xml-events" xmlns:xforms="http://www.w3.org/2002/xforms" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.0">
      <xslt:attribute name="xsl" namespace="xmlns">http://www.w3.org/1999/XSL/Transform</xslt:attribute>
      <xsl:template match="/">
        <xslt:apply-templates/>
      </xsl:template>
      <xslt:apply-templates select="//text:section" mode="reportsections"/>
      <xsl:template xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" match="*">
        <xsl:value-of select="*"/>
      </xsl:template>
    </xsl:stylesheet>
  </xslt:template>
  <xslt:template match="text:user-field-get">
    <xsl:apply-templates>
      <xslt:attribute name="select">
        <xslt:value-of select="."/>
      </xslt:attribute>
    </xsl:apply-templates>
  </xslt:template>
  <xslt:template match="text:section" mode="reportsections">
    <xsl:template>
      <xslt:attribute name="match">
        <xslt:value-of select="@text:name"/>
      </xslt:attribute>
    <text:span>
        <xslt:attribute name="namespace">
        <xslt:value-of select="namespace-uri(.)" />
        </xslt:attribute>
          <xslt:copy-of select="./namespace::*"/>
       <xslt:copy-of select="./@*" />
      <xslt:apply-templates mode="reportsections"/>
    </text:span>
    </xsl:template>
  </xslt:template>
  <xslt:template match="text:p" mode="reportsections">
    <text:span>
      <xslt:copy-of select="./namespace::*"/>
      <xslt:copy-of select="./@*"/>
      <xslt:apply-templates/>
    </text:span>
  </xslt:template>
  <!-- Use catchall templates for reportsections -->
  <xslt:template match="*" mode="reportsections">
    <!-- Determine type of node -->
    <xslt:variable name="type1">
      <xslt:apply-templates mode="m:detect-type" select="."/>
    </xslt:variable>
    <xslt:choose>
      <!-- Elements: merge -->
      <xslt:when test="$type1='element'">
        <xslt:element name="{name(.)}" namespace="{namespace-uri(.)}">
          <xslt:copy-of select="./namespace::*"/>
          <xslt:copy-of select="./@*"/>
          <xslt:apply-templates mode="reportsections"/>
        </xslt:element>
      </xslt:when>
      <!-- Other: copy -->
      <xslt:otherwise>
        <xslt:copy-of select="."/>
      </xslt:otherwise>
    </xslt:choose>
  </xslt:template>

  <!-- strip report sections from main text -->
  <xslt:template match="text:section">
    </xslt:template>
  <xslt:template match="*">
    <!-- Determine type of node -->
    <xslt:variable name="type1">
      <xslt:apply-templates mode="m:detect-type" select="."/>
    </xslt:variable>
    <xslt:choose>
      <!-- Elements: merge -->
      <xslt:when test="$type1='element'">
        <xslt:element name="{name(.)}" namespace="{namespace-uri(.)}">
          <xslt:copy-of select="./namespace::*"/>
          <xslt:copy-of select="./@*"/>
          <xslt:apply-templates/>
        </xslt:element>
      </xslt:when>
      <!-- Other: copy -->
      <xslt:otherwise>
        <xslt:copy-of select="."/>
      </xslt:otherwise>
    </xslt:choose>
  </xslt:template>
  <!-- Type detection, thanks to M. H. Kay -->
  <xslt:template match="*" mode="m:detect-type">element</xslt:template>
  <xslt:template match="text()" mode="m:detect-type">text</xslt:template>
  <xslt:template match="comment()" mode="m:detect-type">comment</xslt:template>
  <xslt:template match="processing-instruction()" mode="m:detect-type">pi</xslt:template>
</xslt:stylesheet>
