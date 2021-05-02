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
		FinishLine
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
				time = 0xFFFFFF;
				mins = 0xAAAAAA;
				seconds = 0xAAAAAA;
				phrase = 0x00AAAA;
				date = 0x00AAAA;
				iconCalories = 0xFFAA55;
				iconSteps = 0xAA5555;
				iconHeart = 0xFF0055;
				iconNotif = 0xAAAAFF;	
				metricsText = Gfx.COLOR_LT_GRAY;
				iconBtOff = Gfx.COLOR_DK_GRAY;
				iconBtOn = Gfx.COLOR_BLUE;
				batteryOk = 0x55AA00;
				batteryLow = Gfx.COLOR_ORANGE;
				batteryCritical = Gfx.COLOR_DK_RED;
				trackLine = 0x00AA55;
				trackProgress = 0x00FFAA;
				background = Gfx.COLOR_BLACK;
				break;
				
		
			case NightRunner:
				time = 0x0055AA;
				time = 0x55AAFF;
				seconds = 0x0055AA;
				phrase = Gfx.COLOR_DK_GRAY;
				date = Gfx.COLOR_DK_GRAY;
				iconCalories = 0x0055AA;
				iconSteps = 0x0055AA;
				iconHeart = 0x0055AA;
				iconNotif = 0x0055AA;	
				metricsText = Gfx.COLOR_BLUE;
				iconBtOff = Gfx.COLOR_DK_GRAY;
				iconBtOn = Gfx.COLOR_DK_BLUE;
				batteryOk = 0x0055AA;
				batteryLow = Gfx.COLOR_ORANGE;
				batteryCritical = Gfx.COLOR_DK_RED;
				trackLine = Gfx.COLOR_BLUE;
				trackProgress = 0x00AAAA;
				background = Gfx.COLOR_BLACK;				
				break;
				
			case Twilight:
				time = 0xFFAA55;
				mins = 0xFFAA55;
				seconds = 0xAAAAFF;
				phrase = 0xFFAA00;
				date = 0xFFAAAA;
				iconCalories = 0x0055FF;
				iconSteps = 0x0055FF;
				iconHeart = 0x0055FF;
				iconNotif = 0x0055FF;	
				metricsText = 0xAAAAFF;
				iconBtOff = 0x0055FF;
				iconBtOn = 0x00AAFF;
				batteryOk = 0x0055FF;
				batteryLow = 0xFF5500;
				batteryCritical = 0xFF5555;
				trackLine = 0xFFAAAA;
				trackProgress = 0xFFAA55;
				background = 0x000055;
				break;
				
			case MountainTrails:
				time = 0x55AA00;
				mins = 0xAAAA55;
				seconds = 0x00AA00;
				phrase = 0xAAAAAA;
				date = 0xAAAAAA;
				iconCalories = 0x00AA55;
				iconSteps = 0x55AA55;
				iconHeart = 0x55AA55;
				iconNotif = 0x55AA55;	
				metricsText = 0x00FF00;
				iconBtOff = 0x55AA55;
				iconBtOn = 0x00AAAA;
				batteryOk = 0x55AA55;
				batteryLow = 0xAAAA00;
				batteryCritical = 0xAA5500;
				trackLine = 0xAAAA55;
				trackProgress = 0x55FF55;
				background = 0x555500;
				break;
				
			case CityRunner:
				time = 0xFFFFFF;
				mins = 0x00FFFF;
				seconds = 0xAAAAAA;
				phrase = 0xAAAAAA;
				date = 0xFFAA55;
				iconCalories = 0xFF5500;
				iconSteps = 0x00AA55;
				iconHeart = 0xFF0055;
				iconNotif = 0x55AAFF;	
				metricsText = 0xFFFFFF;
				iconBtOff = 0xAAAAAA;
				iconBtOn = 0x00AAFF;
				batteryOk = 0x00FF00;
				batteryLow = 0xFFFF00;
				batteryCritical = 0xAA5500;
				trackLine = 0xFF5500;
				trackProgress = 0xFFFFFF;
				background = 0x555555;
				break;
				
			case TrackTraining:
				time = 0x00FFFF;
				mins = 0x55FFFF;
				seconds = 0x55AAFF;
				phrase = 0xAAAAAA;
				date = 0x55AAFF;
				iconCalories = 0x55AAFF;
				iconSteps = 0x55AAFF;
				iconHeart = 0x55AAFF;
				iconNotif = 0x55AAFF;	
				metricsText = 0xFFFFFF;
				iconBtOff = 0xAAAAAA;
				iconBtOn = 0x55AAFF;
				batteryOk = 0x55AAFF;
				batteryLow = 0xFFAA00;
				batteryCritical = 0xFF0000;
				trackLine = 0x55AAFF;
				trackProgress = 0x00FFFF;
				background = 0x0000AA;
				break;
				
			case RunningGirl:
				time = 0xFFFFFF;
				mins = 0xFFFFFF;
				seconds = 0xFFFFFF;
				phrase = 0xFFAAFF;
				date = 0xFFAAFF;
				iconCalories = 0xFF55AA;
				iconSteps = 0xFF55AA;
				iconHeart = 0xFF55AA;
				iconNotif = 0xFF55AA;	
				metricsText = 0xFFFFFF;
				iconBtOff = 0xAAAAAA;
				iconBtOn = 0xFF55AA;
				batteryOk = 0xFF55AA;
				batteryLow = 0xFFAA00;
				batteryCritical = 0xFF0000;
				trackLine = 0xFF55AA;
				trackProgress = 0xFFAAFF;
				background = 0xAA0055;
				break;
			
			case ShinnyDay:			
				time = 0x000055;
				mins = 0x000055;
				seconds = 0x000055;
				phrase = 0x0055AA;
				date = 0x0055AA;
				iconCalories = 0xFF5500;
				iconSteps = 0x00AA55;
				iconHeart = 0xFF0055;
				iconNotif = 0x55AAFF;	
				metricsText = 0x000000;
				iconBtOff = 0xAAAAAA;
				iconBtOn = 0x0055FF;
				batteryOk = 0x55AA00;
				batteryLow = Gfx.COLOR_ORANGE;
				batteryCritical = Gfx.COLOR_DK_RED;
				trackLine = 0xFF5500;
				trackProgress = 0x0055AA;
				background = 0xFFFFFF;			
				break;
				
			case SnowRun:			
				time = 0x000000;
				mins = 0x000000;
				seconds = 0x000000;
				phrase = 0x555555;
				date = 0x555555;
				iconCalories = 0x000000;
				iconSteps = 0x000000;
				iconHeart = 0x000000;
				iconNotif = 0x000000;	
				metricsText = 0x000000;
				iconBtOff = 0xAAAAAA;
				iconBtOn = 0x000000;
				batteryOk = 0x000000;
				batteryLow = 0xFF5500;
				batteryCritical = 0xAA0000;
				trackLine = 0x555555;
				trackProgress = 0x000000;
				background = 0xFFFFFF;			
				break;
			
			case ClassicRunner:			
				time = 0xFFFFFF;
				mins = 0xAAAAAA;
				seconds = 0xAAAAAA;
				phrase = 0xAAAAAA;
				date = 0xAAAAAA;
				iconCalories = 0x000000;
				iconSteps = 0xFFFFFF;
				iconHeart = 0xFFFFFF;
				iconNotif = 0xFFFFFF;	
				metricsText = 0xFFFFFF;
				iconBtOff = 0xAAAAAA;
				iconBtOn = 0xFFFFFF;
				batteryOk = 0xFFFFFF;
				batteryLow = 0xFF5500;
				batteryCritical = 0xAA0000;
				trackLine = 0xAAAAAA;
				trackProgress = 0xFFFFFF;
				background = 0x000000;			
				break;
				
			case ClassicRunner:			
				time = 0xFFFFFF;
				mins = 0xAAAAAA;
				seconds = 0xAAAAAA;
				phrase = 0xAAAAAA;
				date = 0xAAAAAA;
				iconCalories = 0x000000;
				iconSteps = 0xFFFFFF;
				iconHeart = 0xFFFFFF;
				iconNotif = 0xFFFFFF;	
				metricsText = 0xFFFFFF;
				iconBtOff = 0xAAAAAA;
				iconBtOn = 0xFFFFFF;
				batteryOk = 0xFFFFFF;
				batteryLow = 0xFF5500;
				batteryCritical = 0xAA0000;
				trackLine = 0xAAAAAA;
				trackProgress = 0xFFFFFF;
				background = 0x000000;			
				break;
				
			case ForestTrain:			
				time = 0xAAAA55;
				mins = 0xAAAA55;
				seconds = 0xAAAA55;
				phrase = 0xAAAA55;
				date = 0xAAAA55;
				iconCalories = 0xFFFF00;
				iconSteps = 0xFFAA00;
				iconHeart = 0xFF55AA;
				iconNotif = 0xAA55FF;	
				metricsText = 0xFFFFFF;
				iconBtOff = 0xAAAAAA;
				iconBtOn = 0x00AAFF;
				batteryOk = 0x00FF00;
				batteryLow = 0xFFFF00;
				batteryCritical = 0xFF5555;
				trackLine = 0xAA5555;
				trackProgress = 0xAAAA55;
				background = 0x005500;			
				break;
			
			case SunsetRun:
				time = 0xFFFF00;
				mins = 0xFFFFAA;
				seconds = 0xFFFFAA;
				phrase = 0xFFFF55;
				date = 0xFFFF55;
				iconCalories = 0xFFFFAA;
				iconSteps = 0xFFFFAA;
				iconHeart = 0xFFFFAA;
				iconNotif = 0xFFFFAA;	
				metricsText = 0xFFFFFF;
				iconBtOff = 0xAAAAAA;
				iconBtOn = 0xAAAAFF;
				batteryOk = 0xAAAA55;
				batteryLow = 0xFFFF00;
				batteryCritical = 0xAA0000;
				trackLine = 0xFFFFAA;
				trackProgress = 0xFFFF00;
				background = 0xFF5500;			
				break;
				
			case StarryNightRun:
				time = 0xFFFFFF;
				mins = 0xAAAAAA;
				seconds = 0xAAAAAA;
				phrase = 0xFFFFFF;
				date = 0xAAAAAA;
				iconCalories = 0xFFFFFF;
				iconSteps = 0xFFFFFF;
				iconHeart = 0xFFFFFF;
				iconNotif = 0xFFFFFF;	
				metricsText = 0xAAAAAA;
				iconBtOff = 0xAAAAAA;
				iconBtOn = 0xFFFFFF;
				batteryOk = 0xFFFFFF;
				batteryLow = 0xFFAA00;
				batteryCritical = 0xFF0055;
				trackLine = 0xAAAAAA;
				trackProgress = 0xFFFFFF;
				background = 0x0000AA;
				break;
			
			case Ultraviolet:
				time = 0xFFFFFF;
				mins = 0xAAAAAA;
				seconds = 0xAAAAAA;
				phrase = 0xFFFFFF;
				date = 0xAAAAAA;
				iconCalories = 0xFFFFFF;
				iconSteps = 0xFFFFFF;
				iconHeart = 0xFFFFFF;
				iconNotif = 0xFFFFFF;	
				metricsText = 0xAAAAAA;
				iconBtOff = 0xAAAAAA;
				iconBtOn = 0xFFFFFF;
				batteryOk = 0xFFFFFF;
				batteryLow = 0xFFAA00;
				batteryCritical = 0xFF0055;
				trackLine = 0xAAAAAA;
				trackProgress = 0xFFFFFF;
				background = 0x5500AA;
				break;
			
			case FinishLine:
				time = 0x55FFFF;
				mins = 0x55FFFF;
				seconds = 0xAAFFFF;
				phrase = 0xAAFFFF;
				date = 0xAAFFFF;
				iconCalories = 0xFFFFFF;
				iconSteps = 0xFFFFFF;
				iconHeart = 0xFFFFFF;
				iconNotif = 0xFFFFFF;	
				metricsText = 0xAAFFFF;
				iconBtOff = 0xAAAAAA;
				iconBtOn = 0xFFFFFF;
				batteryOk = 0xFFFFFF;
				batteryLow = 0xFFAA00;
				batteryCritical = 0xFF0055;
				trackLine = 0xFFFFFF;
				trackProgress = 0x55FFFF;
				background = 0xAA0000;
				break;
		}
	}		
	
}