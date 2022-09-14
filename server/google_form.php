<?php
include_once("global.php");

if (!isset($_POST["nom"]) || !isset($_POST["prenom"]) || !isset($_POST["regio"]) ||
    !isset($_POST["med"]) || !isset($_POST["tel"]) ||
    !isset($_POST["sexe"]) || !isset($_POST["adresse"]) || !isset($_POST["respLegal"]) ||
    isset($_POST["telRespLegal"]) ) {
    http_response_code(BAD_REQUEST);
    exit();
}

$nom = $_POST["nom"];
$prenom = $_POST["prenom"];
$regio = $_POST["regio"];
$med = $_POST["med"];
$tel = $_POST["tel"];
$sexe= $_POST["sexe"];
$adresse= $_POST["adresse"];
$respLegal= $_POST["respLegal"];
$telRespLegal=$_POST["telRespLegal"];


$conn = new mysqli(MYSQL_SERVER, MYSQL_USERNAME, MYSQL_PASSWORD, MYSQL_DB);
if ($conn->connect_error) { // connection to the mysql db failed
    http_response_code(SERVER_ERROR);
    exit();
}

// Execute query
$query = "INSERT INTO LISTING (Nom,Prenom,Sexe,DateN,Adresse,Med,Com,Tel,Regio,Supp,RespLegal,NumRespLegal) VALUES 
('$nom','$prenom','$sexe','$dateN','$adresse','$med','$com','$tel','$regio','$supp','$respLegal','$telRespLegal')";
$result = $conn->query($query);

if (!$result) { // bad query
    $conn->close();
    http_response_code(BAD_REQUEST);
    exit();
}

$conn->close();
http_response_code(SUCCESS);
exit();
