﻿package  com.joshtime {	import flash.display.Sprite;	import flash.text.TextField;	import flash.text.TextFormat;	import flash.events.MouseEvent;	import flash.filters.DropShadowFilter;	import flash.events.EventDispatcher;	import flash.events.Event;	/**	 * The jButton class is a button class that features effects when the mouse interacts with it. 	 * When the mouse is hovered over the button, the alpha changes from 0.8 to 1.0. When the mouse hovers off, the alpha changes back to 0.8. 	 * Also, when the mouse button is held down on the button, the button moves down 2 pixels and moves back up when the mouse button is released. 	 * Lastly, this code is released into the public domain meaning that anyone can use, modify, sell, or do anything with this code freely.	 * 	 * jButton dispatches an event on clicking it. Using MouseEvent.CLICK still works but using the custom	 * event from this is more accurate as using MouseEvent.CLICK can trigger after the mouse has clicked	 * on the button, left, then came back in while jButton recognizes that and does not dispatch an event.	 * 	 * Usage:	 * 	 * var button:jButton = new jButton("label", ... optional parameters); // Creates the button	 * addChild(button); // Adds the button to the stage	 * button.addEventListener("c", functionName); // When the button is clicked, run functionName (or change it to whatever function is desired)	 * 	 * Revision list:	 * 1 (July 9 2010): original file	 * 2 (Sept 11 2010): added custom event listener and ability to change height and fixed a bug	 * 3 (Sept 12 2010): Fixed textFormatAlign bug and a black dot sitting on the top right corner	 * 	 * Thank you for using jButton	 * 	 * http://joshtime.com/actionscript-3/jbutton	 * @author JoshTime	 * @version September 11 2010 (2nd revision)	 */	public class jButton extends Sprite	{				public var text:TextField;		public var customFormat:Boolean = false;		private var downamt:int = 2; // The amount of how much the button shifts down or up		private var down:Boolean = false; // This variable tells us whether we shifted downamt pixels down or not		public static var format:TextFormat = new TextFormat("Arial", 24, 0x333333);		format.align = "center";						// Three filters to make the button look nice		public var menuButtonPretty:DropShadowFilter = new DropShadowFilter(0, 0, 0xffffff, 0.8, 2, 2, 1, 1, true);		public var menuButtonShadowHover:DropShadowFilter = new DropShadowFilter(0, 0, 0, 1, 8, 8);		public var menuButtonShadow:DropShadowFilter = new DropShadowFilter(0, 0, 0, 1, 14, 14);						// Expects an arguement label which is the label for the button in the TextField. The other arguements are optional		// label: The text of the button		// color: The color of the button		// width: The width of the button		// height: The height of the button		// textY: The Y location of the text. Should be adjusted as height is adjusted since it is hard to vertically center text perfectly		// fontSize: The font size of the text		// font: The font of the text		// fontColor: The color of the text		public function jButton(label:String, color:int = 0xeeeeee, width:int = 100, height:int = 20, textY:int = 2, fontSize:Number = 12, font:String = "Arial", fontColor:int = 0x333333):void {			// Check if we have a custom text format			if (font != "Arial" || fontSize != 24 || fontColor != 0x333333) {				// set customFormat to true				customFormat = true;			}						graphics.beginFill(color);			alpha = 0.8;			graphics.drawRoundRect(0, 0, width, height, 15);			mouseChildren = false;			filters = new Array(menuButtonShadow, menuButtonPretty);						text = new TextField();						text.width = width;			text.autoSize = "center";			text.selectable = false;			text.y = textY;												if (customFormat) { // We have a custom textformat				// Set the defaultTextFormat to something new				var newTextFormat:TextFormat = new TextFormat(font, fontSize, fontColor); // This is the new textFormat that will be used				newTextFormat.align = "center";								// Set the default text format as the new TextFormat we just created				text.defaultTextFormat = newTextFormat;			} else {				text.defaultTextFormat = format;			}						// Add the label to the TextField AFTER the defaultTextFormat has been set so that we will not need to use setTextFormat() again			text.text = label;						addChild(text);						// Add button effect listeners			addEventListener(MouseEvent.MOUSE_DOWN, buttonOnClick);			addEventListener(MouseEvent.MOUSE_UP, buttonOutClick);			addEventListener(MouseEvent.ROLL_OVER, buttonOnHover);			addEventListener(MouseEvent.ROLL_OUT, buttonOutHover);		}								public function setLabel(label:String):void { // A function used to changed the label of the button			text.text = label;		}				// These functions are set to public just in case instead of using Flash's built in mouse events, 		// someone decides to use X and Y coordinates or some other method of selecting and clicking the button				public function buttonOnHover(e:MouseEvent = null):void {			e.target.alpha = 1;		}		public function buttonOutHover(e:MouseEvent = null):void {			e.target.alpha = 0.8;		}				public function buttonOnClick(e:MouseEvent):void {			filters = [menuButtonShadowHover, menuButtonPretty];						// Add another listener so that if the user clicked and moved out			addEventListener(MouseEvent.ROLL_OUT, buttonOutRoll);			addEventListener(MouseEvent.MOUSE_UP, buttonOutClick);						if (!down) {				y += 2;				down = true;			}		}				// Identical to buttonOutClick but the usage is to move the button back up 2 pixels		public function buttonOutRoll(e:MouseEvent):void {			filters = [menuButtonShadow, menuButtonPretty];			if (down) {				y -= 2;				down = false;			}			removeEventListener(MouseEvent.ROLL_OUT, buttonOutRoll);			removeEventListener(MouseEvent.MOUSE_UP, buttonOutClick);		}				public function buttonOutClick(e:MouseEvent):void {			filters = [menuButtonShadow, menuButtonPretty];			if (down) {				y -= 2;				down = false;			}						// An event is dispatched called c which stands for clicked			dispatchEvent(new Event("c"));			removeEventListener(MouseEvent.ROLL_OUT, buttonOutRoll);			removeEventListener(MouseEvent.MOUSE_UP, buttonOutClick);		}			}}