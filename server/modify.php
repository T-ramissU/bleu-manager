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
$bleu_key = $_POST["value"];

$conn = new mysqli(MYSQL_SERVER, MYSQL_USERNAME, MYSQL_PASSWORD, MYSQL_DB);
if ($conn->connect_error) { // connection to the mysql db failed
    send_mail("Serveur bleusaille", "Impossible de se connecter a la DB lors de la tentative de : $matricule.");
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
$query = "UPDATE LISTING FROM SET '$key'='$value' WHERE Nom='$bleu_last_name' AND Prenom='$bleu_first_name' ";
$result = $conn->query($query);
$conn->close();
if (!$result) {
    send_mail("Serveur bleusaille", "Impossible d'update la colonne '$key' avec la valeur '$value' pour le bleu '$bleu_last_name $bleu_first_name'.
        Requête exécutée par $matricule");
    http_response_code(BAD_REQUEST);
    exit();
}

http_response_code(SUCCESS);
exit();
