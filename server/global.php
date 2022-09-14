<?php
include_once("credential.php");

// Define response codes for client 
// (based on https://en.wikipedia.org/wiki/List_of_HTTP_status_codes for standardization)
define('SUCCESS', 200);
define('BAD_REQUEST', 400);
define('UNAUTHORIZED', 401);
define('SERVER_ERROR', 500);

function checkAdmin($conn, $matricule, $token) {
    $query ="SELECT * FROM ACCESS WHERE Matricule='{$matricule}' AND Mdp='{$token}'";
    $result= $conn->query($query);
    
    if (!$result) // bad query
        return false;
    
    error_log(mysqli_num_rows($result));
    return mysqli_num_rows($result) == 1;
}
