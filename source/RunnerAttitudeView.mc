using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Application;

using Toybox.Time.Gregorian as Date;
using Toybox.ActivityMonitor as Mon;
using Toybox.Activity;

using Toybox.Time;

class RunnerAttitudeView extends WatchUi.WatchFace {
	
	hidden var height;
	hidden var width;
	hidden var iconsFont;
	hidden var hoursFont;
	hidden var minutesFont;
	hidden var secondsFont;
	hidden var normalFont;
	hidden var showSeconds;
	hidden var showLeadingZero;
	hidden var showBatteryPercentage;
	hidden var dateBaseY;
	hidden var bluetoothBaseY;
	hidden var bluetoothBaseX;
	hidden var secondsBaseXOffset;
	hidden var secondsBaseYOffset;
	
	hidden var iconsChars as Lang.Dictionary<Lang.Symbol, Lang.String> = { :steps => "0",
							  :floors => "1",
							  :height => ";",
							  :calories => "6",
							  :notif => "5",
							  :heart => "3" };
	
	hidden enum {
		MetersClimbed,
		Floors
	}
	private var phraseOnSleepMode;
	
	static const partialUpdateSupport = WatchUi.WatchFace has :onPartialUpdate;
	
	hidden var altitudeMode;	
	private var distanceConfig;		
	private var dateConfig;	
	
	hidden enum {
		DistanceInSteps,
		DistanceInKilometers,
		DistanceInMiles,
		DistanceInStepsKilometers,
		DistanceInStepsMiles
	}

    function initialize() {
        WatchFace.initialize();
	}

    // Load your resources here
    function onLayout(dc) {
		iconsFont = WatchUi.loadResource(Rez.Fonts.IconsFont);
		hoursFont = WatchUi.loadResource(Rez.Fonts.HoursFont);
		minutesFont = WatchUi.loadResource(Rez.Fonts.MinutesFont);
		secondsFont = WatchUi.loadResource(Rez.Fonts.SecondsFont);
		normalFont = WatchUi.loadResource(Rez.Fonts.NormalFont);
        setLayout(Rez.Layouts.WatchFace(dc));
        
        width = dc.getWidth();
        height = dc.getHeight();
		secondsBaseXOffset = null;
		secondsBaseYOffset = null;
		bluetoothBaseX = null;
        
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
		// Positions are provided by device-specific layout resources.
    }
    
    // Update the view
    function onUpdate(dc) {   
    	
		if (dc has :clearClip) {
			dc.clearClip();
		}
    	
        // Update the view  
        var info = Mon.getInfo();          
		setTimeDisplay(dc, false);
        setDateDisplay();   		
		setStepCountDisplay(info);
		setCaloriesDisplay(info);
		setNotificationCountDisplay();
		setHeartrateDisplay(dc);	
		setMetricIconsDisplay();
		setHeartAndBluetoothDisplay(dc);
		setBatteryDisplay(dc);
		setFloorsClimbedDisplay(info);
				
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);	
		drawBatteryIndicator(dc);
        setPhrase(dc, false);
				        
    }
    function onPartialUpdate(dc) { 
		setTimeDisplay(dc, true);
		drawBatteryIndicator(dc);
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
		var phraseFont = Graphics.FONT_SMALL;
		if (!isRoundScreen() && width == 320 && height == 360) {
			phraseFont = Graphics.FONT_TINY;
		}

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
		phY += (height / 42).toLong();
    	var scrolledPhrase = gPhrase.setMotivationalPhrase();
    	var just = gPhrase.getJustification(); 
    	
    	if (just == Graphics.TEXT_JUSTIFY_LEFT) {
    		phX = width / 10;
    	}
    	else {
    		phX = width / 2;
    	}
    	
    	if (isPartial) {
	    	dc.setClip(
				0,
				phY + 2,
				width,
				dc.getFontHeight(phraseFont) - 2
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
			phraseFont,
			scrolledPhrase,
			just
		);
    	
	    
    }
    
    private function setDateDisplay() {        
    	var now = Time.now();
		var date = Date.info(now, Time.FORMAT_LONG);
		var dateString = "";
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
		
		var dateDisplay = View.findDrawableById("DateDisplay") as WatchUi.Text;
		var dateFont = Graphics.FONT_SMALL;
		if (!isRoundScreen() && width == 320 && height == 360) {
			dateFont = Graphics.FONT_TINY;
		}
		dateDisplay.setFont(dateFont);
		if (dateBaseY == null) {
			dateBaseY = dateDisplay.locY;
		}
		dateDisplay.locY = dateBaseY + (height / 42).toLong();
		dateDisplay.setColor(gTheme.date);
		dateDisplay.setText(dateString);	    	
    }    

	private function setTimeDisplay(dc, renderNow as Lang.Boolean) {
		var clockTime = System.getClockTime();
		var nHour = clockTime.hour;

		if (!System.getDeviceSettings().is24Hour) {
			if (nHour > 12) {
				nHour -= 12;
			} else if (nHour == 0) {
				nHour = 12;
			}
		}

		var sHour = showLeadingZero ? nHour.format("%02d") : nHour.format("%d");
		var sMin = clockTime.min.format("%02d");
		var sSec = clockTime.sec.format("%02d");

		if (Application.getApp().isSleeping() && !partialUpdateSupport) {
			sSec = "";
		}

		if (!showSeconds) {
			sSec = "";
		}

		var hoursDisplay = View.findDrawableById("TimeHoursDisplay") as WatchUi.Text;
		var minutesDisplay = View.findDrawableById("TimeMinutesDisplay") as WatchUi.Text;
		var secondsDisplay = View.findDrawableById("TimeSecondsDisplay") as WatchUi.Text;

		hoursDisplay.setText(sHour);
		minutesDisplay.setText(sMin);
		secondsDisplay.setText(sSec);

		hoursDisplay.setColor(gTheme.time);
		minutesDisplay.setColor(gTheme.mins);
		secondsDisplay.setColor(gTheme.seconds);

		if (secondsBaseXOffset == null) {
			secondsBaseXOffset = secondsDisplay.locX - (width / 2.09);
		}

		var y = hoursDisplay.locY;
		var hoursWidth = dc.getTextWidthInPixels(sHour, hoursFont);
		var minutesWidth = dc.getTextWidthInPixels(sMin, minutesFont);
		var totalWidth = hoursWidth + minutesWidth;
		var x = (width / 2) - (totalWidth / 2);

		hoursDisplay.locX = x;
		hoursDisplay.locY = y;

		minutesDisplay.locX = x + hoursWidth;
		minutesDisplay.locY = y;

		var secondsX = x + totalWidth + secondsBaseXOffset;
		secondsDisplay.locX = secondsX;
		//secondsDisplay.locY = y + secondsBaseYOffset;

		if (renderNow) {
			hoursDisplay.draw(dc);
			minutesDisplay.draw(dc);
			secondsDisplay.draw(dc);
		}

	}
    
    private function setStepCountDisplay(info) {
    	var dist;		
		var stepCountDisplay = View.findDrawableById("StepCountDisplay") as WatchUi.Text;
		if (!isRoundScreen() && width == 320 && height == 360) {
			var stepsIconDisplay = View.findDrawableById("StepsIconDisplay") as WatchUi.Text;
			stepCountDisplay.locX = stepsIconDisplay.locX + 40;
		}
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
	    	if (info has :metersClimbed && info.metersClimbed != null){ 
	    		floorsClimbed = info.metersClimbed.toLong().toString();	
	    	}
	    	else {
	    		floorsClimbed = "0";
	    	}
	    } else {
	    	if (info has :floorsClimbed && info.floorsClimbed != null){ 
	    		floorsClimbed = info.floorsClimbed.toLong().toString();	
	    	}
	    	else {
	    		floorsClimbed = "0";
	    	}
	    }
    	
    	//var floorsClimbedGoal = Mon.getInfo().floorsClimbedGoal.toString();
		var floorsClimbedDisplay = View.findDrawableById("FloorsClimbedDisplay") as WatchUi.Text;
		var floorsIconDisplay = View.findDrawableById("FloorsIconDisplay") as WatchUi.Text;
		if (!isRoundScreen() && width == 320 && height == 360) {
			floorsClimbedDisplay.locX = floorsIconDisplay.locX + 44;
		}
		if ((floorsClimbedDisplay.locX == floorsIconDisplay.locX) && (floorsClimbedDisplay.locY == floorsIconDisplay.locY)) {
			floorsClimbedDisplay.locX = floorsIconDisplay.locX + 28;
		}
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
    			
		 
		var caloriesDisplay = View.findDrawableById("CaloriesDisplay") as WatchUi.Text;
		if (!isRoundScreen() && width == 320 && height == 360) {
			var caloriesIconDisplay = View.findDrawableById("CaloriesIconDisplay") as WatchUi.Text;
			caloriesDisplay.locX = caloriesIconDisplay.locX + 41;
		}
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
	
		var notificationCountDisplay = View.findDrawableById("NotificationDisplay") as WatchUi.Text;
		if (!isRoundScreen() && width == 320 && height == 360) {
			var notificationIconDisplay = View.findDrawableById("NotificationIconDisplay") as WatchUi.Text;
			notificationCountDisplay.locX = notificationIconDisplay.locX + 46;
		}
		notificationCountDisplay.setColor(gTheme.metricsText);
		notificationCountDisplay.setText(formattedNotificationAmount);
		
		//TEST
		//notificationCountDisplay.setText("10+");
    }
    
    private function setHeartrateDisplay(dc) {
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
    	
		var heartrateDisplay = View.findDrawableById("HeartrateDisplay") as WatchUi.Text;
		heartrateDisplay.setColor(gTheme.metricsText);
		heartrateDisplay.setText(value);
		
		//TEST
		//heartrateDisplay.setText("65");
		//heartrateDisplay.setText("165");
    }

	private function setMetricIconsDisplay() {
		var stepsIconDisplay = View.findDrawableById("StepsIconDisplay") as WatchUi.Text;
		stepsIconDisplay.setColor(gTheme.iconSteps);
		stepsIconDisplay.setText(iconsChars[:steps] as Lang.String);

		var caloriesIconDisplay = View.findDrawableById("CaloriesIconDisplay") as WatchUi.Text;
		caloriesIconDisplay.setColor(gTheme.iconCalories);
		caloriesIconDisplay.setText(iconsChars[:calories] as Lang.String);

		var notificationIconDisplay = View.findDrawableById("NotificationIconDisplay") as WatchUi.Text;
		notificationIconDisplay.setColor(gTheme.iconNotif);
		notificationIconDisplay.setText(iconsChars[:notif] as Lang.String);

		var floorsIconDisplay = View.findDrawableById("FloorsIconDisplay") as WatchUi.Text;
		floorsIconDisplay.setColor(gTheme.iconfloorsClimbed);
		if (altitudeMode == MetersClimbed) {
			floorsIconDisplay.setText(iconsChars[:height] as Lang.String);
		} else {
			floorsIconDisplay.setText(iconsChars[:floors] as Lang.String);
		}
	}

	private function setHeartAndBluetoothDisplay(dc) {
		var heartIconDisplay = View.findDrawableById("HeartIconDisplay") as WatchUi.Text;
		heartIconDisplay.setColor(gTheme.iconHeart);
		heartIconDisplay.setText(iconsChars[:heart] as Lang.String);

		var bluetoothIconDisplay = View.findDrawableById("BluetoothIconDisplay") as WatchUi.Text;
		bluetoothIconDisplay.setColor(setBTIconColor());
		bluetoothIconDisplay.setText("8");
	}

	private function setBatteryDisplay(dc) {
		var batteryDisplay = View.findDrawableById("BatteryDisplay") as WatchUi.Text;
		batteryDisplay.setText("");
	}

	private function drawBatteryIndicator(dc) {
		var batteryLevel = System.getSystemStats().battery.toNumber();
		var timeHoursDisplay = View.findDrawableById("TimeHoursDisplay") as WatchUi.Text;

		var bodyWidth = (width / 7.4).toLong();
		if (width <= 218) {
			bodyWidth = (width / 8.6).toLong();
		}
		var bodyHeight = (height / 14).toLong();
		var minBodyWidth = (width <= 218) ? 28 : 36;
		if (bodyWidth < minBodyWidth) {
			bodyWidth = minBodyWidth;
		}
		if (bodyWidth > 62) {
			bodyWidth = 62;
		}
		if (bodyHeight < 16) {
			bodyHeight = 16;
		}

		var tipWidth = 5;
		var tipHeight = (bodyHeight / 2).toLong();
		var rightMargin = width / 55;

		var x = (width - bodyWidth - tipWidth - rightMargin).toLong();
		if (width <= 218) {
			x += 5;
		}
		if (width <= 208) {
			x += 2;
		}
		if (isRoundScreen() && width == 454 && height == 454) {
			x -= 7;
		}
		if (!isRoundScreen() && width == 448 && height == 486) {
			x -= 3;
		}
		var y = getTimeTopY(dc, timeHoursDisplay);
		if (!isRoundScreen() && width == 320 && height == 360) {
			y += 35;
		}
		if (!isRoundScreen() && width == 448 && height == 486) {
			y += 60;
		}
		if (isRoundScreen() && width == 416 && height == 416) {
			y -= 4;
		}
		if (width == 218 && height == 218) {
			y += 7;
		}
		if (width == 208 && height == 208) {
			y += 7;
		}
		if (width == 215 && height == 180) {
			y += 9;
		}
		if (width == 240 && height == 240) {
			y += 4;
		}
		if (isRoundScreen() && width >= 454) {
			y += (height / 40).toLong();
			if (width == 454 && height == 454) {
				y -= 2;
			}
		}

		var color = gTheme.batteryOk;
		if (batteryLevel <= 25) {
			color = gTheme.batteryLow;
		}
		if (batteryLevel <= 10) {
			color = gTheme.batteryCritical;
		}

		dc.setColor(color, Graphics.COLOR_TRANSPARENT);
		dc.drawRoundedRectangle(x, y, bodyWidth, bodyHeight, 2);
		dc.fillRoundedRectangle(x + bodyWidth, y + ((bodyHeight - tipHeight) / 2), tipWidth, tipHeight, 1);

		var levelWidth = ((batteryLevel * (bodyWidth - 4)) / 100).toLong();
		if (levelWidth > 0) {
			dc.fillRectangle(x + 2, y + 2, levelWidth, bodyHeight - 4);
		}

		if (showBatteryPercentage) {
			var text = batteryLevel.toString() + "%";
			var textWidth = dc.getTextWidthInPixels(text, normalFont);
			var textHeight = dc.getFontHeight(normalFont);
			var textX = x + ((bodyWidth - textWidth) / 2);
			var textY = y + ((bodyHeight - textHeight) / 2) - (textHeight / 11);
			dc.setColor(gTheme.batteryText, Graphics.COLOR_TRANSPARENT);
			dc.drawText(textX, textY, normalFont, text, Graphics.TEXT_JUSTIFY_LEFT);
		}
	}

	private function getTimeTopY(dc, timeHoursDisplay) as Lang.Number {
		if (!isRoundScreen() || width <= 240) {
			return timeHoursDisplay.locY;
		}
		return (timeHoursDisplay.locY - (timeHoursDisplay.locY - dc.getFontHeight(hoursFont))).toLong();
	}

	private function isRoundScreen() as Lang.Boolean {
		var settings = System.getDeviceSettings();
		if (settings has :screenShape) {
			return settings.screenShape == System.SCREEN_SHAPE_ROUND;
		}
		return true;
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
    
    private function getSettingValue(key) {
		return Application.Properties.getValue(key);
	}
    
    function getAltitudeConfig() {
		altitudeMode = getSettingValue("Altitude").toNumber();
    }
    function getPhraseOnSleepMode() {
		phraseOnSleepMode = getSettingValue("PhraseOnSleepMode");
	}
    function getDistanceConfig() {
		distanceConfig = getSettingValue("DistanceConfig").toNumber();
    }
    function getDateConfig() {
		dateConfig = getSettingValue("DateConfig").toNumber();
    }

	function getSecondsConfig() {
		showSeconds = getSettingValue("ShowSeconds");
	}

	function getLeadingZeroConfig() {
		showLeadingZero = getSettingValue("ShowLeadingZero");
	}

	function getBatteryPercentageConfig() {
		showBatteryPercentage = getSettingValue("BatteryPercentage");
	}
}
