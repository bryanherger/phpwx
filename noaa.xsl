<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="xsi">
<xsl:output method="xml" omit-xml-declaration="yes" encoding="utf-8"/>
<xsl:variable name="timelayoutkey" select="/dwml/data/parameters/weather/@time-layout" />
<xsl:template match="/">
<h2>Weather Forecast for <xsl:value-of select="dwml/data/location/area-description" /></h2>
<p>
<xsl:apply-templates select="dwml/data/parameters/hazards/hazard-conditions/hazard" />
<xsl:text>More information on the forecast is at the </xsl:text>
<a href="{dwml/data/moreWeatherInformation}"><xsl:text>National Weather Service site</xsl:text></a>
<xsl:text>. Forecast created </xsl:text>
<xsl:value-of select="dwml/head/product/creation-date" />
<xsl:text>.</xsl:text>
</p>
<xsl:call-template name="forloop">
<xsl:with-param name="first" select="1" />
<xsl:with-param name="last" select="substring($timelayoutkey,9,2)" />
</xsl:call-template>
</xsl:template>
<xsl:template name="forloop" >
<xsl:param name="first" />
<xsl:param name="last" />
<p class="weather">
<img class="wxicon" src="{dwml/data/parameters/conditions-icon/icon-link[$first]}" alt="{dwml/data/parameters/weather/weather-conditions[$first]/@weather-summary}" />
<span><strong><xsl:value-of select="dwml/data/time-layout[layout-key = $timelayoutkey]/start-valid-time[$first]/@period-name" /></strong><xsl:text>: </xsl:text>
<xsl:value-of select="dwml/data/parameters/wordedForecast/text[$first]" /></span>
</p>
<xsl:if test="$first &lt; $last">
<xsl:call-template name="forloop">
<xsl:with-param name="last" select="$last" />
<xsl:with-param name="first" select="$first + 1" />
</xsl:call-template>
</xsl:if>
</xsl:template>
<xsl:template match="hazard">
<a href="{hazardTextURL}"><em><xsl:value-of select="@headline"/></em></a><xsl:text>. </xsl:text>
</xsl:template>
</xsl:stylesheet>
