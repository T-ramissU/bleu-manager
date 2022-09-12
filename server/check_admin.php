<?php
include_once("global.php");

if (!isset($_POST["matricule"]) || !isset($_POST["token"])) {
    http_response_code(BAD_REQUEST);
    exit();
}

$admin_matricule = $_POST["matricule"];
$admin_token = $_POST["token"];

$conn = new mysqli(MYSQL_SERVER, MYSQL_USERNAME, MYSQL_PASSWORD, MYSQL_DB);
if ($conn->connect_error) { // connection to the mysql db failed
    $conn->close();
    http_response_code(SERVER_ERROR);
    exit();
}

// verify admin authorization
if (!checkAdmin($conn, $admin_matricule, $admin_token)) {
    $conn->close();
    http_response_code(UNAUTHORIZED);
    exit();
}

$conn->close();
http_response_code(SUCCESS);
exit();
