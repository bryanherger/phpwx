# phpwx
PHP scripts to serve weather forecasts generated from NOAA - National Weather Service DWML feeds.  XSLT are provided to render current conditions, daily descriptive forecast and hourly tabular forecast data.

To run this, just clone or copy phpwx to your PHP-enabled web server.  Edit wx.php to set your own latitude and longitude, unless you are also in or near Farmingdale, NY.  There's a [live demo](https://www.woodsidelabs.com/phpwx/wx.php) defaulting to Farmingdale, NY.

The issue I had writing and testing this is that CentOS packages the PHP XML classes separately.  If PHP complains that can't find the DOM objects, try "yum install php-xml" then restart the web server.


