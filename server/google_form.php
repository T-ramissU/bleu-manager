<?php
include_once("global.php");

if (!isset($_POST["nom"]) || !isset($_POST["prenom"]) || !isset($_POST["matricule"]) || !isset($_POST["regio"]) || !isset($_POST["med"]) || !isset($_POST["tel"])) {
    http_response_code(BAD_REQUEST);
    exit();
}

$nom = $_POST["nom"];
$prenom = $_POST["prenom"];
$matricule = $_POST["matricule"];
$regio = $_POST["regio"];
$med = $_POST["med"];
$tel = $_POST["tel"];

$conn = new mysqli(MYSQL_SERVER, MYSQL_USERNAME, MYSQL_PASSWORD, MYSQL_DB);
if ($conn->connect_error) { // connection to the mysql db failed
    http_response_code(CONN_ERROR);
    exit();
}

// Execute query
$query = "INSERT INTO LISTING (Matricule,Nom,Prenom,Med,Tel,Regio) VALUES ('" . $matricule . "','" . $nom . "','" . $prenom . "','" . $med . "','" . $tel . "','" . $regio . "')" ;
$result = $conn->query($query);

if (!$result) { // bad query
    http_response_code(QUERY_ERROR);
    error_log($conn->error);
    exit();
}

http_response_code(SUCCESS);
exit();
