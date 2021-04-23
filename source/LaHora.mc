using Toybox.WatchUi;
using Toybox.System;
using Toybox.Application;
using Toybox.Graphics;

class LaHora extends WatchUi.Drawable {

	hidden var hoursFont;
	hidden var minutesFont;
	hidden var secondsFont;
	
	hidden var secX;
	hidden var secY;
	static var showSeconds;
	
	hidden var width;
	hidden var height;
	
	hidden var secondsX = [1.15, 1.15, 1.17, 1.19, 1.21];
    hidden var secondsY = [2.11, 2.12, 2.1, 2.1, 2.06];
    hidden var storedSecs;


    function initialize(params) {

        Drawable.initialize(params);
        
        hoursFont = WatchUi.loadResource(Rez.Fonts.HoursFont);
		minutesFont = WatchUi.loadResource(Rez.Fonts.MinutesFont);
		secondsFont = WatchUi.loadResource(Rez.Fonts.SecondsFont);		
      
    }
    
    
    function draw(dc) {
        width = dc.getWidth();
        height = dc.getHeight();        
            	 
		drawTime(dc);
		drawSeconds(dc, false);
	}
	
    private function drawTime(dc) {
    	var clockTime = System.getClockTime();
		var halfDCWidth = width / 2;

		var sHour = clockTime.hour.format("%02d");
		var sMin = clockTime.min.format("%02d");
		storedSecs = clockTime.sec.format("%02d");
		var totalWidth = dc.getTextWidthInPixels(sHour + sMin, hoursFont);
		var x = halfDCWidth - (totalWidth / 2);	
			
    	//Hour
        dc.setColor(gTheme.time, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
			x,
			height / 2.45,
			hoursFont,
			sHour,
			Graphics.TEXT_JUSTIFY_LEFT);
        
        x += dc.getTextWidthInPixels(sHour, hoursFont);        
        
        //Mins        
        dc.setColor(gTheme.mins, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
			x,
			height / 2.45,
			minutesFont,
			sMin,
			Graphics.TEXT_JUSTIFY_LEFT);
        
    }
    
    function drawSeconds(dc, isPartial) {
    	if (!showSeconds) {
    		return;
    	}
    	secX = width / calcXY(secondsX, width);
    	secY = height / calcXY(secondsY, height);
		var seconds;
    	
    	if (isPartial) {
    		var clockTime = System.getClockTime();
			seconds = clockTime.sec.format("%02d");
    		var dims = dc.getTextDimensions(seconds, secondsFont); 
	    	dc.setClip(
				secX,
				secY + 5,
				dims[0],
				dims[1] - 5
			);
			
			dc.setColor(gTheme.seconds, gTheme.background);	
			dc.clear();
		}
		else {
			dc.setColor(gTheme.seconds, Graphics.COLOR_TRANSPARENT);
			seconds = storedSecs;
						
		}
		if(Application.getApp().isSleeping() && !RunnerAttitudeView.partialUpdateSupport) {
			seconds = "";
        }
                
		dc.drawText(
			secX,
			secY,
			secondsFont,
			seconds,
			Graphics.TEXT_JUSTIFY_LEFT
		);
	}
    
    private function calcXY(screenRes, coord)
    {
    	//System.println(coord);
    	if(coord <= 218)
    	{
    		return screenRes[0];
    	}
    	else if(coord <= 240)
    	{
    		return screenRes[1];
    	}
    	else if(coord <= 260)
    	{
    		return screenRes[2];
    	}
    	else if(coord <= 280)
    	{
    		return screenRes[3];
    	}
    	else if(coord <= 390)
    	{
    		return screenRes[4];
    	}
    	return screenRes[4]; 	
    }
    
    static function setSecondsConfig() {
    	LaHora.showSeconds = Application.getApp().getProperty("ShowSeconds");
    }
}
