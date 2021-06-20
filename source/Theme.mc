using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics as Gfx;

class Theme {
	var time;
	var mins;
	var seconds;
	var phrase;
	var date;
	var iconCalories;
	var iconSteps;
	var iconHeart;
	var iconNotif;	
	var iconfloorsClimbed;
	var metricsText;
	var iconBtOff;
	var iconBtOn;
	var batteryOk;
	var batteryLow;
	var batteryCritical;
	var trackLine;
	var trackProgress;
	var background;	
	
	hidden enum {
		RunnerAttitude,
		NightRunner,
		Twilight,
		MountainTrails,
		CityRunner,
		TrackTraining,
		RunningGirl,
		ShinnyDay,
		SnowRun,
		ClassicRunner,
		ForestTrain,
		SunsetRun,
		StarryNightRun,
		Ultraviolet,
		FinishLine,
		QuirkyRunner,
		RunningIsColor,
		RunningIsColor2,
		MuddySneakers,
		PurpleSky,
		NorthernLights,
		WatchBacklight
	}	
	
	function initialize() {		
		
        setTheme();        
	}			
	
	function setTheme() {
		var selectedTheme = Application.getApp().getProperty("ThemeColor").toNumber();
		if (selectedTheme == null) {
        	selectedTheme = 0;
        }
		
		switch (selectedTheme) {
			case RunnerAttitude:
				setClockColors(0xFFFFFF, 0xAAAAAA, 0xAAAAAA);
				phrase = 0x00AAAA;
				date = 0x00AAAA;
				iconCalories = 0xFFAA00;
				iconSteps = 0xAA55AA;
				iconHeart = 0xFF0055;
				iconNotif = 0xAAAAFF;
				iconfloorsClimbed = 0xAA5555;
				metricsText = 0xFFFFFF;
				setColor4BTIcon(Gfx.COLOR_DK_GRAY, Gfx.COLOR_BLUE);
				setColor4BatteryIcon(0x55AA00, Gfx.COLOR_ORANGE, Gfx.COLOR_DK_RED);
				setTrackLine( 0x00AA55, 0x00FFAA);
				background = Gfx.COLOR_BLACK;
				break;
				
		
			case NightRunner:
				setClockColors(0x0055AA, 0x55AAFF, 0x55AAFF);
				phrase = 0xAAAAAA;
				date = 0xAAAAAA;
				setColor4AllIcons(0x0055AA);
				metricsText = Gfx.COLOR_BLUE;
				setColor4BTIcon(Gfx.COLOR_DK_GRAY, 0x0055AA);
				setColor4BatteryIcon(0x0055AA, Gfx.COLOR_ORANGE, Gfx.COLOR_DK_RED);
				setTrackLine(0x0055AA, Gfx.COLOR_BLUE);
				background = Gfx.COLOR_BLACK;				
				break;
				
			case Twilight:
				setClockColors(0xFF5500, 0xFFAA00, 0xAAAAFF);
				phrase = 0xFFAA00;
				date = 0xFFAA55;
				setColor4AllIcons(0x0055FF);
				metricsText = 0xAAAAFF;
				setColor4BTIcon(0x0055FF, 0x00AAFF);
				setColor4BatteryIcon(0x0055FF, 0xFF5500, 0xFF5555);
				setTrackLine(0xFFAA55, 0xFF5500);
				background = 0x000055;
				break;
				
			case MountainTrails:
				setClockColors(0x55AA00, 0xAAAA55, 0x00AA00);
				phrase = 0xAAAAAA;
				date = 0xAAAAAA;
				setColor4AllIcons(0x00AA55);
				metricsText = 0x00FF00;
				setColor4BTIcon(0x00AA55, 0x00AAAA);
				setColor4BatteryIcon(0x55AA55, 0xAAAA00, 0xAA5500);
				setTrackLine(0xAAAA55, 0x55FF55);
				background = 0x555500;
				break;
				
			case CityRunner:
				setClockColors(0xFFFFFF, 0x55FFFF, 0xAAAAAA);
				phrase = 0x00FFFF;
				date = 0xFFAA55;
				iconCalories = 0xFF5500;
				iconSteps = 0x00AA55;
				iconHeart = 0xFF0055;
				iconNotif = 0x00FFAA;
				iconfloorsClimbed = 0xAA5555;	
				metricsText = 0xFFFFFF;
				setColor4BTIcon(0xAAAAAA, 0x00AAFF);
				setColor4BatteryIcon(0x00FF00, 0xFFFF00, 0xAA5500);
				setTrackLine(0xAAAAAA, 0xFF5500);
				background = 0x555555;
				break;
				
			case TrackTraining:
				setClockColors(0x00FFFF, 0x00FFFF, 0x55AAFF);
				phrase = 0x55FFFF;
				date = 0x55AAFF;
				setColor4AllIcons(0x55AAFF);
				metricsText = 0xFFFFFF;
				setColor4BTIcon(0xAAAAAA, 0x55AAFF);
				setColor4BatteryIcon(0x55AAFF, 0xFFAA00, 0xFF0000);
				setTrackLine(0x55AAFF, 0x00FFFF);
				background = 0x0000AA;
				break;
				
			case RunningGirl:
				setClockColors(0xFFFFFF, 0xFFFFFF, 0xFFFFFF);
				phrase = 0xFFAAFF;
				date = 0xFFAAFF;
				setColor4AllIcons(0xFF55AA);
				metricsText = 0xFFFFFF;
				setColor4BTIcon(0xAAAAAA, 0xFF55AA);
				setColor4BatteryIcon(0xFF55AA, 0xFFAA00, 0xFF0000);
				setTrackLine(0xFF55AA, 0xFFAAFF);
				background = 0xAA0055;
				break;
			
			case ShinnyDay:	
				setClockColors(0x000055, 0x000055, 0x000055);		
				phrase = 0x0055AA;
				date = 0x0055AA;
				iconCalories = 0xFF5500;
				iconSteps = 0x00AA55;
				iconHeart = 0xFF0055;
				iconNotif = 0x55AAFF;
				iconfloorsClimbed = 0xAA5555;	
				metricsText = 0x000000;
				setColor4BTIcon(0xAAAAAA, 0x0055FF);
				setColor4BatteryIcon(0x55AA00, Gfx.COLOR_ORANGE, Gfx.COLOR_DK_RED);
				setTrackLine(0x0055AA, 0xFF5500);
				background = 0xFFFFFF;			
				break;
				
			case SnowRun:
				setClockColors(0x000000, 0x000000, 0x000000);			
				phrase = 0x555555;
				date = 0x555555;
				setColor4AllIcons(0x000000);
				metricsText = 0x000000;
				setColor4BTIcon(0xAAAAAA, 0x000000);
				setColor4BatteryIcon(0x000000, 0xFF5500, 0xAA0000);
				setTrackLine(0x555555, 0x000000);
				background = 0xFFFFFF;			
				break;
			
			case ClassicRunner:	
				setClockColors(0xFFFFFF, 0xAAAAAA, 0xAAAAAA);		
				phrase = 0xFFFFFF;
				date = 0xAAAAAA;
				setColor4AllIcons(0xFFFFFF);
				metricsText = 0xFFFFFF;
				setColor4BTIcon(0xAAAAAA, 0xFFFFFF);
				setColor4BatteryIcon(0xFFFFFF, 0xFF5500, 0xAA0000);
				setTrackLine(0xAAAAAA, 0xFFFFFF);
				background = 0x000000;			
				break;
				
			case ForestTrain:
				setClockColors(0xAAAA00, 0xAAAA55, 0xAAAA55);			
				phrase = 0xAAAA55;
				date = 0xAAAA55;
				iconCalories = 0xFFFF00;
				iconSteps = 0xFFAA00;
				iconHeart = 0xFF55AA;
				iconNotif = 0xAA55FF;
				iconfloorsClimbed = 0xAA5555;	
				metricsText = 0xFFFFFF;
				setColor4BTIcon(0xAAAAAA, 0x00AAFF);
				setColor4BatteryIcon(0x00FF00, 0xFFFF00, 0xFF5555);
				setTrackLine(0xAA5555, 0xAAAA55);
				background = 0x005500;			
				break;
			
			case SunsetRun:
				setClockColors(0xFFFF00, 0xFFFF55, 0xFFFFAA);
				phrase = 0xFFFF55;
				date = 0xFFFF55;
				setColor4AllIcons(0xFFFFAA);
				metricsText = 0xFFFFFF;
				setColor4BTIcon(0xAAAAAA, 0xAAAAFF);
				setColor4BatteryIcon(0xAAAA55, 0xFFFF00, 0xAA0000);
				setTrackLine(0xFFFFAA, 0xFFFF00);
				background = 0xFF5555;			
				break;
				
			case StarryNightRun:
				setClockColors(0xFFFFFF, 0xAAAAAA, 0xAAAAAA);
				phrase = 0xFFFFFF;
				date = 0xAAAAAA;
				setColor4AllIcons(0xFFFFFF);
				metricsText = 0xFFFFFF;
				setColor4BTIcon(0xAAAAAA, 0xFFFFFF);
				setColor4BatteryIcon(0xFFFFFF, 0xFFAA00, 0xFF0055);
				setTrackLine(0xAAAAAA, 0xFFFFFF);
				background = 0x0000AA;
				break;
			
			case Ultraviolet:
				setClockColors(0xFFFFFF, 0xAAAAAA, 0xAAAAAA);
				phrase = 0xFFFFFF;
				date = 0xAAAAAA;
				setColor4AllIcons(0xFFFFFF);
				metricsText = 0xFFFFFF;
				setColor4BTIcon(0xAAAAAA, 0xFFFFFF);
				setColor4BatteryIcon(0xFFFFFF, 0xFFAA00, 0xFF0055);
				setTrackLine(0xAA55FF, 0xFFFFFF);
				background = 0x5500AA;
				break;
			
			case FinishLine:
				setClockColors(0x55FFFF, 0x55FFFF, 0xAAFFFF);
				phrase = 0xAAFFFF;
				date = 0xAAFFFF;
				setColor4AllIcons(0xFFFFFF);	
				metricsText = 0xAAFFFF;
				setColor4BTIcon(0xAAAAAA, 0xFFFFFF);
				setColor4BatteryIcon(0xFFFFFF, 0xFFAA00, 0xFF0055);
				setTrackLine(0xFFFFFF, 0x55FFFF);
				
				background = 0xAA0000;
				break;
			
			case QuirkyRunner:
				setClockColors(0x00FFAA, 0xAAFFFF, 0xAAFFFF);
				phrase = 0xAAFFAA;
				date = 0xAAFFAA;
				setColor4AllIcons(0xFFAA55);
				metricsText = 0xFFFFFF;
				setColor4BTIcon(0xAAAAAA, 0xFFAA55);
				setColor4BatteryIcon(0x00FFAA, 0xFFFFAA, 0xFF5555);
				setTrackLine( 0xAAFFFF, 0x00FFAA);
				background = 0x0055AA;
				break;
				
			case RunningIsColor:
				setClockColors(0xFF0055, 0x00FFFF, 0xFFFFFF);
				phrase = 0x00FFAA;
				date = 0xFFAAAA;
				iconCalories = 0xFFFF00;
				iconSteps = 0xFF5500;
				iconHeart = 0xFF0000;
				iconNotif = 0xAA00AA;
				iconfloorsClimbed = 0x00FF00;
				metricsText = 0xFFFFFFA;
				setColor4BTIcon(0xAAAAAA, 0x00AAFF);
				setColor4BatteryIcon(0x55AA00, Gfx.COLOR_ORANGE, Gfx.COLOR_DK_RED);
				setTrackLine( 0xAAAAAA, 0xFFFF00);
				background = Gfx.COLOR_BLACK;
				break;
				
			case RunningIsColor2:
				setClockColors(0xFF5500, 0x0055FF, 0xFFFFFF);
				phrase = 0x00AAFF;
				date = 0xFFFF55;
				iconCalories = 0xFFFF00;
				iconSteps = 0xFF5500;
				iconHeart = 0xFF0000;
				iconNotif = 0xAA00AA;
				iconfloorsClimbed = 0x00FF00;
				metricsText = 0xFFFFFFA;
				setColor4BTIcon(0xAAAAAA, 0x00AAFF);
				setColor4BatteryIcon(0x55AA00, Gfx.COLOR_ORANGE, Gfx.COLOR_DK_RED);
				setTrackLine( 0xAAAAAA, 0x00AA00);
				background = Gfx.COLOR_BLACK;
				break;
			
			case MuddySneakers:
				setClockColors(0x550000, 0x550000, 0x550000);		
				phrase = 0x550000;
				date = 0x550000;
				setColor4AllIcons(0x550000);
				metricsText = 0x550000;
				setColor4BTIcon(0xAAAAAA, 0x550000);
				setColor4BatteryIcon(0x550000, 0xFF5500, 0xAA0000);
				setTrackLine(0xAAAAAA, 0x550000);
				background = 0xAAFFFF;			
				break;
				
			case PurpleSky:
				setClockColors(0xAAFFFF, 0xAAFFFF, 0xAAFFFF);		
				phrase = 0xFFAAAA;
				date = 0xFFAAAA;
				setColor4AllIcons(0xAAAAFF);
				metricsText = 0xAAFFFF;
				setColor4BTIcon(0xAAAAAA, 0xAAAAFF);
				setColor4BatteryIcon(0xAAAAFF, 0xFFAA00, 0xFF0000);
				setTrackLine(0xAAAAAA, 0xFFAAAA);
				background = 0x550055;			
				break;
			
			case NorthernLights:
				setClockColors(0x00FFAA, 0xAAFFFF, 0xAAFFFF);		
				phrase = 0xAAFFFF;
				date = 0xFFAAAA;
				setColor4AllIcons(0x00FFAA);
				metricsText = 0xAAFFFF;
				setColor4BTIcon(0xAAAAAA, 0x00FFAA);
				setColor4BatteryIcon(0x00FFAA, 0xFFAA00, 0xFF0000);
				setTrackLine(0xAAAAAA, 0xFFAAAA);
				background = 0x000055;			
				break;
				
			case WatchBacklight:
				setClockColors(0x000000, 0x000000, 0x000000);		
				phrase = 0x000000;
				date = 0x000000;
				setColor4AllIcons(0x000000);
				metricsText = 0x000000;
				setColor4BTIcon(0xAAAAAA, 0x000000);
				setColor4BatteryIcon(0x000000, 0xFF5500, 0xAA0000);
				setTrackLine(0x555555, 0x000000);
				background = 0x00FFAA;			
				break;
				
			
		}
	}
	
	private function setClockColors(t, m, s) {
		time = t;
		mins = m;
		seconds = s;
	}
	
	private function setColor4AllIcons(color) {
		iconCalories = color;
		iconSteps = color;
		iconHeart = color;
		iconNotif = color;
		iconfloorsClimbed = color;	
	}	
	private function setColor4BTIcon(off, on) {
		iconBtOff = off;
		iconBtOn = on;
	}
	private function setColor4BatteryIcon(ok, low, critical) {
		batteryOk = ok;
		batteryLow = low;
		batteryCritical = critical;
	}
	private function setTrackLine(tl, tp) {
		trackLine = tl;
		trackProgress = tp;
	}
	
}