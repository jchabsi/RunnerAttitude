using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;

class Battery extends WatchUi.Drawable {

	private static var batteryPercentage;
	hidden var normalFont;

    function initialize() {
        var dictionary = {
            :identifier => "Battery"
        };

        Drawable.initialize(dictionary);
        normalFont = WatchUi.loadResource(Rez.Fonts.NormalFont);
    }

    function draw(dc) {
    
        var width = dc.getWidth();
        var height = dc.getHeight();    
        
        //var batX = [1.15, 1.15, 1.17, 1.19, 1.22];
        var batX = [1.16, 1.17, 1.17, 1.19, 1.19];
        //var batY = [2.35, 2.35 , 2.35, 2.35, 2.29];
        var batY = [2.3, 2.35 , 2.4, 2.4, 2.4];
        //var batXw = [1.03, 1.03, 1.05, 1.07, 1.11];
        var batXw = [1.007, 1.015, 1.02, 1.03, 1.03];
        //var batYh = [2.05, 2.05, 2.05, 2.05, 2.05];
        var batYh = [1.94, 2, 2.03, 2.03, 2];
        
        var x = (width / calcXY(batX, width)).toLong();
        var y = (height / calcXY(batY, height)).toLong();
        
        var xw = ((width / calcXY(batXw, width)) - x).toLong();
        var yh = ((height / calcXY(batYh, height)) - y).toLong();
        
        var batPercY = [y - 5, y - 5, y - 4, y - 3, y - 6];
        var batPercX = [x + 2, x + 2, x + 3, x + 4, x + 5];
        
        //System.println(y);
    	
    	var batteryLevel = System.getSystemStats().battery.toNumber();
    	
    	//var isCharging =  System.getSystemStats().charging;
    	var levelBar = (batteryLevel * (xw - 4) / 100).toNumber();
    	
    	var color = gTheme.batteryOk;
    	if (batteryLevel <= 25) {
    		color = gTheme.batteryLow;
    	}
    	if (batteryLevel <= 10) {
    		color = gTheme.batteryCritical;
    	}    	
    	
    	dc.setColor(color, Graphics.COLOR_TRANSPARENT);
    	dc.drawRoundedRectangle(x, y, xw, yh, 2);
    	dc.drawRectangle(x + 1, y + 1 , xw - 2 , yh - 2);
    	dc.fillRoundedRectangle(x + xw - 2, y + yh/4, 5, yh/2 + 1, 2);
    	dc.fillRectangle(x + 2, y + 2 , levelBar , yh - 4);
    	
    	if (Battery.batteryPercentage) {
	    	dc.setColor(gTheme.batteryText, Graphics.COLOR_TRANSPARENT);
	    	dc.drawText(
				calcXY(batPercX, width),
				calcXY(batPercY, height),
				normalFont,
				batteryLevel + "%",
				Graphics.TEXT_JUSTIFY_LEFT);
		}
    	
    	dc.clear();
    	
    }
    
    function calcXY(screenRes, coord)
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
    
    static function getBatteryPercentage() {
    	Battery.batteryPercentage = Application.getApp().getProperty("BatteryPercentage");
    }    

}