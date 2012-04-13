﻿package   {       import flash.display.Sprite;       import flash.events.MouseEvent;       import flash.net.URLLoader;       import flash.net.URLRequest;       import flash.events.Event;       import flash.utils.ByteArray;       import flash.media.Sound;       import org.as3wavsound.WavSound;       import org.as3wavsound.WavSoundChannel;          public final class PlayWav extends Sprite       {  	 	var wavUrl:String;		public var repeats:String;		public var repeatNumber:int;		public var tts:WavSound;		         public final function PlayWav(wavUrl:String, repeats:String):void           {              this.repeats = repeats;			loadWav(wavUrl);           }           private final function loadWav(wavUrl:String):void           {               var urlRequest:URLRequest = new URLRequest(wavUrl);               var wav:URLLoader = new URLLoader();               wav.dataFormat = 'binary';               wav.load(urlRequest);               wav.addEventListener(Event.COMPLETE, playWav);           }              private final function playWav(e:Event):void           {               tts = new WavSound(e.target.data as ByteArray);  			 trace(tts);			 if (repeats == 'yes') {repeatNumber=1000;}			 else {repeatNumber = 1;}          }  		 		 public function playBack() {		 	trace ('repeats '+this.repeatNumber);			tts.play(0, this.repeatNumber); 		 }	 }   }  