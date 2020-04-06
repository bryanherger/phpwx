# phpwx
PHP scripts to serve weather forecasts generated from NOAA - National Weather Service DWML feeds.

To run this, just clone or copy phpwx to your PHP-enable web server.  Edit wx.php to set your own latitude and longitude, unless you are also in Farmingdale, NY.

The issue I had writing and testing this is that CentOS packages the PHP XML classes separately.  If PHP complains that can't find the DOM objects, try "yum install php-xml" then restart the web server.


