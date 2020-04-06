<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="xsi">
<xsl:output method="xml" omit-xml-declaration="yes" encoding="utf-8"/>
<xsl:variable name="timelayoutkey" select="/dwml/data/parameters/weather/@time-layout" />
<xsl:template match="/">
<h2>Current Conditions for <a href="{dwml/data[@type='current observations']/moreWeatherInformation}"><xsl:value-of select="dwml/data/location/area-description" /></a></h2>
<p>
<div style="float:left;">
<img src="{dwml/data[@type='current observations']/parameters/conditions-icon/icon-link}" />
</div>
<div>Weather: <xsl:value-of select="dwml/data[@type='current observations']/parameters/weather/weather-conditions[@weather-summary]/@weather-summary" /></div>
<div>Temperature: <xsl:value-of select="dwml/data[@type='current observations']/parameters/temperature[@type='apparent']/value" /> F</div>
<div>Dew Point: <xsl:value-of select="dwml/data[@type='current observations']/parameters/temperature[@type='dew point']/value" /> F, 
Humidity: <xsl:value-of select="dwml/data[@type='current observations']/parameters/humidity[@type='relative']/value" /> pct</div>
<div>Wind: <xsl:value-of select="dwml/data[@type='current observations']/parameters/wind-speed[@type='sustained']/value" /> kt, 
Gust: <xsl:value-of select="dwml/data[@type='current observations']/parameters/wind-speed[@type='gust']/value" /> kt,
Direction: <xsl:value-of select="dwml/data[@type='current observations']/parameters/direction[@type='wind']/value" /> deg</div>
<div>Observed: <xsl:value-of select="dwml/data[@type='current observations']/time-layout/start-valid-time" /></div>
</p>
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

<!--
<data type="current observations">
        <location>
                <location-key>point1</location-key>
                <point latitude="40.73" longitude="-73.42"/>
                <area-description>Farmingdale - Republic Airport, NY</area-description>
                <height datum="mean sea level" height-units="feet">72</height>
        </location>
        <moreWeatherInformation applicable-location="point1">http://www.nws.noaa.gov/data/obhistory/KFRG.html</moreWeatherInformation>  <time-layout time-coordinate="local">   <layout-key>k-p1h-n1-1</layout-key>     <start-valid-time period-name="current">2020-04-05T06:53:00-04:00</start-valid-time>    </time-layout>  <parameters applicable-location="point1">       <temperature type="apparent" units="Fahrenheit" time-layout="k-p1h-n1-1">       <value>47</value>       </temperature>  <temperature type="dew point" units="Fahrenheit" time-layout="k-p1h-n1-1">      <value>43</value>       </temperature>  <humidity type="relative" time-layout="k-p1h-n1-1">     <value>86</value>       </humidity>     <weather time-layout="k-p1h-n1-1">      <name>Weather Type, Coverage, Intensity</name>  <weather-conditions weather-summary="Overcast"/>
        <weather-conditions>    <value> <visibility units="statute miles">10.00</visibility>    </value>        </weather-conditions>   </weather>      <conditions-icon type="forecast-NWS" time-layout="k-p1h-n1-1">  <name>Conditions Icon</name>    <icon-link>http://forecast.weather.gov/newimages/medium/ovc.png</icon-link>     </conditions-icon>      <direction type="wind" units="degrees true" time-layout="k-p1h-n1-1">
   <value>170</value>      </direction>    <wind-speed type="gust" units="knots" time-layout="k-p1h-n1-1"> <value>NA</value>       </wind-speed>   <wind-speed type="sustained" units="knots" time-layout="k-p1h-n1-1">    <value>6</value>        </wind-speed>           <pressure type="barometer" units="inches of mercury" time-layout="k-p1h-n1-1">                  <value>30.04</value>            </pressure>     </parameters></data></dwml>
-->
