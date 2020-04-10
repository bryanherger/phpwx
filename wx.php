<html>
<head>
<link rel="stylesheet" type="text/css" href="wx.css">
</head>
<body>
<?php
// ben@jp - https://stackoverflow.com/questions/3126878/get-php-timezone-name-from-latitude-and-longitude
function get_nearest_timezone($cur_lat, $cur_long, $country_code = '') {
    $timezone_ids = ($country_code) ? DateTimeZone::listIdentifiers(DateTimeZone::PER_COUNTRY, $country_code)
                                    : DateTimeZone::listIdentifiers();

    if($timezone_ids && is_array($timezone_ids) && isset($timezone_ids[0])) {

        $time_zone = '';
        $tz_distance = 0;

        //only one identifier?
        if (count($timezone_ids) == 1) {
            $time_zone = $timezone_ids[0];
        } else {

            foreach($timezone_ids as $timezone_id) {
                $timezone = new DateTimeZone($timezone_id);
                $location = $timezone->getLocation();
                $tz_lat   = $location['latitude'];
                $tz_long  = $location['longitude'];

                $theta    = $cur_long - $tz_long;
                $distance = (sin(deg2rad($cur_lat)) * sin(deg2rad($tz_lat))) 
                + (cos(deg2rad($cur_lat)) * cos(deg2rad($tz_lat)) * cos(deg2rad($theta)));
                $distance = acos($distance);
                $distance = abs(rad2deg($distance));
                // echo '<br />'.$timezone_id.' '.$distance; 

                if (!$time_zone || $tz_distance > $distance) {
                    $time_zone   = $timezone_id;
                    $tz_distance = $distance;
                } 

            }
        }
        return  $time_zone;
    }
    return 'unknown';
}
//timezone for one NY co-ordinate
//echo get_nearest_timezone(40.772222,-74.164581) ;
// more faster and accurate if you can pass the country code 
//echo get_nearest_timezone(40.772222, -74.164581, 'US') ;

date_default_timezone_set("America/New_York");
//$sun_info = date_sun_info(time(), $lat, $lon);
//foreach ($sun_info as $key => $val) {
//    date_timezone_set($val, new DateTimeZone('America/New_York'));
//    echo "<br />$key: " . date("H:i:s T", $val);
//}
?>
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
// load the forecast from NOAA/NWS API
$xmldoc = new DOMDocument();
// edit this to match your location or submit with GET/POST
$lat = 40.71; $lon = -73.54;
if (isset($_REQUEST["lat"]) && isset($_REQUEST["lon"])) {
$lat = $_REQUEST["lat"];
$lon = $_REQUEST["lon"];
}
$xmldoc->load('https://forecast.weather.gov/MapClick.php?lat=40.71&lon=-73.54&unit=0&lg=english&FcstType=dwml');
?>
<?php 
// sunrise, sunset, etc.
echo "<p class=\"astronomy\"><b>Astronomy:</b>";
$sun_info = date_sun_info(time(), $lat, $lon);
foreach ($sun_info as $key => $val) {
    date_timezone_set($val, new DateTimeZone('America/New_York'));
    echo "<br />$key: " . date("H:i:s T", $val);
}
echo "</p>";
?>
<?php
// Current conditions
$xsl = new DOMDocument();
$xsl->load('noaa_current.xsl');
$xslProc = new XSLTProcessor();
$xslProc->importStylesheet($xsl);
echo $xslProc->transformToXML($xmldoc);
?>
<?php
// Descriptive forecast
$xsl = new DOMDocument();
$xsl->load('noaa.xsl');
$xslProc = new XSLTProcessor();
$xslProc->importStylesheet($xsl);
echo $xslProc->transformToXML($xmldoc);
?>
<?php
// hourly forecast table
$xsl = new DOMDocument();
$xsl->load('noaa_hourly.xsl');
$xslProc = new XSLTProcessor();
$xslProc->importStylesheet($xsl);
$xmldoc = new DOMDocument();
$xmldoc->load('https://forecast.weather.gov/MapClick.php?lat=40.71&lon=-73.54&unit=0&lg=english&FcstType=digitalDWML'); // ?lat=40.71&lon=-73.54&FcstType=digitalDWML
echo $xslProc->transformToXML($xmldoc);
?>
</body>
</html>

