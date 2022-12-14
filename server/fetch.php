<?php
include_once("global.php");

// Prepare json response
header("Content-Type: application/json");

if (!isset($_POST["matricule"]) || !isset($_POST["token"])) {
    http_response_code(BAD_REQUEST);
    echo "[]";  // return empty json array
    exit();
}

$admin_matricule = $_POST["matricule"];
$admin_token = $_POST["token"];

$conn = new mysqli(MYSQL_SERVER, MYSQL_USERNAME, MYSQL_PASSWORD, MYSQL_DB);
if ($conn->connect_error) { // connection to the mysql db failed
    send_mail("Serveur bleusaille", "Impossible de se connecter à la DB lors de la tentative de $admin_matricule.");
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
$query = "SELECT * FROM LISTING";
$result = $conn->query($query);

if (!$result) { // bad query
    send_mail("Serveur bleusaille", "Impossible de fetch les bleu de la DB lors de la tentative de $admin_matricule.");
    $conn->close();
    http_response_code(SERVER_ERROR);
    echo "[]";
    exit();
}

// Transform query result into json and send it
$result_array = array();
while ($row = $result->fetch_assoc())
    $result_array[] = $row;
echo json_encode($result_array);

$conn->close();
http_response_code(SUCCESS);
exit();
