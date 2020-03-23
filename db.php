<?php



if (isset($_POST['action'])) {
    var_dump($_POST);
    $action = $_POST['action'];
    switch ($action) {
        case "delete":
            $id=$_POST['id'];
            delete_question($id);
            break;
    }
} else {
    echo get_questions();
}




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


function delete_question($id) {
    $conn = get_connection();
    $sql = "DELETE FROM `question` WHERE `idQuestion`=?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s",$id);
    if($stmt->execute()) {
       return true;
    }
    return false;
}
