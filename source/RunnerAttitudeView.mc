using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Application;
using Toybox.Math;

using Toybox.Time.Gregorian as Date;
using Toybox.ActivityMonitor as Mon;
using Toybox.Activity;
using Toybox.Weather;

using Toybox.Time;
using Toybox.Time.Gregorian;

class RunnerAttitudeView extends WatchUi.WatchFace {
	
	hidden var height;
	hidden var width;
	hidden var motivationalDisplay;
	hidden var iconsFont;
	hidden var weatherIconsFont;
		
	hidden var iconSteps;
	hidden var iconCalories;
	hidden var iconBT;
	hidden var iconNotif;
	hidden var iconHeart;
	hidden var iconFloorsClimbed;
	hidden var iconWeather;
	
	hidden var iconsChars = { :steps => "0",
							  :floors => "1",
							  :height => ";",
							  :calories => "6",
							  :notif => "5",
							  :heart => "3" };
	
	hidden var iconsCharsWeather = { 	:clear => "H",
										:lightClouds => "G",
										:scatteredClouds => "B",
										:brokenClouds => "I",
										:showerRain => "E",
										:rain => "D",
										:thunderStorm  => "C",
										:snow => "F",
										:mist => 'A' };
	hidden enum {
		MetersClimbed,
		Floors
	}
	private var mTime;
	
	private var phraseOnSleepMode;
	
	static const partialUpdateSupport = WatchUi.WatchFace has :onPartialUpdate;
	
	hidden var altitudeMode;	
	private var distanceConfig;		
	private var dateConfig;	
	private var temperatureUnits;
	hidden var weatherRefreshInterval = 3600;
	hidden var timeBase;
	hidden var firstRun = true;
	
	hidden enum {
		DistanceInSteps,
		DistanceInKilometers,
		DistanceInMiles,
		DistanceInStepsKilometers,
		DistanceInStepsMiles
	}
	
	hidden enum {
		Celsius,
		Fahrenheit,
		WeatherOff
	}	

    function initialize() {
        WatchFace.initialize();
		if (Toybox has :Weather) {
			timeBase = new Time.Moment(Time.now().value());			
		}
	}

    // Load your resources here
    function onLayout(dc) {
    	iconsFont = WatchUi.loadResource(Rez.Fonts.IconsFont);
    	if (Toybox has :Weather) {
    		weatherIconsFont = WatchUi.loadResource(Rez.Fonts.WeatherIconsFont);
    	}
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
    		dateDisplay.locY = height / 3.7;
    		dateDisplay.setFont(Graphics.FONT_TINY);
    		System.println(height);
    	}	
    	
    	//Steps
    	var stepCountDisplay = View.findDrawableById("StepCountDisplay"); 
    	stepCountDisplay.locX = width / 3.96;
    	stepCountDisplay.locY = height / 5.5;
    	iconSteps = new MyTextView(iconsChars[:steps], gTheme.iconSteps, iconsFont, width / 6.8, height / 5.4, Graphics.TEXT_JUSTIFY_LEFT );  
    	
    	//floors
    	var floorsClimbedDisplay = View.findDrawableById("FloorsClimbedDisplay"); 
    	floorsClimbedDisplay.locX = width / 2.55;
    	floorsClimbedDisplay.locY = height / 1.3;
    	iconFloorsClimbed = new MyTextView(:height, gTheme.iconfloorsClimbed, iconsFont, width / 3.7, height / 1.3, Graphics.TEXT_JUSTIFY_LEFT );  
    	    	
    	//Calories
    	var caloriesDisplay = View.findDrawableById("CaloriesDisplay"); 	
    	caloriesDisplay.locX = width / 1.45;    	
    	caloriesDisplay.locY = height / 1.3; 
    	iconCalories = new MyTextView(iconsChars[:calories], gTheme.iconCalories, iconsFont, width / 1.72, height / 1.3, Graphics.TEXT_JUSTIFY_LEFT );
    	
    	//Notifications
    	var notificationDisplay = View.findDrawableById("NotificationDisplay"); 	
    	notificationDisplay.locX = width / 1.23;
    	notificationDisplay.locY = height / 5.5;
    	iconNotif = new MyTextView(iconsChars[:notif], gTheme.iconNotif, iconsFont, width / 1.45, height / 5.4, Graphics.TEXT_JUSTIFY_LEFT );
    	
    	//Heart rate    	
    	var heartrateDisplay = View.findDrawableById("HeartrateDisplay"); 
    	var heartX = [35, 28, 18, 16, 20];	
    	var hrX = [12, 11.5, 9.7, 9.6, 10];
    	var heartY = [2.4, 2.35, 2.3, 2.35, 2.45];
    	var hrY = [2, 1.95, 1.9, 1.95, 2]; 
 
    	heartrateDisplay.locX = width / calcXY(hrX, width);
    	heartrateDisplay.locY = height / calcXY(hrY, height);
    	
    	iconHeart = new MyTextView(iconsChars[:heart], gTheme.iconHeart, iconsFont, width / calcXY(heartX, width), height / calcXY(heartY, height), Graphics.TEXT_JUSTIFY_LEFT);
    	
    	//Blue thooth
    	var bty = 0;
    	if (height > 180) {
    		bty = height / 3.5;    		
    	}
    	else if (height <= 148) {
    		bty = height / 1.16;    		
    	}
    	else {
    		bty = height / 1.14;    		
    	}
    	var btx = [1.15, 1.15, 1.17, 1.18, 1.18];	
    	iconBT = new MyTextView("8", setBTIconColor(), iconsFont, width / calcXY(btx, width), bty, Graphics.TEXT_JUSTIFY_LEFT ); 
    	
    	//Weather
    	var notificationWeather = View.findDrawableById("WeatherDisplay");
    	notificationWeather.locX = width / 1.95;
	    notificationWeather.locY = height / 1.13;
    	var iconWeatherColor;
    	if (Toybox has :Weather && temperatureUnits != WeatherOff) {
    		iconWeatherColor = gTheme.iconWeather;
    	} 
    	else {
    		iconWeatherColor = Graphics.COLOR_TRANSPARENT;
    	}
    	if (Toybox has :Weather) {    		    	 	
	    	iconWeather = new MyTextView("A", iconWeatherColor, weatherIconsFont, width / 2.6, height / 1.15, Graphics.TEXT_JUSTIFY_LEFT );
	    }       	    	
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
		if (Toybox has :Weather && temperatureUnits != WeatherOff) {
			var timeNow = new Time.Moment(Time.now().value());
			var timeInc = timeNow.compare(timeBase);
		    	
			if (timeInc > weatherRefreshInterval)
			{
				setWeather();
				timeBase = new Time.Moment(Time.now().value());
			}
			else if (firstRun == true) {
				setWeather();
			}						
		}
		else {
			var notificationWeather = View.findDrawableById("WeatherDisplay");
			notificationWeather.setText("");
		}
				
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
		
		if (altitudeMode == MetersClimbed){
			iconFloorsClimbed.setText(iconsChars[:height]);
		} else {
			iconFloorsClimbed.setText(iconsChars[:floors]);
		}
		iconFloorsClimbed.setColor(gTheme.iconfloorsClimbed);
		iconFloorsClimbed.draw(dc);
		
		if (Toybox has :Weather && temperatureUnits != WeatherOff) {
			iconWeather.setColor(gTheme.iconWeather);
        	iconWeather.draw(dc);
		}

		firstRun = false;
				        
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
		var dateString;
		switch (dateConfig) {
			case 0:
				dateString = Lang.format("$1$ $2$, $3$", [date.month, date.day, date.year]);
				break;
			case 1:
				dateString = Lang.format("$1$ $2$, $3$", [date.day, date.month, date.year]);
				break;
			case 2:
				dateString = Lang.format("$1$ $2$ $3$", [date.day_of_week, date.day, date.month]);
				break;
			case 3:
				dateString = Lang.format("$1$ $2$, $3$", [date.month, date.day, date.day_of_week]);
				break;			
		}		
		
		var dateDisplay = View.findDrawableById("DateDisplay");      
		dateDisplay.setColor(gTheme.date);
		dateDisplay.setText(dateString);	    	
    }    
    
    private function setStepCountDisplay(info) {
    	var dist;		
		var stepCountDisplay = View.findDrawableById("StepCountDisplay");   
		switch (distanceConfig) {
			case DistanceInSteps:
				dist = info.steps.toString();
			break;
			case DistanceInKilometers:
				dist = (info.distance / 100000.00).format("%.02f").toString();
				break;
			case DistanceInMiles:
				dist = ((info.distance / 100000.00) * 0.621371).format("%.02f").toString();
				break;
			case DistanceInStepsKilometers:
				dist = info.steps.toString() + "-" + (info.distance / 100000.00).format("%.01f").toString();
				break;
			case DistanceInStepsMiles:
				dist = info.steps.toString() + "-" + ((info.distance / 100000.00) * 0.621371).format("%.01f").toString();
				break;				
			default:
				dist = info.steps.toString();
				break;
		}   
		stepCountDisplay.setColor(gTheme.metricsText);
		stepCountDisplay.setText(dist);
		//TEST
		//stepCountDisplay.setText("99999-999.9");		
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
		//floorsClimbedDisplay.setText("17");
    }
    
    private function setCaloriesDisplay(info) {
    	
    	var calories;
    	
    	if (info has :calories && info.calories != null) {
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
		//heartrateDisplay.setText("165");
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
    
    private function setWeather() { 
		var currentWeather = Weather.getCurrentConditions();
		var notificationWeather = View.findDrawableById("WeatherDisplay");
		var weatherSymbol = "A";
		
		switch (currentWeather.condition)
		{
			case Weather.CONDITION_CLEAR:
				weatherSymbol = iconsCharsWeather[:clear];
				break;
			case Weather.CONDITION_PARTLY_CLOUDY:
				weatherSymbol = iconsCharsWeather[:lightClouds];
				break;
			case Weather.CONDITION_MOSTLY_CLOUDY:
				weatherSymbol = iconsCharsWeather[:brokenClouds];
				break;
			case Weather.CONDITION_RAIN:
				weatherSymbol = iconsCharsWeather[:rain];
				break;
			case Weather.CONDITION_SNOW:
				weatherSymbol = iconsCharsWeather[:snow];
				break;
			case Weather.CONDITION_WINDY:
				weatherSymbol = iconsCharsWeather[:lightClouds];
				break;
			case Weather.CONDITION_THUNDERSTORMS:
				weatherSymbol = iconsCharsWeather[:thunderStorm];
				break;
			case Weather.CONDITION_WINTRY_MIX:
				weatherSymbol = iconsCharsWeather[:lightClouds];
				break;
			case Weather.CONDITION_FOG:
				weatherSymbol = iconsCharsWeather[:mist];
				break;
			case Weather.CONDITION_HAZY:
				weatherSymbol = iconsCharsWeather[:mist];
				break;
			case Weather.CONDITION_HAIL:
				weatherSymbol = iconsCharsWeather[:thunderStorm];
				break;
			case Weather.CONDITION_SCATTERED_SHOWERS:
				weatherSymbol = iconsCharsWeather[:showerRain];
				break;
			case Weather.CONDITION_SCATTERED_THUNDERSTORMS:
				weatherSymbol = iconsCharsWeather[:thunderStorm];
				break;
			case Weather.CONDITION_UNKNOWN_PRECIPITATION:
				weatherSymbol = iconsCharsWeather[:showerRain];
				break;
			case Weather.CONDITION_LIGHT_RAIN:
				weatherSymbol = iconsCharsWeather[:showerRain];
				break;
			case Weather.CONDITION_HEAVY_RAIN:
				weatherSymbol = iconsCharsWeather[:rain];
				break;
			case Weather.CONDITION_LIGHT_SNOW:
				weatherSymbol = iconsCharsWeather[:snow];
				break;
			case Weather.CONDITION_HEAVY_SNOW:
				weatherSymbol = iconsCharsWeather[:snow];
				break;
			case Weather.CONDITION_LIGHT_RAIN_SNOW:
				weatherSymbol = iconsCharsWeather[:snow];
				break;
			case Weather.CONDITION_HEAVY_RAIN_SNOW:
				weatherSymbol = iconsCharsWeather[:snow];
				break;
			case Weather.CONDITION_CLOUDY:
				weatherSymbol = iconsCharsWeather[:brokenClouds];
				break;
			case Weather.CONDITION_RAIN_SNOW:
				weatherSymbol = iconsCharsWeather[:snow];
				break;
			case Weather.CONDITION_PARTLY_CLEAR:
				weatherSymbol = iconsCharsWeather[:lightClouds];
				break;
			case Weather.CONDITION_MOSTLY_CLEAR:
				weatherSymbol = iconsCharsWeather[:clear];
				break;
			case Weather.CONDITION_LIGHT_SHOWERS:
				weatherSymbol = iconsCharsWeather[:showerRain];
				break;
			case Weather.CONDITION_SHOWERS:
				weatherSymbol = iconsCharsWeather[:showerRain];
				break;
			case Weather.CONDITION_HEAVY_SHOWERS:
				weatherSymbol = iconsCharsWeather[:rain];
				break;
			case Weather.CONDITION_CHANCE_OF_SHOWERS:
				weatherSymbol = iconsCharsWeather[:showerRain];
				break;
			case Weather.CONDITION_CHANCE_OF_THUNDERSTORMS:
				weatherSymbol = iconsCharsWeather[:thunderStorm];
				break;
			case Weather.CONDITION_MIST:
				weatherSymbol = iconsCharsWeather[:mist];
				break;
			case Weather.CONDITION_DUST:
				weatherSymbol = iconsCharsWeather[:mist];
				break;
			case Weather.CONDITION_DRIZZLE:
				weatherSymbol = iconsCharsWeather[:showerRain];
				break;
			case Weather.CONDITION_TORNADO:
				weatherSymbol = iconsCharsWeather[:thunderStorm];
				break;
			case Weather.CONDITION_SMOKE:
				weatherSymbol = iconsCharsWeather[:mist];
				break;
			case Weather.CONDITION_ICE:
				weatherSymbol = iconsCharsWeather[:snow];
				break;
			case Weather.CONDITION_SAND:
				weatherSymbol = iconsCharsWeather[:mist];
				break;
			case Weather.CONDITION_SQUALL:
				weatherSymbol = iconsCharsWeather[:showerRain];
				break;
			case Weather.CONDITION_SANDSTORM:
				weatherSymbol = iconsCharsWeather[:mist];
				break;
			case Weather.CONDITION_VOLCANIC_ASH:
				weatherSymbol = iconsCharsWeather[:mist];
				break;
			case Weather.CONDITION_HAZE:
				weatherSymbol = iconsCharsWeather[:mist];
				break;
			case Weather.CONDITION_FAIR:
				weatherSymbol = iconsCharsWeather[:clear];
				break;
			case Weather.CONDITION_HURRICANE:
				weatherSymbol = iconsCharsWeather[:thunderStorm];
				break;
			case Weather.CONDITION_TROPICAL_STORM:
				weatherSymbol = iconsCharsWeather[:thunderStorm];
				break;
			case Weather.CONDITION_CHANCE_OF_SNOW:
				weatherSymbol = iconsCharsWeather[:snow];
				break;
			case Weather.CONDITION_CHANCE_OF_RAIN_SNOW:
				weatherSymbol = iconsCharsWeather[:snow];
				break;
			case Weather.CONDITION_CLOUDY_CHANCE_OF_RAIN:
				weatherSymbol = iconsCharsWeather[:rain];
				break;
			case Weather.CONDITION_CLOUDY_CHANCE_OF_SNOW:
				weatherSymbol = iconsCharsWeather[:snow];
				break;
			case Weather.CONDITION_CLOUDY_CHANCE_OF_RAIN_SNOW:
				weatherSymbol = iconsCharsWeather[:snow];
				break;
			case Weather.CONDITION_FLURRIES:
				weatherSymbol = iconsCharsWeather[:lightClouds];
				break;
			case Weather.CONDITION_FREEZING_RAIN:
				weatherSymbol = iconsCharsWeather[:rain];
				break;
			case Weather.CONDITION_SLEET:
				weatherSymbol = iconsCharsWeather[:snow];
				break;
			case Weather.CONDITION_ICE_SNOW:
				weatherSymbol = iconsCharsWeather[:snow];
				break;
			case Weather.CONDITION_THIN_CLOUDS:
				weatherSymbol = iconsCharsWeather[:lightClouds];
				break;
			case Weather.CONDITION_UNKNOWN:
				weatherSymbol = iconsCharsWeather[:scatteredClouds];
				break;					
		}
			
		var clockTime = System.getClockTime();    	
    	var nHour = clockTime.hour;
    	//nHour = 5;
    	var currentTemperature = currentWeather.temperature;
    	var temperatureSymbol = " C";
    	if (temperatureUnits == Fahrenheit) {
    	  	//F = C * 1.8 + 32
    	  	temperatureSymbol = " F";
    	  	currentTemperature = (currentTemperature * 1.8 + 32).toLong();    	  	
    	}
    	if ((nHour < 7 || nHour > 19) && (weatherSymbol != iconsCharsWeather[:brokenClouds])) {
    		weatherSymbol = weatherSymbol.toLower();
    	}
    	
		notificationWeather.setColor(gTheme.metricsText); 	
		notificationWeather.setText(currentTemperature.toString() + temperatureSymbol);
		iconWeather.setText(weatherSymbol);
    }
    
    function getAltitudeConfig() {
		altitudeMode = Application.getApp().getProperty("Altitude");		
    }
    function getPhraseOnSleepMode() {
    	phraseOnSleepMode = Application.getApp().getProperty("PhraseOnSleepMode");
    }
    function getDistanceConfig() {
    	distanceConfig = Application.getApp().getProperty("DistanceConfig");    	
    }
    function getDateConfig() {
    	dateConfig = Application.getApp().getProperty("DateConfig");    	
    }
    function getTemperatureUnits() {
    	temperatureUnits = Application.getApp().getProperty("TemperatureUnits");
    	firstRun = true;
    }
}
