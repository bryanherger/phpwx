<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="xsi">
<xsl:output method="xml" omit-xml-declaration="yes" encoding="utf-8"/>
<xsl:variable name="timelayoutkey" select="/dwml/data/parameters/weather/@time-layout" />
<xsl:template match="/">
<h2>Current Conditions for <a href="{dwml/data/moreWeatherInformation}"><xsl:value-of select="dwml/data/location/area-description" /></a></h2>
<p><a href="zip2geo.php">Change location</a></p>
<p>
<div style="float:left;">
<img src="{dwml/data[@type='current observations']/parameters/conditions-icon/icon-link}" />
</div>
<div>Weather: <xsl:value-of select="dwml/data[@type='current observations']/parameters/weather/weather-conditions[@weather-summary]/@weather-summary" /></div>
<div>Temperature: <xsl:value-of select="dwml/data[@type='current observations']/parameters/temperature[@type='apparent']/value" /> F</div>
<div>Dew Point: <xsl:value-of select="dwml/data[@type='current observations']/parameters/temperature[@type='dew point']/value" /> F, 
Humidity: <xsl:value-of select="dwml/data[@type='current observations']/parameters/humidity[@type='relative']/value" /> pct</div>
<div>Wind: <xsl:value-of select="dwml/data[@type='current observations']/parameters/wind-speed[@type='sustained']/value" /> mph, 
Gust: <xsl:value-of select="dwml/data[@type='current observations']/parameters/wind-speed[@type='gust']/value" /> mph,
Direction: <xsl:value-of select="dwml/data[@type='current observations']/parameters/direction[@type='wind']/value" /> deg</div>
<div>Observed: <xsl:value-of select="dwml/data[@type='current observations']/time-layout/start-valid-time" /></div>
</p>
</xsl:template>
</xsl:stylesheet>
