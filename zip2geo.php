<?php
// ZIP code dictionary
include "zipcode.php.inc";
?>
<?php
if (isset($_REQUEST['zip'])) {
  $zip = $_REQUEST['zip'];
  $lat = $ziparray[$zip][0];
  $lon = $ziparray[$zip][1];
  $url = "wx.php?lat=$lat&lon=$lon";
  $urlenc = urlencode($url);
  echo "<p>ZIP code " . $zip . " = " . $ziparray[$zip][2] . "," . $ziparray[$zip][3] . " (" . $ziparray[$zip][0] . "," . $ziparray[$zip][1] . ")</p><p>Your PHPWX URL is <a href='$url'>$url</a><hr>";
}
?>
<p>PHPWX URL generator</p>
<p><form method=POST>
Enter your US ZIP code here: <input name="zip" id="zip" />
<button type=submit>Submit</button>
</form></p>

