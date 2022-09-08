<?php
include_once("global.php");

// Prepare json response
header("Content-Type: application/json");

// Check if the request contains all necessary information
if (!isset($_POST["orderby"])) {
    http_response_code(BAD_REQUEST);
    echo "[]"; // send empty json array
    exit();
}

$conn = new mysqli(MYSQL_DB, MYSQL_USERNAME, MYSQL_PASSWORD, MYSQL_DB);
if ($conn->connect_error) { // connection to the mysql db failed
    http_response_code(CONN_ERROR);
    echo "[]";
    exit();
}

// Execute query
$query = "SELECT * FROM tabletest ORDER BY " . $_POST["orderby"];
$result = $conn->query($query);

if (!$result) { // bad query
    http_response_code(QUERY_ERROR);
    echo "[]";
    exit();
}

// Transform query result into json and send it
$result_array = array();
while ($row = $result->fetch_assoc())
    $result_array[] = $row;
echo json_encode($result_array);

http_response_code(SUCCESS);
exit();
