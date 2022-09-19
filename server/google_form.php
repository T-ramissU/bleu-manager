<?php
include_once("global.php");

if (
    !isset($_POST["nom"]) || !isset($_POST["prenom"]) || !isset($_POST["regio"]) ||
    !isset($_POST["tel"]) || !isset($_POST["sexe"]) || !isset($_POST["adresse"]) || 
    !isset($_POST["resplegal"]) || !isset($_POST["numresplegal"]) || !isset($_POST["daten"]))
{
    send_mail("Serveur bleusaille", "Attribut POST manquant lors de la requête par google form.");
    http_response_code(BAD_REQUEST);
    exit();
}

$nom = $_POST["nom"];
$prenom = $_POST["prenom"];
$regio = $_POST["regio"];
$tel = $_POST["tel"];
$sexe = $_POST["sexe"];
$adresse = $_POST["adresse"];
$respLegal = $_POST["resplegal"];
$telRespLegal = $_POST["numresplegal"];
$dateN = $_POST["daten"];

$conn = new mysqli(MYSQL_SERVER, MYSQL_USERNAME, MYSQL_PASSWORD, MYSQL_DB);
if ($conn->connect_error) { // connection to the mysql db failed
    send_mail("Serveur bleusaille", "Impossible de se connecter à la DB lors de l'ajout d'un bleu par google form. 
        Ses informations non ajoutées à la DB sont : '$nom' '$prenom' '$regio' '$tel' '$sexe' '$adresse' '$respLegal' '$telRespLegal' '$dateN'");
    $conn->close();
    http_response_code(SERVER_ERROR);
    exit();
}

// Execute query
$query = 'INSERT INTO LISTING (Nom,Prenom,Sexe,DateN,Adresse,Tel,Regio,RespLegal,NumRespLegal) VALUES
("' . $nom . '","' . $prenom .'","' . $sexe .'","' . $dateN .'","' . $adresse .'","' . $tel .'","' . $regio .'","' . $respLegal .'","' . $telRespLegal .'")';
$result = $conn->query($query);

if (!$result) { // bad query
    send_mail("Serveur bleusaille", "Impossible d'exécuter la query sql lors de l'ajout d'un bleu par google form. 
    Ses informations non ajoutées à la DB sont : '$nom' '$prenom' '$regio' '$tel' '$sexe' '$adresse' '$respLegal' '$telRespLegal' '$dateN'.
    Erreur sql : {$conn->error}.");
    $conn->close();
    http_response_code(BAD_REQUEST);
    exit();
}

$conn->close();
http_response_code(SUCCESS);
exit();
