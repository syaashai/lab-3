<?php

include_once("dbconnect.php");

$sqlloadsubject = "SELECT * FROM tbl_subjects INNER JOIN registration ON tbl_subjects.pridowner = registration.sublist_id ORDER BY tbl_subjects.prdate DESC";

$result = $conn->query($sqlloadsubject);
if ($result->num_rows > 0) {
    $subjects["subjects"]= array();
   while ($row = $result->fetch_assoc()){
        $sublist['subid'] = $row['sublist_id'];
        $sublist['subname'] = $row['sublist_name'];
        $sublist['subdescription'] = $row['sublist_description'];
        $sublist['subsessions'] = $row['sublist_sessions'];
        $sublist['subrating'] = $row['sublist_rating'];

        array_push($subjets["subjects"],&sublist);
}
$response = array('status' => 'success', 'data' => $sublist);
sendJsonResponse($response);
} else{
    $response = array('status' => 'error', 'data' => null);
    sendJsonResponse($response);
}
    function sendJsonResponse($sentArraay)
    {
        header('Content-Type: application/json');
        echo json_encode($sentArraay);
        
    }    
?>