﻿package {	public class ModifyStructure {					public function make(jsonData, _stage, grid_top, grid_left) {						var bank_index= 0;			cumulatuive_y_offset = grid_top + 30;			var bankOptionButton:ModifyStructureButton = new ModifyStructureButton(); 						for each (var bank:Object in jsonData['banks']) {				var bank_option_index= 0;				for each (var bank_option:Object in bank['bank_options']) {										// add bank option button 					if (bank_option_index == bank['bank_options'].length-1) {						bankOptionButton.makeBankOptionButton(_stage, cumulatuive_y_offset, jsonData, bank_index, bank_option_index); 					}										//bank name and delete buttons					if (bank_option_index == 0) {						bankOptionButton.makeBankName(_stage, cumulatuive_y_offset - 30, jsonData, bank_index, bank_option_index);						bankOptionButton.makeBankDelete(_stage, cumulatuive_y_offset - 30, jsonData, bank_index, bank_option_index);					}												//add bank button					if (bank_index ==  jsonData['banks'].length-1 && bank_option_index == bank['bank_options'].length-1) {						bankOptionButton.makeBankButton(_stage, cumulatuive_y_offset +30, jsonData, bank_index, bank_option_index);					}															bank_option_index ++;					cumulatuive_y_offset += 26;				}				bank_index ++; 				cumulatuive_y_offset += 56;			}					}	}}