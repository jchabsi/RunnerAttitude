using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;

class MyTextView extends WatchUi.Drawable {

    hidden var myTextView;
    hidden var myText;
    hidden var myColor;
    hidden var myFont;
    hidden var myX;
    hidden var myY;
    hidden var myJust;
    
    function setColor(color) {
    	myColor = color;
    }
    
    function initialize(text, color, font, x, y, just) {
        myText = text;
        myColor = color;
        myFont = font;
        myX = x;
        myY = y;    
        myJust = just;
        
        var dictionary = {
            :identifier => "MyTextView"
        };
       
        Drawable.initialize(dictionary);    
    }
    
    function draw(dc) {
        dc.setColor(myColor, Graphics.COLOR_TRANSPARENT);
        
    	dc.drawText(
	        myX,
	        myY,
	        myFont,
	        myText,          
	        myJust
        );        
    }
    
    function setText(text) {
    	myText = text;
    }
}