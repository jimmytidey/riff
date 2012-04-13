<?
include('header.php');
include('functions.php'); 

if (!empty($_POST['project_name'])) 

{
	$project_name = $_POST['project_name']; 
	
	if (is_dir('projects/'.$user_id.'/'.$project_name)) {
		echo "this project name already exists"; 
	}
	
	else {
		//make the project folder
		mkdir('projects/'.$user_id.'/'.$project_name, 0777);
		
		//copy template into the file 
		$src = "list.jso";
		$dest = escapeshellarg('projects/'.$user_id.'/'.$project_name);
		shell_exec("chmod -R -f 777 $dest"); 
		shell_exec("cp -r $src $dest");
	}
}
 
?>




<div id='home_page'> 
	
	<h1 id='title'>MK 2 - RIFFF</h1>
	
	
	<form method="post" action="index.php">
		
		<h3>Add new project</h3>
		<p><input type='text' id='project_name' name='project_name' value='new project name' /><input type='submit' value='save new project' id='save_project_button' /></p>
		 
		
	</form> 
	
	<h3>Existing projects</h3> 
	<?
	

	// get each entry
	$folder_array = structure_list('projects/'.$user_id.'/', 'dir');
	
	
	foreach($folder_array as $project) {
		
		$encoded_name = urlencode($user_id.'/'.$project);
		
		echo "<a href='edit.php?project_name=$encoded_name'>$project</a><br/>";
	
	}
	
	
	?>
	
</div> 

