﻿package {	import flash.net.URLRequest;	import flash.net.URLLoader;	import flash.events.*;	import flash.display.*; 	import flash.text.TextField;	import com.adobe.serialization.json.JSON;	import flash.media.Sound;		public class SoundObjects extends MovieClip {				public var fileObject:Object = new Object();		public var fileArray:Array = new Array();		public var soundContainer:Object = new Object();		public function make(_stage, height, grid_top, grid_left) {						//holds all the json data						//get context			var loadContext:LoadContext= new LoadContext();			_stage.addChild(loadContext);			var user_name = loadContext.userName();			var project_name = loadContext.projectName();									//get list of all sounds present			var list_url:String = "http://localhost:88/riff/html/mk2/file_list.php?project_name="+project_name;			var requester:URLRequest = new URLRequest();			var loader:URLLoader = new URLLoader();				requester.url=list_url;			loader.load(requester);			loader.addEventListener(Event.COMPLETE, decodeJSON);						//read list			function decodeJSON(event:Event) {				fileObject  = JSON.decode(loader.data);				fileArray = fileObject['files'] 				makeObjects(fileObject['files']);  				dispatchEvent(new Event("loaded", true));			}									function makeObjects(files:Object) {				var top_position = height+100+grid_top; 				var left_position = grid_left;				var transportMCs:Array = new Array();				var transportStatus:Array = new Array();				var index = 0;								for each (var file:String in files) {					Mp3 = new Sound();					var fileMC:MovieClip  = new MovieClip();					var loadPercent:LoadPercent = new LoadPercent(fileMC);					soundURL = 'http://riff.jimmytidey.co.uk/mk2/projects/'+user_name+'/'+project_name+'/'+file;															Mp3.load(new URLRequest(soundURL));					Mp3.addEventListener(ProgressEvent.PROGRESS, loadPercent.updatePercent);					Mp3.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);										//MC to contain all info about this MP3					fileMC.x = left_position;										fileMC.y = top_position;					_stage.addChild(fileMC);										//name of the audio clip 					var nameTextField:TextField  = new TextField();					nameTextField.text = file;					nameTextField.x = 60;					fileMC.addChild(nameTextField);															//preview button					var previewBtn:PreviewBtn = new PreviewBtn();					previewBtn.newBtn(fileMC, Mp3);					top_position +=20;										var file_name = file.split(".");					var clean_file_name = file_name[0];					soundContainer[clean_file_name]=Mp3;				}				dispatchEvent(new Event("done", true));			}						function errorHandler(errorEvent:IOErrorEvent):void {				trace("The sound could not be loaded: " + errorEvent.text);			}		}	}}