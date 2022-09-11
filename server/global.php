<?php
include_once("credential.php");

// Define response codes for client 
// (based on https://en.wikipedia.org/wiki/List_of_HTTP_status_codes for standardization)
define('SUCCESS', 200);
define('BAD_REQUEST', 400);
define('UNAUTHORIZED', 401);
define('QUERY_ERROR', 501);
define('CONN_ERROR', 503);

function checkAdmin($conn, $matricule, $token) {

    return true;
}
?>