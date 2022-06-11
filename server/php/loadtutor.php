<?php

include_once("dbconnect.php");

$sqlloadtutor = "SELECT * FROM tbl_tutors INNER JOIN registration ON tbl_tutors.pridowner = registration.tutorslist_id ORDER BY tbl_tutors.prdate DESC";

$result = $conn->query($sqlloadtutor);
if ($result->num_rows > 0) {
    $tutor["tutors"]= array();
   while ($row = $result->fetch_assoc()){
        $tutorslist['tutorsid'] = $row['tutorslist_id'];
        $tutorslist['tutorsemail'] = $row['tutorslist_email'];
        $tutorslist['tutorsphone'] = $row['tutorslist_phone'];
        $tutorslist['tutorsname'] = $row['tutorslist_name'];
        $tutorslist['tutorsdescription'] = $row['tutorslist_description'];
        $tutorslist['tutorsdatereg'] = $row['tutorslist_datereg'];

        array_push($tutorsjets["tutors"],&tutorslist);
}
$response = array('status' => 'success', 'data' => $tutorslist);
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