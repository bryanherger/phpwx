<html>
<head>
<link rel="stylesheet" type="text/css" href="wx.css">
</head>
<body>
<?php
// setting from https://stackoverflow.com/questions/29896106/domdocument-load-xml-rss-failed-to-open-stream
$opts = array(
    'http' => array(
        'user_agent' => 'PHP libxml agent',
    )
);
$context = stream_context_create($opts);
libxml_set_streams_context($context);
// XSLT and code below adapted from http://thejaffes.org/2012-05-26/displaying-weather-xml-noaa-using-php-and-xslt
$xsl = new DOMDocument();
$xsl->load('noaa.xsl');
$xslProc = new XSLTProcessor();
$xslProc->importStylesheet($xsl);
$xmldoc = new DOMDocument();
// edit this to match your location
$xmldoc->load('https://forecast.weather.gov/MapClick.php?lat=40.71&lon=-73.54&unit=0&lg=english&FcstType=dwml');
echo $xslProc->transformToXML($xmldoc);
?>
</body>
</html>

