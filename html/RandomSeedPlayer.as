﻿package {	import com.adobe.serialization.json.JSON;	import flash.net.URLRequest;	import flash.net.URLLoader;	import flash.events.*;	import flash.display.*; 	import flash.text.*; 	import com.joshtime.jButton;	import flash.media.SoundMixer;			//this object as a container for everything. Has to extend movieclip to inherit the stage obejct	public class RandomSeedPlayer extends MovieClip {				var _stage:Stage; // have to define this to pass the stage object around, how fucking stupid is that?				//holding all the date from reading the json		var jsonData:Object; //holds all the json data		var sounds:Array; // array for sound objects for each bank option		var grid:Array; //holds the probabiliyies of each step playing 				//variables from controlling the state of this class		var step_time:Number; //indicates which step the timer is currently on		var step_number:Number;		var reload_sounds:int = 0; ////use this to check if we need to recreate all the sound objects				//control objects 		var calculateGrid:CalculateGrid = new CalculateGrid();		var selectSteps:SelectSteps = new SelectSteps();		var render:Render = new Render();		var soundObjects:SoundObjects = new SoundObjects();					//other useful objects 		var myTimer:AccurateTimer;				var loader:URLLoader = new URLLoader();		var requester:URLRequest = new URLRequest();						var stopPlayContainer:MovieClip = new MovieClip;		public function RandomSeedPlayer(stage:Stage):void {			_stage = stage; 		}  				public function init() {			//clear the stage 			while (_stage.numChildren > 0) {_stage.removeChildAt(_stage.numChildren-1);} 						_stage.addChild(stopPlayContainer); 			//draw buttons 			drawButtons();			loadJSON();		}		public function loadJSON() {			var project_info_location:String = root.loaderInfo.parameters.project_info_location;						//default to make debug easier			if (project_info_location == null) {project_info_location  = 'http://chance-acorn.jimmytidey.co.uk/list.php?project_name=wav';}						requester.url=project_info_location;			loader.load(requester);			loader.addEventListener(Event.COMPLETE, decodeJSON);					}				//Make the grid object with all of the relative play probabilties in		public function decodeJSON(event:Event) {			this.jsonData =JSON.decode(loader.data);						//only reload the sound objects if necessary			if (this.reload_sounds == 0) {						sounds = soundObjects.make(this.jsonData, _stage);				reload_sounds = 1; 				}						//draw the grid and shade in the various probabilities 			this.grid = calculateGrid.buildGrid(this.jsonData, _stage);						//colour in the steps which will actually play 			selectSteps.renderPlayingSteps(jsonData, grid, _stage);								//Draw the playhead 			render.drawPlayhead(jsonData, _stage);									calculateStepTime();		}						public function drawButtons() {								//play btn 			var playBtn = new jButton("Play");			playBtn.x = 130; 			playBtn.y = 10;			stopPlayContainer.addChild(playBtn);			playBtn.addEventListener("c", playListener);			function playListener() {				while (stopPlayContainer.numChildren > 0) {stopPlayContainer.removeChildAt(stopPlayContainer.numChildren-1);}								stopPlayContainer.addChild(stopBtn);				go();			}						//stop btn 			var stopBtn = new jButton("Stop");			stopBtn.x = 130; 			stopBtn.y = 10;			stopBtn.addEventListener("c", stopListener);			function stopListener() {				while (stopPlayContainer.numChildren > 0) {stopPlayContainer.removeChildAt(stopPlayContainer.numChildren-1);}								stopPlayContainer.addChild(playBtn);				my_stop();			}						//randomise			var randomiseBtn = new jButton("Randomise");			randomiseBtn.x = 250; 			randomiseBtn.y = 10;			_stage.addChild(randomiseBtn);			randomiseBtn.addEventListener("c", randomise);								function randomise() {loadJSON();}								//rewind			var rewindBtn = new jButton("rewind");			rewindBtn.x = 360; 			rewindBtn.y = 10;			_stage.addChild(rewindBtn);			rewindBtn.addEventListener("c", rewind);						function rewind() {				calculateStepTime()				this.step_time = 0; 				render.movePlayhead(0);			}		}				private function calculateStepTime() {			var beats_per_second:Number = jsonData['project_info']['bpm']/60;			var seconds_per_beat:Number = 1/beats_per_second; 			step_time = (seconds_per_beat * jsonData['project_info']['bpl'])*1000; 			myTimer = new AccurateTimer(step_time, 1000);		}		public function go() {			my_stop(); // stop it from playing two things at once			myTimer.addEventListener(TimerEvent.TIMER, step);			myTimer.start(); 			playStep();						function step(event:TimerEvent) {					playStep();			}					}				public function my_stop() {			trace('stop called');						myTimer.stop(); 						var count:int = 1; 			for (var index in sounds) {				for (var second_index in sounds[index]) {					sounds[index][second_index].stopAllPlayBack();					trace ('stopping '+ count); 					count++;				}			}						SoundMixer.stopAll();		}								public function playStep() {			if (this.step_number == jsonData['project_info']['steps']-1) { //stop playback if we've got to the end of the track				 my_stop()			}						else {				this.step_number = (myTimer.currentCount) % jsonData['project_info']['steps'];								render.movePlayhead(this.step_number * 20);								//stop all sounds which have to stop before the next step ie. ones which don't have overplay set				for (var bank_index:int =0; bank_index < jsonData['banks'].length; bank_index++) {										for (var bank_option_index:int =0; bank_option_index < jsonData['banks'][bank_index]['bank_options'].length; bank_option_index++) {											//stop playback of everything which isn't playing and where overplay is false 						if (jsonData['banks'][bank_index]['bank_options'][bank_option_index]['overplay'] == "false") {							sounds[bank_index][bank_option_index].stopPlayBack();						}												if (grid[bank_index][step_number][bank_option_index] == 100) { 							sounds[bank_index][bank_option_index].playBack();						}					}				}			}		}	}}