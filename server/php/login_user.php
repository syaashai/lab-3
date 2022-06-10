<?php
if (!isset($_POST)){
    echo "failed";
}

include_once("dbconnect.php");
$email = $_POST['email'];
$password = $_POST['password'];
$sqllogin = "SELECT * FROM registration WHERE user_email = '$email' AND user_password = '$password'";
$result = $conn->query($sqllogin);
$numrow = $result->num_rows;

if ($numrow > 0) {
   while ($row = $result->fetch_assoc()){
        $user['email'] = $row['user_email'];
        $user['name'] = $row['user_name'];
        $user['phoneno'] = $row['user_phoneno'];
        $user['password'] = $row['user_password'];
        $user['homeaddress'] = $row['user_homeaddress'];

}
$response = array('status' => 'success', 'data' => $user);
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