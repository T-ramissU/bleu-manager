<?php
include_once("global.php");

if (!isset($_POST["matricule"]) || !isset($_POST["token"]) || !isset($_POST["nom"]) || !isset($_POST["prenom"]) || !isset($_POST["key"]) || !isset($_POST["value"])) {
    http_response_code(BAD_REQUEST);
    exit();
}


$admin_matricule = $_POST["matricule"];
$admin_token = $_POST["token"];
$bleu_first_name = $_POST["prenom"];
$bleu_last_name = $_POST["nom"];
$column = $_POST["key"];
$value = $_POST["value"];

$conn = new mysqli(MYSQL_SERVER, MYSQL_USERNAME, MYSQL_PASSWORD, MYSQL_DB);
if ($conn->connect_error) { // connection to the mysql db failed
    send_mail("Serveur bleusaille", "Impossible de se connecter à la DB lors de la tentative de $admin_matricule.");
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

// Execute query
$query = 'UPDATE LISTING SET '. $column . '="' . $value . '" WHERE Nom="' . $bleu_last_name . '" AND Prenom="' . $bleu_first_name. '" ';
$result = $conn->query($query);
if (!$result) {
    send_mail("Serveur bleusaille", "Impossible de mettre à jour la colonne '$column' avec la valeur '$value' pour '$bleu_last_name $bleu_first_name'.
    Requête exécutée par $admin_matricule.
    Erreur sql : {$conn->error}.");
    $conn->close();
    http_response_code(BAD_REQUEST);
    exit();
}

$conn->close();
http_response_code(SUCCESS);
exit();
