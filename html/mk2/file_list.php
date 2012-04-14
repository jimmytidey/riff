<?
//include('header.php'); 
include('functions.php');
// get the project name from the get string 
$project_name = $_GET['project_name'];

if(!isset($user_id)) { 
    $user_id = 'tom';
}

$list = structure_list("projects/$user_id/$project_name", 'file');
$json = json_encode($list);

header('Cache-Control: no-cache, must-revalidate');
header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');
header('Content-type: application/json');

echo $json;

?>