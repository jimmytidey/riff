﻿package {	import flash.events.*;	import flash.utils.*;	import flash.display.*; 	import flash.text.*; 		public class CalculateGrid extends MovieClip {				var grid_container:MovieClip = new MovieClip;		var cumulatuive_y_offset:int = 0;		public var grid:Array = new Array();			public function buildGrid(jsonData, _stage) {						grid = new Array(jsonData['banks'].length);// an array for keeping the bank option states			var bank_index:int = 0;			var bank_option_index:int = 0;								//while (this.grid_container.numChildren > 0) {this.grid_container.removeChildAt(this.grid_container.numChildren-1);} 								for each (var bank:Object in jsonData['banks']) {									//declare a new array for this bank (assuming all have the same number of steps) 				if(jsonData['banks'][bank_index]['bank_options'][0]['sequence']) { 					grid[bank_index] = new Array(jsonData['banks'][bank_index]['bank_options'][0]['sequence'].length);				}								//loop over each bank option 				bank_option_index = 0;														for each (var bank_option:Object in bank['bank_options']) {										var step_index:int = 0;													for each (var step:Object in jsonData['banks'][bank_index]['bank_options'][bank_option_index]['sequence']) {												//if we are on the first bank option we need to define the step array, otherwise not because doing this will erase info from previous step 						//of course, this wouldn't be a fucking problem if we didn't have to define the array 						if (bank_option_index == 0) {							grid[bank_index][step_index] = new Array(jsonData['banks'][bank_index]['bank_options'].length);						}												var temp_val:int = jsonData['banks'][bank_index]['bank_options'][bank_option_index]['sequence'][step_index];												//process a step which is very likely, but not certain 						if (temp_val > 0 && temp_val < 3) {														temp_val = temp_val * 25 * Math.random();  						}												if (temp_val == 3) {							temp_val = temp_val * 30 * ((Math.random()/3) + 0.6);  						}																	grid[bank_index][step_index][bank_option_index] = temp_val; 						var mc:MovieClip = new MovieClip();												var fill = jsonData['banks'][bank_index]['bank_options'][bank_option_index]['sequence'][step_index]; 						fill = (fill/4) + 0.1;												mc.graphics.beginFill(0x000000);						mc.graphics.drawRect(0, 0, 12, 12);						mc.graphics.endFill();						mc.alpha = fill;						mc.x = ((step_index+ 1) * 17) + 250;						mc.y =cumulatuive_y_offset;												function changeState(_event:MouseEvent, parameters):void  						{														jsonData = parameters['jsonData'] ;							bank_index = parameters['bank_index'] ;							bank_option_index = parameters['bank_option_index'] ;							step_index = parameters['step_index'] ;							if (_event.target.alpha <= 0.1) { 								_event.target.alpha = 0.3;								jsonData['banks'][bank_index]['bank_options'][bank_option_index]['sequence'][step_index]="1"; 							}														else if (_event.target.alpha <= 0.3) { 								_event.target.alpha = 0.7;								jsonData['banks'][bank_index]['bank_options'][bank_option_index]['sequence'][step_index]="2";							}														else if (_event.target.alpha < 0.7) { 								_event.target.alpha = 1;								jsonData['banks'][bank_index]['bank_options'][bank_option_index]['sequence'][step_index]="3";							}														else if (_event.target.alpha ==1){								_event.target.alpha = 0.1;								jsonData['banks'][bank_index]['bank_options'][bank_option_index]['sequence'][step_index]="0";							}															}												function addArguments(method:Function, additionalArguments:Array):Function {							return function(event:Event):void {method.apply(null, [event].concat(additionalArguments));}						}												var parameters:Array = new Array();						parameters['jsonData'] = jsonData;						parameters['bank_index'] = bank_index;						parameters['bank_option_index'] = bank_option_index;						parameters['step_index'] = step_index;						mc.addEventListener(MouseEvent.CLICK, addArguments(changeState, [parameters] ));						grid_container.addChild(mc);						step_index++;					}										cumulatuive_y_offset += 26;					bank_option_index++;				}								bank_index++;								cumulatuive_y_offset += 56;			}						grid_container.y = 70;				_stage.addChild(grid_container);									dispatchEvent(new Event("done", true)); 			return cumulatuive_y_offset;			}									 	}}