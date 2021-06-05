using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Application;
using Toybox.Math;

using Toybox.Time.Gregorian as Date;
using Toybox.ActivityMonitor as Mon;
using Toybox.Activity;

class RunnerAttitudeView extends WatchUi.WatchFace {
	
	hidden var height;
	hidden var width;
	hidden var motivationalDisplay;
	hidden var iconsFont;
	
	hidden var tinyFont;
	
	hidden var iconSteps;
	hidden var iconCalories;
	hidden var iconBT;
	hidden var iconNotif;
	hidden var iconHeart;
	hidden var iconFloorsClimbed;
	
	private var mTime;
	
	private var phraseOnSleepMode;
	
	
	static const partialUpdateSupport = WatchUi.WatchFace has :onPartialUpdate;
	hidden var altitudeMode;
	

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    	iconsFont = WatchUi.loadResource(Rez.Fonts.IconsFont);
		tinyFont = WatchUi.loadResource(Rez.Fonts.TinyFont);

        setLayout(Rez.Layouts.WatchFace(dc));
        
        width = dc.getWidth();
        height = dc.getHeight();
        mTime = View.findDrawableById("Time");
        
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    	    	
    	//Date
    	var dateDisplay = View.findDrawableById("DateDisplay");
    	if (height > 180) {
    		dateDisplay.locY = height / 3.7;
    	}
    	else if (height <= 148) {
    		dateDisplay.locY = height / 1.16; 
    		dateDisplay.setFont(Graphics.FONT_TINY);   		
    	}
    	else {
    		dateDisplay.locY = height / 1.14;
    		dateDisplay.setFont(Graphics.FONT_TINY);
    	} 		
    	
    	
    	//Steps
    	var stepCountDisplay = View.findDrawableById("StepCountDisplay"); 
    	//stepCountDisplay.locX = width / 3.2;
    	//stepCountDisplay.locY = height / 1.3;
    	stepCountDisplay.locX = width / 3.2;
    	stepCountDisplay.locY = height / 5.5;
    	//iconSteps = new MyTextView("0", gTheme.iconSteps, iconsFont, width / 4.8, height / 1.3, Graphics.TEXT_JUSTIFY_LEFT );
    	iconSteps = new MyTextView("0", gTheme.iconSteps, iconsFont, width / 4.8, height / 5.4, Graphics.TEXT_JUSTIFY_LEFT );  
    	
    	//floors
    	var floorsClimbedDisplay = View.findDrawableById("FloorsClimbedDisplay"); 
    	floorsClimbedDisplay.locX = width / 3.1;
    	floorsClimbedDisplay.locY = height / 1.3;
    	iconFloorsClimbed = new MyTextView(";", gTheme.iconCalories, iconsFont, width / 4.8, height / 1.3, Graphics.TEXT_JUSTIFY_LEFT );  
    	    	
    	//Calories
    	var caloriesDisplay = View.findDrawableById("CaloriesDisplay"); 	
    	caloriesDisplay.locX = width / 1.5;
    	caloriesDisplay.locY = height / 1.3; 
    	iconCalories = new MyTextView("6", gTheme.iconfloorsClimbed, iconsFont, width / 1.75, height / 1.3, Graphics.TEXT_JUSTIFY_LEFT );
    	
    	//Notifications
    	var notificationDisplay = View.findDrawableById("NotificationDisplay"); 	
    	//notificationDisplay.locX = width / 2.45;
    	notificationDisplay.locX = width / 1.35;
    	notificationDisplay.locY = height / 5.5;
    	//iconNotif = new MyTextView("5", gTheme.iconNotif, iconsFont, width / 3.7, height / 5.4, Graphics.TEXT_JUSTIFY_LEFT );
    	iconNotif = new MyTextView("5", gTheme.iconNotif, iconsFont, width / 1.6, height / 5.4, Graphics.TEXT_JUSTIFY_LEFT );
    	
    	//Heart rate    	
    	var heartrateDisplay = View.findDrawableById("HeartrateDisplay"); 
    	var heartX = [30, 20, 15, 11, 8];	
    	var hrX = [12, 10.4, 9.1, 7.5, 6.5];
    	var heartY = [2.4, 2.35, 2.3, 2.35, 2.25];
    	var hrY = [2, 1.95, 1.9, 1.95, 1.95]; 
 
    	heartrateDisplay.locX = width / calcXY(hrX, width);
    	heartrateDisplay.locY = height / calcXY(hrY, height);
    	
    	iconHeart = new MyTextView("3", gTheme.iconHeart, iconsFont, width / calcXY(heartX, width), height / calcXY(heartY, height), Graphics.TEXT_JUSTIFY_LEFT);
    	
    	//Blue thooth
    	//iconBT = new MyTextView("8", setBTIconColor(), iconsFont, width / 1.6, height / 5.55, Graphics.TEXT_JUSTIFY_LEFT );
    	var bty = 0;
    	if (height > 180) {
    		bty = height / 3.7;
    	}
    	else if (height <= 148) {
    		bty = height / 1.16;    		
    	}
    	else {
    		bty = height / 1.14;
    	}
    	var btx = [1.15, 1.15, 1.17, 1.19, 1.22];	
    	iconBT = new MyTextView("8", setBTIconColor(), iconsFont, width / calcXY(btx, width), bty, Graphics.TEXT_JUSTIFY_LEFT ); 
    	   	        
    	    	
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

    // Update the view
    function onUpdate(dc) {   
    	
		if (dc has :clearClip) {
			dc.clearClip();
		}
    	
        // Update the view  
        var info = Mon.getInfo();          
        setDateDisplay();   		
		setStepCountDisplay(info);
		setCaloriesDisplay(info);
		setNotificationCountDisplay();
		setHeartrateDisplay();	
		setFloorsClimbedDisplay(info);		
				
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);	
        setPhrase(dc, false);
        
        //Draw Icons
        iconSteps.setColor(gTheme.iconSteps);
        iconSteps.draw(dc);
        iconCalories.setColor(gTheme.iconCalories);	
        iconCalories.draw(dc);
        iconNotif.setColor(gTheme.iconNotif);
		iconNotif.draw(dc);
				
		iconBT.setColor(setBTIconColor());
		iconBT.draw(dc);
		iconHeart.setColor(gTheme.iconHeart);
		iconHeart.draw(dc);  
		
		iconFloorsClimbed.setColor(gTheme.iconfloorsClimbed);
		iconFloorsClimbed.draw(dc);
				        
    }
    function onPartialUpdate(dc) { 
    	mTime.drawSeconds(dc, true);
		setPhrase(dc, phraseOnSleepMode);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    	Application.getApp().setSleep(false);
    	WatchUi.requestUpdate();
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    	Application.getApp().setSleep(true);
    	WatchUi.requestUpdate();
    }
    
    
    private function setPhrase(dc, isPartial) {

	    var phY;
	    var phX;
	    if (height > 180)  {    	
    		phY = height / 1.6;
    	}
    	else if (height > 148)  { 
    		phY = height / 1.52; 
    	}   		
    	else {
    		phY = height / 1.55;
    	} 	
    	var scrolledPhrase = gPhrase.setMotivationalPhrase();
    	var just = gPhrase.getJustification(); 
    	
    	if (just == Graphics.TEXT_JUSTIFY_LEFT) {
    		phX = width / 10;
    	}
    	else {
    		phX = width / 2;
    	}
    	
    	if (isPartial) {
    		var dims = dc.getTextDimensions(scrolledPhrase, Graphics.FONT_SMALL); 
	    	dc.setClip(
				0,
				phY + 2,
				width,
				dims[1] - 2
			);
			
			dc.setColor(gTheme.phrase, gTheme.background/*Graphics.COLOR_DK_BLUE*/);	
	
			dc.clear();
		}
		else {    	
    		dc.setColor(gTheme.phrase,  Graphics.COLOR_TRANSPARENT);
    	}
    	dc.drawText(
			phX,
			phY,
			Graphics.FONT_SMALL,
			scrolledPhrase,
			just
		);
    	
	    
    }
    
    private function setDateDisplay() {        
    	var now = Time.now();
		var date = Date.info(now, Time.FORMAT_LONG);
		var dateString = Lang.format("$1$ $2$, $3$", [date.month, date.day, date.year]);
		var dateDisplay = View.findDrawableById("DateDisplay");      
		dateDisplay.setColor(gTheme.date);
		dateDisplay.setText(dateString);	    	
    }    
    
    private function setStepCountDisplay(info) {
    	var stepCount = info.steps.toString();		
		var stepCountDisplay = View.findDrawableById("StepCountDisplay");      
		stepCountDisplay.setColor(gTheme.metricsText);
		stepCountDisplay.setText(stepCount);
		//TEST
		//stepCountDisplay.setText("12848");
    }
    
    private function setFloorsClimbedDisplay(info) {
    	var floorsClimbed;
    	if (altitudeMode == 0) {
	    	if (info has :metersClimbed ){ 
	    		floorsClimbed = info.metersClimbed.toLong().toString();	
	    	}
	    	else {
	    		floorsClimbed = "--";
	    	}
	    } else {
	    	if (info has :floorsClimbed ){ 
	    		floorsClimbed = info.floorsClimbed.toLong().toString();	
	    	}
	    	else {
	    		floorsClimbed = "--";
	    	}
	    }
    	
    	//var floorsClimbedGoal = Mon.getInfo().floorsClimbedGoal.toString();
		var floorsClimbedDisplay = View.findDrawableById("FloorsClimbedDisplay");      
		floorsClimbedDisplay.setColor(gTheme.metricsText);
		floorsClimbedDisplay.setText(floorsClimbed);
		//TEST
		//floorsClimbedDisplay.setText("15");
    }
    
    private function setCaloriesDisplay(info) {
    	
    	var calories;
    	
    	if (info has :calories ){ //&& info.calories != +null) {
    		calories = info.calories.toString();
    	}
    	else {
    		calories = "--";
    	}	
    			
		 
    	var caloriesDisplay = View.findDrawableById("CaloriesDisplay");      
		caloriesDisplay.setColor(gTheme.metricsText);
		caloriesDisplay.setText(calories);
		//TEST
		//caloriesDisplay.setText("1255");
						
    }
    
    private function setNotificationCountDisplay() {
    	var notificationAmount = System.getDeviceSettings().notificationCount;
		
		var formattedNotificationAmount = "";
	
		if(notificationAmount > 10)	{
			formattedNotificationAmount = "10+";
		}
		else {
			formattedNotificationAmount = notificationAmount.format("%d");
		}
	
		var notificationCountDisplay = View.findDrawableById("NotificationDisplay");      
		notificationCountDisplay.setColor(gTheme.metricsText);
		notificationCountDisplay.setText(formattedNotificationAmount);
		
		//TEST
		//notificationCountDisplay.setText("10+");
    }
    
    private function setHeartrateDisplay() {
    	var value = "--";
    	var activityInfo = Activity.getActivityInfo();
		var heartRate = activityInfo.currentHeartRate;
		if (heartRate != null) {
			value = heartRate.format("%d");
		} else if (ActivityMonitor has :getHeartRateHistory) {
			heartRate = ActivityMonitor.getHeartRateHistory(1, /* newestFirst */ true).next();
			if ((heartRate != null) && (heartRate.heartRate != ActivityMonitor.INVALID_HR_SAMPLE)) {
				value = heartRate.heartRate.format("%d");
			}			
		}   	
    	
		var heartrateDisplay = View.findDrawableById("HeartrateDisplay");      
		heartrateDisplay.setColor(gTheme.metricsText);
		heartrateDisplay.setText(value);
		
		//TEST
		//heartrateDisplay.setText("65");
    }
    
    
    private function setBTIconColor() {
    	var color;
    	if (System.getDeviceSettings().phoneConnected) {
    		color = gTheme.iconBtOn;
    	}
    	else {
    		color = gTheme.iconBtOff;
    	}
    	
    	return color;
    }
    
    function setAltitudeConfig() {
		altitudeMode = Application.getApp().getProperty("Altitude");
    }
    function setPhraseOnSleepMode() {
    	phraseOnSleepMode = Application.getApp().getProperty("PhraseOnSleepMode");
    }
}
