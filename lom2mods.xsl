<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:lom="http://ltsc.ieee.org/xsd/LOM"
                xmlns:rl="http://spec.edu.ru/xsd/RUS_LOM"
                xmlns="http://www.loc.gov/mods/v3"
                exclude-result-prefixes="msxsl lom rl"
>
  <xsl:output method="xml" indent="yes"/>
  <xsl:template match="lom:lom">
    <mods version="3.0">
      <xsl:apply-templates select="lom:general"/>
      <xsl:apply-templates select="lom:lifeCycle"/>
      <xsl:apply-templates select="lom:technical"/>
      <typeOfResource>text</typeOfResource>
    </mods>
  </xsl:template>

  <xsl:template match="lom:general">
    <xsl:apply-templates select="lom:title"/>
    <xsl:apply-templates select="rl:annotation"/>
    <xsl:apply-templates select="lom:description"/>
    <xsl:if test="lom:keyword">
      <subject>
        <xsl:apply-templates select="lom:keyword"/>
      </subject>
    </xsl:if>
  </xsl:template>

  <xsl:template match="lom:lifeCycle">
    <xsl:apply-templates select="rl:authorOfPublication"/>
    <xsl:apply-templates select="rl:isbn"/>
    <xsl:apply-templates select="rl:bbk"/>
    <xsl:if test="rl:placeOfPublication or rl:publishingHouse or rl:yearOfPublication">
      <originInfo>
        <xsl:apply-templates select="rl:placeOfPublication"/>
        <xsl:apply-templates select="rl:publishingHouse"/>
        <xsl:apply-templates select="rl:yearOfPublication"/>
      </originInfo>
    </xsl:if>
  </xsl:template>

  <xsl:template match="lom:technical">
    <physicalDescription>
      <xsl:apply-templates select="lom:volumeEdition"/>
    </physicalDescription>
  </xsl:template>
  
  <xsl:template match="rl:annotation">
    <abstract type="annotation">
      <xsl:value-of select="lom:string" />
    </abstract>
  </xsl:template>
  <xsl:template match="lom:description">
    <abstract type="description">
      <xsl:value-of select="lom:string" />
    </abstract>
  </xsl:template>
  <xsl:template match="lom:title">
    <titleInfo>
      <title>
        <xsl:value-of select="lom:string" />
      </title>
    </titleInfo>
  </xsl:template>
  <xsl:template match="rl:authorOfPublication">
    <name type="personal">
      <namePart>
        <xsl:value-of select="lom:string" />
      </namePart>
      <role>
        <roleTerm type="text">author</roleTerm>
      </role>
    </name>
  </xsl:template>
  <xsl:template match="rl:isbn">
    <identifier type="isbn">
      <xsl:value-of select="lom:string" />
    </identifier>
  </xsl:template>
  <xsl:template match="rl:bbk">
    <identifier type="bbk">
      <xsl:value-of select="lom:string" />
    </identifier>
  </xsl:template>
  <xsl:template match="rl:placeOfPublication">
    <place>
      <placeTerm type="text">
        <xsl:value-of select="lom:string" />
      </placeTerm>
    </place>
  </xsl:template>
  <xsl:template match="rl:publishingHouse">
    <publisher>
      <xsl:value-of select="lom:string" />
    </publisher>
  </xsl:template>
  <xsl:template match="rl:yearOfPublication">
    <dateIssued keyDate="yes" encoding="w3cdtf">
      <xsl:value-of select="lom:dateTime"/>
    </dateIssued>
  </xsl:template>
  <xsl:template match="lom:keyword">
    <topic>
      <xsl:value-of select="lom:string"/>
    </topic>
  </xsl:template>
  <xsl:template match="lom:volumeEdition">
    <extent>
      <xsl:value-of select="."/>
    </extent>
  </xsl:template>
</xsl:stylesheet>
