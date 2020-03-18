<?php

echo get_questions();


function get_connection() {

    $host = "localhost";
    $user = "question_user"; // user is aangemaakt in phpMyAdmin en heeft alle rechten op deze database
    $password = "geheim";
    $dbname = "questions";

    static $conn;
    if(!isset($conn)) {
        $conn = new mysqli($host,$user,$password,$dbname);
    }

    if($conn->connect_error) {
        die("Error while connection to database " . $conn->connect_error);
    }
    return $conn;
}


function get_questions() {
    $data=null;
    $conn = get_connection();
    $sql = "SELECT * FROM `question`";
    $stmt = $conn->prepare($sql);
    if($stmt->execute()) {
        $data = [];
        $result = $stmt->get_result();
        while($row=$result->fetch_assoc()) {
            array_push($data,$row);
        }
    }

    return json_encode($data);
}


