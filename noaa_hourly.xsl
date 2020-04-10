<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="xsi">
<xsl:output method="xml" omit-xml-declaration="yes" encoding="utf-8"/>
<xsl:variable name="timelayoutkey" select="/dwml/data/time-layout" />
<xsl:template match="/">
<h2>Hourly Forecast for <xsl:value-of select="dwml/data/location/description" /></h2>
<p>
<xsl:text>More information on the forecast is at the </xsl:text>
<a href="{dwml/data/moreWeatherInformation}"><xsl:text>National Weather Service site</xsl:text></a>
<xsl:text>. Forecast created </xsl:text>
<xsl:value-of select="dwml/head/product/creation-date" />
<xsl:text>.</xsl:text>
</p>
<p class="weather">
<span class="time"><strong>Time</strong></span>
<span class="tempM">Temp </span>
<span class="tempW">Wind Chill </span>
<span class="tempD">Dew point </span>
<span class="hum">Humid </span>
<span class="windS">Wind </span>
<span class="windG">Gust </span>
<span class="windD">Dir </span>
<span class="POP">POP </span>
<span class="clouds">Clouds </span>
</p>
<xsl:call-template name="forloop">
<xsl:with-param name="first" select="1" />
<xsl:with-param name="last" select="24" />
</xsl:call-template>
</xsl:template>
<xsl:template name="forloop" >
<xsl:param name="first" />
<xsl:param name="last" />
<p class="weather">
<span class="time"><strong><xsl:value-of select="dwml/data/time-layout/start-valid-time[$first]" /></strong><xsl:text>: </xsl:text></span>
<span class="tempM"><xsl:value-of select="dwml/data/parameters/temperature[@type='hourly']/value[$first]" />F </span>
<span class="tempW"><xsl:value-of select="dwml/data/parameters/temperature[@type='wind chill']/value[$first]" />F </span>
<span class="tempD"><xsl:value-of select="dwml/data/parameters/temperature[@type='dew point']/value[$first]" />F </span>
<span class="hum"><xsl:value-of select="dwml/data/parameters/humidity/value[$first]" />pct </span>
<span class="windS"><xsl:value-of select="dwml/data/parameters/wind-speed[@type='sustained']/value[$first]" />kt </span>
<span class="windG"><xsl:value-of select="dwml/data/parameters/wind-speed[@type='gust']/value[$first]" />kt </span>
<span class="windD"><xsl:value-of select="dwml/data/parameters/direction[@type='wind']/value[$first]" />deg </span>
<span class="POP"><xsl:value-of select="dwml/data/parameters/probability-of-precipitation/value[$first]" />pct </span>
<span class="clouds"><xsl:value-of select="dwml/data/parameters/cloud-amount/value[$first]" />pct</span>
</p>
<xsl:if test="$first &lt; $last">
<xsl:call-template name="forloop">
<xsl:with-param name="last" select="$last" />
<xsl:with-param name="first" select="$first + 1" />
</xsl:call-template>
</xsl:if>
</xsl:template>
</xsl:stylesheet>
