<?

include('functions.php'); 

$project_name = $_GET['project_name'];

//open the relevant project info file  
$project_info = read_json('projects/'.$project_name.'/project_info.json');

//calculate how many seconds long each loop is 
$beats_per_second = $project_info['bpm']/60;
$seconds_per_beat = 1/$beats_per_second; 
$step_time =($seconds_per_beat * $project_info['bpl'])*1000; 

include('header.php');


?>
<!DOCTYPE html>

<html lang="en">

<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>Chance Acorn</title>
	
	<link rel='stylesheet' href="style/style.css" >

	<script type="text/javascript" >var project_name = "<?=$project_name ?>";</script>
	
	<link rel="stylesheet" href="style/jquery-ui-1.8.17.custom.css">
	
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"> </script>

	<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>

	<script type="text/javascript" src='js/script.js' > </script>



</head>


<body> 

<div id='container'> 
	
	<h3><a href='/'>Back</a>  |  <span id='project_name'><?=$project_name ?></span> </h3> 
	
	<div id='controls'> 
		<form method="get" action="edit.php">
			<p>BPM <input type='text' id='bpm' name='bpm' size='3' value='<? echo $project_info['bpm'] ?>' />
				Beats per loop <input type='text' id='bpl' name='bpl' size='2'  value='<? echo $project_info['bpl']?>' /> 
				Number of steps <input type='text' id='steps' name='steps' size='2'  value='<? echo $project_info['steps'] ?>' />
				<input type='hidden' name='project_name' value='<?=$project_name ?>' id='project_name_field' />	
				<input type='button' value='save' name='form_submit' id='save_settings'/>
			</p>
		</form >
		
		<a href='player.php?project_name=<? echo urlencode($project_name) ?>' target='_blank' id='view_player_link' >View the player</a>
		
		<input type='button' id='explore_launch' value='Launch file manager' />
	</div>

	<div id='flash'>

		<object type="application/x-shockwave-flash"  data="random_seed_composer.swf?project_info_location=list.php?project_name=<? echo rawurlencode($project_name) ?>"  width="760" height="2600">
			<param name='wmode' value='transparent'>
		</object>
		
	</div>
	
	
	
	<div id='edit_grid' ></div> 
	

</div>
			
<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-15474551-1");
pageTracker._trackPageview();
} catch(err) {}</script>

</body>
</html>
