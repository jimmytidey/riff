﻿package   {  	import flash.display.Sprite;  	import flash.events.MouseEvent;  	import flash.net.URLLoader;  	import flash.net.URLRequest;  	import flash.events.Event;  	import flash.utils.ByteArray;  	import flash.media.Sound; 	import flash.media.SoundChannel;	import flash.media.SoundTransform;	import org.as3wavsound.WavSound;  	import org.as3wavsound.WavSoundChannel;	import org.as3wavsound.WavSoundPlayer;	import flash.media.SoundLoaderContext;	import flash.display.*; 	import flash.media.SoundMixer;	import flash.text.TextField;	import flash.text.TextFieldAutoSize;	import flash.events.ProgressEvent;	import flash.events.IOErrorEvent;		      public final class PlaySound extends MovieClip       {  	 	var tts:WavSound;	 	var soundUrl:String;		var soundType:String;		var repeats:String;		var repeatNumber:int;		var Mp3:Sound; 		var statusTextField:TextField  = new TextField();	 	var Mp3Channel:SoundChannel = new SoundChannel();		var WavChannel:WavSoundChannel; 		var nowPlaying:String = 'no';		var volumeLevel:Number; 		var playerTransform:SoundTransform;		var statusMC:MovieClip;		var cumulative_y:int = 0;		var totalRemainingLoad:int = 0;		var waveData:ByteArray; 				var totalBytes:Number;		var loadedBytes:Number;		        public function PlaySound(soundUrl:String, repeats:String, volumeLevel:Number, statusMC, totalUploadPercent):void {  						//set variables of this object when it's initiated 			this.volumeLevel = volumeLevel; 					 	this.soundUrl = soundUrl;			this.statusMC = statusMC;			this.repeats = repeats;			 			//decide if this is a wav or an mp3		 	var typeArray:Array; 				typeArray = this.soundUrl.split('.'); 			var arrayLastPosition:int = typeArray.length -1;						//play a wav			if (typeArray[arrayLastPosition] == 'wav') {				soundType='wav';				//loadWav(loadWav);  			}						//play an mp3, reject any undefined paths (jimmy hack, shoul) 			if (typeArray[arrayLastPosition] == 'mp3' || typeArray[arrayLastPosition] == 'MP3' ) {				soundType='mp3';				loadMP3(totalUploadPercent)			}						//set the amount of repeating necessary 			if (repeats == 'yes') {repeatNumber=1000;}			else {repeatNumber = 1;}						//make a soundTransform for setting the volume level 			playerTransform = new SoundTransform((volumeLevel/100));		}	            		public function loadMP3(totalUploadPercent) {						try { 				Mp3 = new Sound();			} catch(err:Error) {				trace(err.message);			}			Mp3.load(new URLRequest(soundUrl));			statusTextField.autoSize = TextFieldAutoSize.LEFT;			Mp3.addEventListener(ProgressEvent.PROGRESS, progressHandler);			Mp3.addEventListener(ProgressEvent.PROGRESS, totalUploadPercent);			Mp3.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);			this.statusMC.addChild(statusTextField);					}			private function errorHandler(errorEvent:IOErrorEvent):void {			trace("The sound could not be loaded: " + errorEvent.text);		}			public function loadWav(totalUploadPercent) {			/*			if (soundUrl != undefined) { 				var urlRequest:URLRequest = new URLRequest(soundUrl); 				var wav:URLLoader = new URLLoader();  				wav.dataFormat = 'binary';  				wav.load(urlRequest);				//wav.addEventListener(ProgressEvent.PROGRESS, progressHandler);				//wav.addEventListener(ProgressEvent.PROGRESS, totalUploadPercent);				this.statusMC.addChild(statusTextField);							wav.addEventListener(Event.COMPLETE, makeWav);  			}			*/		}				public function progressHandler(event:ProgressEvent) {						totalBytes = event.bytesTotal;			loadedBytes = event.bytesLoaded;									loadTime = event.bytesLoaded / event.bytesTotal;			LoadPercent = Math.round(100 * loadTime)			if (LoadPercent > 100) { 				LoadPercent = 100;			}			//statusTextField.text =  LoadPercent + ' %';		}		   		public function makeWav(e:Event) {  			waveData = e.target.data as ByteArray;			trace("wav made!"); 		}		 		public function playBack() {						if (soundType == 'wav') {				//Wav = new WavSound(waveData); 				//WavChannel = Wav.play(0,this.repeatNumber,playerTransform); 			}						if (soundType == 'mp3') {				Mp3Channel = Mp3.play(0, this.repeatNumber);				Mp3Channel.soundTransform = playerTransform;			}			nowPlaying = 'true';		}		 		public function stopPlayBack() {					if (soundType == 'wav') {				if (nowPlaying == 'true') {WavChannel.stop();} 			}						else {				if (nowPlaying == 'true') {Mp3Channel.stop();} 			}			nowPlaying = 'false';		}						public function stopAllPlayBack() {					if (soundType == 'wav') {				WavChannel.stop(); 			}						else {				Mp3Channel.stop();			}			nowPlaying = 'false';		}					}  }  