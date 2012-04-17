﻿package {	import flash.net.URLRequest;	import flash.net.URLLoader;	import flash.events.*;	import flash.utils.*;	import flash.display.*; 	import flash.utils.describeType;	import flash.text.TextField;	import flash.text.TextFormat;	import flash.text.Font;	import flash.text.AntiAliasType;	import com.adobe.serialization.json.JSON;	import flash.media.Sound;	import flash.events.*;	import fl.controls.Button;	import fl.controls.TextInput; 	import fl.controls.Slider;	import fl.controls.CheckBox;	import fl.events.SliderEvent;		public class ControlElements extends MovieClip {		function makeVolume(_stage, y, jsonData, bank_index, bank_option_index) { 			var volume:Slider = new Slider(); 			volume.x = 150			volume.width = 60;			volume.value = jsonData['banks'][bank_index]['bank_options'][bank_option_index]['volume'];			volume.y = y-17;			volume.addEventListener(SliderEvent.CHANGE, changeVolume);									function changeVolume(event:SliderEvent) {				jsonData['banks'][bank_index]['bank_options'][bank_option_index]['volume']= event.value;			}						_stage.addChild(volume);		}				function makeLoop(_stage, y, jsonData, bank_index, bank_option_index) { 			var loop:CheckBox = new CheckBox(); 			loop.x = 220;			loop.selected = jsonData['banks'][bank_index]['bank_options'][bank_option_index]['loop'];			loop.y = y-27;			loop.label = "";			loop.addEventListener(Event.CHANGE, changeLoop);									function changeLoop(event) {				jsonData['banks'][bank_index]['bank_options'][bank_option_index]['loop']= event.target.selected;			}						_stage.addChild(loop);		}				function makeOverPlay(_stage, y, jsonData, bank_index, bank_option_index) { 			var overPlay:CheckBox = new CheckBox(); 			overPlay.x = 235;			overPlay.selected = jsonData['banks'][bank_index]['bank_options'][bank_option_index]['overplay'];			overPlay.y = y-27;			overPlay.label = "";			overPlay.addEventListener(Event.CHANGE, changeOverPlay);									function changeOverPlay(event) {				jsonData['banks'][bank_index]['bank_options'][bank_option_index]['overplay']= event.target.selected;			}						_stage.addChild(overPlay);		}							}}