﻿package {	import flash.net.URLRequest;	import flash.net.URLLoader;	import flash.events.*;	import flash.utils.*;	import flash.display.*; 		public class SelectSteps extends MovieClip {			var options_container:MovieClip = new MovieClip;			public function renderPlayingSteps(jsonData, grid, _stage) {						if (jsonData['banks'][bank_index]['bank_options'][0]['sequence']) { 				var number_of_steps:int = jsonData['banks'][bank_index]['bank_options'][0]['sequence'].length;			}							var cumulatuive_y_offset:int;						while (this.options_container.numChildren > 0) {				this.options_container.removeChildAt(this.options_container.numChildren-1);			} 						//go through steps 			for (var step_number:int=0; step_number < number_of_steps; step_number++) {								cumulatuive_y_offset = 70;								//loop through banks 				for (var bank_index:int=0; bank_index < jsonData['banks'].length; bank_index++) {															var max_value:int =0 					var max_value_index:int = 0					var current_step_value = 0; 										//loop throuh bank options 					for (bank_option_index=0; bank_option_index < jsonData['banks'][bank_index]['bank_options'].length; bank_option_index++) {												current_step_value = grid[bank_index][step_number][bank_option_index];												//work out which of the bank options should play						if (current_step_value > max_value) {							max_value = current_step_value;							max_value_index = bank_option_index; 						} 					}										if (max_value > 20) {												grid[bank_index][step_number][max_value_index] = 100;												//for each bank, indicate which						var mc:MovieClip = new MovieClip();												//draw a grey box for this step  						mc.graphics.beginFill(0x8F1433, 1);						mc.graphics.drawRect(0, 0, 12, 2);						mc.graphics.endFill();						mc.x = step_number * 17 + 267;						mc.y = cumulatuive_y_offset + (max_value_index * 26);						options_container.addChild(mc);									}										else {						grid[bank_index][step_number][max_value_index] = 0;					}										cumulatuive_y_offset += (26 * grid[bank_index][step_number].length) + 56; 				}	 			}			_stage.addChild(options_container);		}	}}