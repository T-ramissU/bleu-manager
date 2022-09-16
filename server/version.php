<?php

include_once("global.php");

// Prepare json response
header("Content-Type: application/json");

$response = array("version" => VERSION, "apk_link" => APK_LINK, "ios_link" => IOS_LINK);

echo json_encode($response);

exit();