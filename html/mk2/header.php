<?php
session_start(); 

//make user validate
if (!isset($_SERVER['PHP_AUTH_USER'])) {
    header('WWW-Authenticate: Basic realm="My Realm"');
    header('HTTP/1.0 401 Unauthorized');
    echo 'Email jimmytidey@gmail.com if you forgot your password';
    exit;
} 

if (isset($_SERVER['PHP_AUTH_USER'])) { 
	//once they have validated, 
	$authorisation = array('tom' => 'beard', 'ed' => 'williams', 'test' => 'test'); 

	$allow = false;

	foreach ($authorisation as $key => $value ) {
		if ($_SERVER['PHP_AUTH_USER'] == $key && $_SERVER['PHP_AUTH_PW'] == $value) {
			$allow = true; 
			$user_id = $_SERVER['PHP_AUTH_USER'];
			$_SESSION['user_id'] = $user_id; 
		}
	}

	if ($allow != true) {
	    header('WWW-Authenticate: Basic realm="My Realm"');
	    header('HTTP/1.0 401 Unauthorized');
		exit;
	}
}	
?>

<!DOCTYPE html>
<html>
<head>
	<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>

	<link rel='stylesheet' href="style/style.css" >
</head>
<body>
