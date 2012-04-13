<?

include('header.php'); 

// get the project name from the get string 
$project_name = $_GET['project_name'];
$json = $_GET['json'];

print_r($_GET);

include('functions.php'); 
	
$json= $_GET['json'];
$project_name= $_GET['project_name'];

write_json("projects/$user_id/$project_name/list.json', $json);

?>