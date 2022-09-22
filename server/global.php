<?php
include_once("credential.php");

// Define response codes for client 
// (based on https://en.wikipedia.org/wiki/List_of_HTTP_status_codes for standardization)
define('SUCCESS', 200);
define('BAD_REQUEST', 400);
define('UNAUTHORIZED', 401);
define('SERVER_ERROR', 500);

define('VERSION', '1.0.2');
define('APK_LINK', 'https://bleusaille.emixam.be/bleumanager.apk');
define('IOS_LINK', '');


// Send mail to server admin
function send_mail($obj, $msg) {
    $header = implode("\r\n", ["From:" . MAIL_SENDER . ";", "MIME-Version: 1.0", "Content-type: text/html; charset=utf-8"]);
    
    $msg = "<html><body>" . $msg . "</body></html>";

    mail(MAIL_DEST, $obj, $msg, $header);
    mail(MAIL_DEST_2, $obj, $msg, $header);
}

// Check app user credential 
function checkAdmin($conn, $matricule, $token) {
    $query ="SELECT * FROM ACCESS WHERE Matricule='$matricule' AND Mdp='$token'";
    $result= $conn->query($query);
    
    if (!$result) // bad query
        return false;
    
    return mysqli_num_rows($result) == 1;
}
