<?php
include_once("global.php");

// Prepare json response
header("Content-Type: application/json");

if (!isset($_POST["matricule"]) || !isset($_POST["token"] || !isset($_POST["nom"]|| !isset($_POST["prenom"]|| !isset($_POST["key"]|| !isset($_POST["value"])) {
    http_response_code(BAD_REQUEST);
    echo "[]";  // return empty json array
    exit();
}

$admin_matricule = $_POST["matricule"];
$admin_token = $_POST["token"];
$bleu_first_name = $_POST["prenom"];
$bleu_last_name = $_POST["nom"];
$bleu_key = $_POST["value"];

$conn = new mysqli(MYSQL_SERVER, MYSQL_USERNAME, MYSQL_PASSWORD, MYSQL_DB);
if ($conn->connect_error) { // connection to the mysql db failed
    http_response_code(SERVER_ERROR);
    echo "[]";
    exit();
}

// verify admin authorization
if (!checkAdmin($conn, $admin_matricule, $admin_token)) {
    $conn->close();
    http_response_code(UNAUTHORIZED);
    echo "[]";
    exit();
}

// Execute query
$query = "UPDATE LISTING FROM SET '$key'='$value' WHERE Nom='$bleu_last_name' AND Prenom='$bleu_first_name' ";
$conn->query($query);


$conn->close();
http_response_code(SUCCESS);
exit();
