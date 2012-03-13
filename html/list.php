<?

error_reporting(E_ALL);
ini_set('display_errors','On');
set_time_limit (1000);

header('Cache-Control: no-cache, must-revalidate');
header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');
header('Content-type: application/json');

include('functions.php'); 

$project_name = $_GET['project_name'];

$json = array(); 

$json['project_info'] = read_json('projects/'.$project_name."/project_info.json");

//find out which banks are available 
$bank_array = structure_list('projects/'.$project_name, "dir");
$i = 0; 
foreach ($bank_array as $bank) {
	
	$bank_option_array = structure_list('projects/'.$project_name."/".$bank, "dir");
	$j = 0;
	
	//for banks with bank options 
	if (count($bank_option_array)>0) {
		
		
		foreach ($bank_option_array as $bank_option) {
				
			$data = read_json('projects/'.$project_name."/".$bank."/".$bank_option."/bank_option_info.json");
			
			
			$order = $data['order'];
			//$order = $i; 
			$json['banks'][$i]['bank_options'][$order] = $data;
			$json['banks'][$i]['bank_options'][$order]['bank_option_name'] = $bank_option;
			
			
			//find the name of the audio file for this directory 
			$audio_file_array = structure_list('projects/'.$project_name."/".$bank."/".$bank_option, "file");
		
			if (count($audio_file_array) > 0) {
				foreach ($audio_file_array as $audio_file) {
					if ($audio_file != 'bank_option_info.json') {
						$json['banks'][$i]['bank_options'][$order]['file_location'] = 'projects/'.$project_name."/".$bank."/".$bank_option."/".$audio_file; 
					}
				}
			}	
			$j++;
		}	
	}
	
	//if there are no bank options
	else { 
		$json['banks'][$i]['bank_name'] = $bank; 
		$json['banks'][$i]['bank_options'][0]['bank_option_name'] = 0;
		$json['banks'][$i]['bank_options'][0]['file_location'] = 0;
	}
	
	
	//this to ensure output obeys the order parameter...
	ksort($json['banks'][$i]['bank_options']);
	
	$i++;
}

print_r(json_encode($json));



?>