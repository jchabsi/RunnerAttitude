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
	var background4Runner;
	var batteryText;
	var iconWeather;
	
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
		RunningIsColor3,
		MuddySneakers,
		PurpleSky,
		NorthernLights,
		WatchBacklight,
		FluoTrainingTShirt, 
 		LilacSneakers, 
    	AmberDisplay,
    	FinisherMedal,
	    GoldenTrophy,
	    ElegantGray,
	    ElegantBlue,
	    ElegantRuby,
	    ElegantEmerald,
	    CopperNight,
	    IcyWhite,
	    RetroGreenPhosphor,
	    SunsetOrange,
	    LapisVelvetEvening,
	    UrbanNocturne,
	    YachtClub,
	    Neptune,
	    RoyalGlimmer,
	    Inked,
	    TropicalHeat,
	    HibiscusAura,
	    CelestialBurst,
	    NeonLagoon,
	    SeashellGarnetAfternoon
	}	
	
	function initialize() {		
		
        getTheme();        
	}			

	private function getSettingValue(key) {
		return Application.Properties.getValue(key);
	}
	
	function getTheme() {
		var selectedTheme = getSettingValue("ThemeColor").toNumber();

		// Keep settings numeric values stable after removing GreenDisplay (old value 26).
		if (selectedTheme == 26) {
			selectedTheme = AmberDisplay;
		} else if (selectedTheme >= 27) {
			selectedTheme = selectedTheme - 1;
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
				iconWeather = 0xFFAAAA;
				metricsText = 0xFFFFFF;
				setColor4BTIcon(Gfx.COLOR_DK_GRAY, Gfx.COLOR_BLUE);
				setColor4BatteryIcon(0x55AA00, Gfx.COLOR_ORANGE, Gfx.COLOR_DK_RED, metricsText);
				background = Gfx.COLOR_BLACK;
				setTrackLine( 0x00AA55, 0x00FFAA, background);
				break;
				
		
			case NightRunner:
				setClockColors(0x0055AA, 0x55AAFF, 0x55AAFF);
				phrase = 0xAAAAAA;
				date = 0xAAAAAA;
				setColor4AllIcons(0x0055AA);
				metricsText = Gfx.COLOR_BLUE;
				setColor4BTIcon(Gfx.COLOR_DK_GRAY, 0x0055AA);
				setColor4BatteryIcon(0x0055AA, Gfx.COLOR_ORANGE, Gfx.COLOR_DK_RED, metricsText);
				background = Gfx.COLOR_BLACK;
				setTrackLine(0x0055AA, Gfx.COLOR_BLUE, background);				
				break;
				
			case Twilight:
				setClockColors(0xFF5500, 0xFFAA00, 0xAAAAFF);
				phrase = 0xFFAA00;
				date = 0xFFAA55;
				setColor4AllIcons(0x0055FF);
				metricsText = 0xAAAAFF;
				setColor4BTIcon(0x0055FF, 0x00AAFF);
				setColor4BatteryIcon(0x0055FF, 0xFF5500, 0xFF5555, metricsText);
				background = 0x000055;
				setTrackLine(0xFFAA55, 0xFF5500, background);
				break;
				
			case MountainTrails:
				setClockColors(0x55AA00, 0xAAAA55, 0x00AA00);
				phrase = 0xAAAAAA;
				date = 0xAAAAAA;
				setColor4AllIcons(0x00AA55);
				metricsText = 0x00FF00;
				setColor4BTIcon(0x00AA55, 0x00AAAA);
				setColor4BatteryIcon(0x55AA55, 0xAAAA00, 0xAA5500, metricsText);
				background = 0x555500;
				setTrackLine(0xAAAA55, 0x55FF55, background);
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
				iconWeather = 0xFFFF00;	
				metricsText = 0xFFFFFF;
				setColor4BTIcon(0xAAAAAA, 0x00AAFF);
				setColor4BatteryIcon(0x00FF00, 0xFFFF00, 0xAA5500, metricsText);
				background = 0x555555;
				setTrackLine(0xAAAAAA, 0xFF5500, background);
				break;
				
			case TrackTraining:
				setClockColors(0x00FFFF, 0x00FFFF, 0x55AAFF);
				phrase = 0x55FFFF;
				date = 0x55AAFF;
				setColor4AllIcons(0x55AAFF);
				metricsText = 0xFFFFFF;
				setColor4BTIcon(0xAAAAAA, 0x55AAFF);
				setColor4BatteryIcon(0x55AAFF, 0xFFAA00, 0xFF0000, metricsText);
				background = 0x0000AA;
				setTrackLine(0x55AAFF, 0x00FFFF, background);
				break;
				
			case RunningGirl:
				setClockColors(0xFFFFFF, 0xFFFFFF, 0xFFFFFF);
				phrase = 0xFFAAFF;
				date = 0xFFAAFF;
				setColor4AllIcons(0xFF55AA);
				metricsText = 0xFFFFFF;
				setColor4BTIcon(0xAAAAAA, 0xFF55AA);
				setColor4BatteryIcon(0xFF55AA, 0xFFAA00, 0xFF0000, metricsText);
				background = 0xAA0055;
				setTrackLine(0xFF55AA, 0xFFAAFF, background);
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
				iconWeather = 0x0055FF;	
				metricsText = 0x000000;
				setColor4BTIcon(0xAAAAAA, 0x0055FF);
				setColor4BatteryIcon(0x55AA00, Gfx.COLOR_ORANGE, Gfx.COLOR_DK_RED, metricsText);
				background = 0xFFFFFF;
				setTrackLine(0xFF5500, 0x0055AA, background);	
				break;
				
			case SnowRun:
				setClockColors(0x000000, 0x000000, 0x000000);			
				phrase = 0x555555;
				date = 0x555555;
				setColor4AllIcons(0x000000);
				metricsText = 0x000000;
				setColor4BTIcon(0xAAAAAA, 0x000000);
				setColor4BatteryIcon(0x000000, 0xFF5500, 0xAA0000, 0xAAAAAA);
				background = 0xFFFFFF;
				setTrackLine(0x555555, 0x000000, background);			
				break;
			
			case ClassicRunner:	
				setClockColors(0xFFFFFF, 0xAAAAAA, 0xAAAAAA);		
				phrase = 0xFFFFFF;
				date = 0xAAAAAA;
				setColor4AllIcons(0xFFFFFF);
				metricsText = 0xFFFFFF;
				setColor4BTIcon(0xAAAAAA, 0xFFFFFF);
				setColor4BatteryIcon(0xFFFFFF, 0xFF5500, 0xAA0000, 0xAAAAAA);
				background = 0x000000;
				setTrackLine(0xAAAAAA, 0xFFFFFF, background);						
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
				iconWeather = 0x00AAAA;	
				metricsText = 0xFFFFFF;
				setColor4BTIcon(0xAAAAAA, 0x00AAFF);
				setColor4BatteryIcon(0x00FF00, 0xFFFF00, 0xFF5555, metricsText);
				background = 0x005500;
				setTrackLine(0xAA5555, 0xAAAA55, background);		
				break;
			
			case SunsetRun:
				setClockColors(0xFFFF00, 0xFFFF55, 0xFFFFAA);
				phrase = 0xFFFF55;
				date = 0xFFFF55;
				setColor4AllIcons(0xFFFFAA);
				metricsText = 0xFFFFFF;
				setColor4BTIcon(0xAAAAAA, 0xAAAAFF);
				setColor4BatteryIcon(0xAAAA55, 0xFFFF00, 0xAA0000, metricsText);
				background = 0xFF5555;
				setTrackLine(0xFFFFAA, 0xFFFF00, background);			
				break;
				
			case StarryNightRun:
				setClockColors(0xFFFFFF, 0xAAAAAA, 0xAAAAAA);
				phrase = 0xFFFFFF;
				date = 0xAAAAAA;
				setColor4AllIcons(0xFFFFFF);
				metricsText = 0xFFFFFF;
				setColor4BTIcon(0xAAAAAA, 0xFFFFFF);
				setColor4BatteryIcon(0xFFFFFF, 0xFFAA00, 0xFF0055, 0xAAAAAA);
				background = 0x0000AA;
				setTrackLine(0xAAAAAA, 0xFFFFFF, background);
				break;
			
			case Ultraviolet:
				setClockColors(0xFFFFFF, 0xAAAAAA, 0xAAAAAA);
				phrase = 0xFFFFFF;
				date = 0xAAAAAA;
				setColor4AllIcons(0xFFFFFF);
				metricsText = 0xFFFFFF;
				setColor4BTIcon(0xAAAAAA, 0xFFFFFF);
				setColor4BatteryIcon(0xFFFFFF, 0xFFAA00, 0xFF0055, 0xAAAAAA);
				background = 0x5500AA;
				setTrackLine(0xAA55FF, 0xFFFFFF,background);
				break;
			
			case FinishLine:
				setClockColors(0x55FFFF, 0x55FFFF, 0xAAFFFF);
				phrase = 0xAAFFFF;
				date = 0xAAFFFF;
				setColor4AllIcons(0xFFFFFF);	
				metricsText = 0xAAFFFF;
				setColor4BTIcon(0xAAAAAA, 0xFFFFFF);
				setColor4BatteryIcon(0xFFFFFF, 0xFFAA00, 0xFF0055, 0xAAAAAA);
				background = 0xAA0000;
				setTrackLine(0xFFFFFF, 0x55FFFF, background);
				break;
			
			case QuirkyRunner:
				setClockColors(0x00FFAA, 0xAAFFFF, 0xAAFFFF);
				phrase = 0xAAFFAA;
				date = 0xAAFFAA;
				setColor4AllIcons(0xFFAA55);
				metricsText = 0xFFFFFF;
				setColor4BTIcon(0xAAAAAA, 0xFFAA55);
				setColor4BatteryIcon(0x00FFAA, 0xFFFFAA, 0xFF5555, metricsText);
				background = 0x0055AA;
				setTrackLine( 0xAAFFFF, 0x00FFAA, background);
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
				iconWeather = 0x00AAFF;
				metricsText = 0xFFFFFFA;
				setColor4BTIcon(0xAAAAAA, 0x00AAFF);
				setColor4BatteryIcon(0x55AA00, Gfx.COLOR_ORANGE, Gfx.COLOR_DK_RED, metricsText);
				background = Gfx.COLOR_BLACK;
				setTrackLine( 0xAAAAAA, 0xFFFF00, background);				
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
				iconWeather = 0x00AAFF;
				metricsText = 0xFFFFFFA;
				setColor4BTIcon(0xAAAAAA, 0x00AAFF);
				setColor4BatteryIcon(0x55AA00, Gfx.COLOR_ORANGE, Gfx.COLOR_DK_RED, metricsText);
				background = Gfx.COLOR_BLACK;
				setTrackLine( 0xAAAAAA, 0x00AA00, background);
				break;
				
			case RunningIsColor3:
				setClockColors(0xFFFF00, 0x0055FF, 0xFFFFFF);
				phrase = 0xFF5500;
				date = 0x00AAFF;
				iconCalories = 0xFFFF00;
				iconSteps = 0xFF5500;
				iconHeart = 0xFF0000;
				iconNotif = 0xAA00AA;
				iconfloorsClimbed = 0x00FF00;
				iconWeather = 0x00AAFF;
				metricsText = 0xFFFFFFA;
				setColor4BTIcon(0xAAAAAA, 0x00AAFF);
				setColor4BatteryIcon(0x55AA00, Gfx.COLOR_ORANGE, Gfx.COLOR_DK_RED, metricsText);
				background = Gfx.COLOR_BLACK;
				setTrackLine( 0x0055FF, 0xFFFF00, background);				
				break;
			
			case MuddySneakers:
				setClockColors(0x550000, 0x550000, 0x550000);		
				phrase = 0x550000;
				date = 0x550000;
				setColor4AllIcons(0x550000);
				metricsText = 0x550000;
				setColor4BTIcon(0xAAAAAA, 0x550000);
				setColor4BatteryIcon(0x550000, 0xFF5500, 0xAA0000, 0xAAAAAA);
				background = 0xAAFFFF;
				setTrackLine(0xAAAAAA, 0x550000, background);			
				break;
				
			case PurpleSky:
				setClockColors(0xAAFFFF, 0xAAFFFF, 0xAAFFFF);		
				phrase = 0xFFAAAA;
				date = 0xFFAAAA;
				setColor4AllIcons(0xAAAAFF);
				metricsText = 0xAAFFFF;
				setColor4BTIcon(0xAAAAAA, 0xAAAAFF);
				setColor4BatteryIcon(0xAAAAFF, 0xFFAA00, 0xFF0000, metricsText);
				background = 0x550055;
				setTrackLine(0xAAAAAA, 0xFFAAAA, background);			
				break;
			
			case NorthernLights:
				setClockColors(0x00FFAA, 0xAAFFFF, 0xAAFFFF);		
				phrase = 0xAAFFFF;
				date = 0xFFAAAA;
				setColor4AllIcons(0x00FFAA);
				metricsText = 0xAAFFFF;
				setColor4BTIcon(0x555555, 0x00FFAA);
				setColor4BatteryIcon(0x00FFAA, 0xFFAA00, 0xFF0000, 0xAAAAAA);
				background = 0x000055;
				setTrackLine(0xAAAAAA, 0xFFAAAA, background);		
				break;
				
			case WatchBacklight:
				setClockColors(0x000000, 0x000000, 0x000000);		
				phrase = 0x000000;
				date = 0x000000;
				setColor4AllIcons(0x000000);
				metricsText = 0x000000;
				setColor4BTIcon(0x555555, 0x000000);
				setColor4BatteryIcon(0x000000, 0xFF5500, 0xAA0000, 0xAAAAAA);
				background = 0x00FFAA;
				setTrackLine(0x555555, 0x000000, 0x000000);		
				break;
				
			case FluoTrainingTShirt:
				setClockColors(0x000000, 0x000000, 0x000000);		
				phrase = 0x000000;
				date = 0x000000;
				setColor4AllIcons(0x000000);
				metricsText = 0x000000;
				setColor4BTIcon(0x555555, 0x000000);
				setColor4BatteryIcon(0x000000, 0xFF5500, 0xAA0000, 0xAAAAAA);
				background = 0x00FF00;
				setTrackLine(0x555555, 0x000000, 0x000000);			
				break;
				
 			case LilacSneakers:
 				setClockColors(0x000055, 0x000055, 0x000055);		
				phrase = 0x000055;
				date = 0x000055;
				setColor4AllIcons(0x000055);
				metricsText = 0x000055;
				setColor4BTIcon(0x555555, 0x000055);
				setColor4BatteryIcon(0x000055, 0xFF5500, 0xAA0000, 0xAAAAAA);
				background = 0xAAAAFF;
				setTrackLine(0x555555, 0x000055, 0x000055);			
 				break;
 				
    		case AmberDisplay:
    			setClockColors(0xFFAA00, 0xFFAA00, 0xFFAA00);		
				phrase = 0xFFAA00;
				date = 0xFFAA00;
				setColor4AllIcons(0xFFAA00);
				metricsText = 0xFFAA00;
				setColor4BTIcon(0xAAAAAA, 0xFFAA00);
				setColor4BatteryIcon(0xFFAA00, 0xFF5500, 0xAA0000, 0xAAAAAA);
				background = 0x000000;
				setTrackLine(0xAAAAAA, 0xFFAA00, background);						
				break;

			case FinisherMedal:				
    			setClockColors(0xAAAA55, 0xAAAA55, 0xAAAA55);		
				phrase = 0xAAAA55;
				date = 0xAAAA55;
				setColor4AllIcons(0xAAAA55);
				metricsText = 0xAAAA55;
				setColor4BTIcon(0xAAAAAA, 0xAAAA55);
				setColor4BatteryIcon(0xAAAA55, 0xFF5500, 0xAA0000, 0xAAAAAA);
				background = 0x000055;
				setTrackLine(0xAAAAAA, 0xAAAA55, background);						
				break;
				
			case GoldenTrophy:				
    			setClockColors(0x000055, 0x000055, 0x000055);		
				phrase = 0x000055;
				date = 0x000055;
				setColor4AllIcons(0x000055);
				metricsText = 0x000055;
				setColor4BTIcon(0xAAAAAA, 0x000055);
				setColor4BatteryIcon(0x000055, 0xFF5500, 0xAA0000, 0x0055FF);
				background = 0xAAAA55;
				setTrackLine(0x0055FF, 0x000055, background);
				break;

			case ElegantGray:
				setClockColors(0xE8E6E1, 0xD6D3CD, 0xA8A59F);
				phrase = 0xC9C4BC;
				date = 0x8E978F;
				iconCalories = 0xC49B6A;
				iconSteps = 0x8FA39A;
				iconHeart = 0xC67D7D;
				iconNotif = 0x9DA7B5;
				iconfloorsClimbed = 0x8C8578;
				iconWeather = 0xB7A98E;
				metricsText = 0xD1CEC8;
				setColor4BTIcon(0x4D5056, 0xA6B3C3);
				setColor4BatteryIcon(0x9AB59A, 0xC9A46A, 0xB56E6E, metricsText);
				background = 0x1A1D20;
				setTrackLine(0x61666D, 0xA9B0B8, background);
				break;

			case ElegantBlue:
				setClockColors(0xDFE8F7, 0xBFCFEA, 0x8CA3C8);
				phrase = 0xB6C7E1;
				date = 0x7F93B2;
				iconCalories = 0xB8A06A;
				iconSteps = 0x7FA9BF;
				iconHeart = 0xC8848F;
				iconNotif = 0x99AAC8;
				iconfloorsClimbed = 0x6F819D;
				iconWeather = 0x97B7D9;
				metricsText = 0xCCD7E8;
				setColor4BTIcon(0x3D4B63, 0x8AA9D8);
				setColor4BatteryIcon(0x86AE97, 0xC3A36E, 0xB87272, metricsText);
				background = 0x060B14;
				setTrackLine(0x425675, 0x94AED3, background);
				break;

			case ElegantRuby:
				setClockColors(0xC43B5E, 0xE9A1B9, 0xD06B8A);
				phrase = 0xDB7A99;
				date = 0xBE5B77;
				iconCalories = 0xD5A05E;
				iconSteps = 0xA9859E;
				iconHeart = 0xE1557D;
				iconNotif = 0x9C96BE;
				iconfloorsClimbed = 0x966273;
				iconWeather = 0xC28AA8;
				metricsText = 0xE6B9C9;
				setColor4BTIcon(0x653D4E, 0xD7789E);
				setColor4BatteryIcon(0x8FAC92, 0xD3A15C, 0xD6526E, metricsText);
				background = 0x14060C;
				setTrackLine(0x7C324D, 0xD87A9D, background);
				break;

			case ElegantEmerald:
				setClockColors(0xDDF3E8, 0xBDE3CF, 0x87BEA4);
				phrase = 0xA8D5BF;
				date = 0x6E9F88;
				iconCalories = 0xC6A468;
				iconSteps = 0x6DB59B;
				iconHeart = 0xC17D84;
				iconNotif = 0x8FB6C3;
				iconfloorsClimbed = 0x6F8D80;
				iconWeather = 0x8FC9B7;
				metricsText = 0xC6E6D8;
				setColor4BTIcon(0x36584C, 0x7FC9AF);
				setColor4BatteryIcon(0x84B495, 0xC8A56D, 0xB86D73, metricsText);
				background = 0x04110C;
				setTrackLine(0x3D6B5B, 0x8ED4BA, background);
				break;

			case CopperNight:
				setClockColors(0xF0D7C2, 0xD6B199, 0x9F8777);
				phrase = 0xC89A73;
				date = 0x8899A3;
				iconCalories = 0xD4914E;
				iconSteps = 0x7AA5A1;
				iconHeart = 0xC97C74;
				iconNotif = 0x93A9B9;
				iconfloorsClimbed = 0x8C6F5E;
				iconWeather = 0xA6B6BF;
				metricsText = 0xD8C2B4;
				setColor4BTIcon(0x4A5157, 0x8FB4C8);
				setColor4BatteryIcon(0x8FB08E, 0xCC9B58, 0xBA6C64, metricsText);
				background = 0x0C0E11;
				setTrackLine(0x5B4B43, 0xC58A56, background);
				break;

			case IcyWhite:
				setClockColors(0x16283A, 0x35526A, 0x5D7D98);
				phrase = 0x4C708C;
				date = 0x5D7386;
				iconCalories = 0xC88449;
				iconSteps = 0x4F95AF;
				iconHeart = 0xC46E79;
				iconNotif = 0x5F7FA2;
				iconfloorsClimbed = 0x748593;
				iconWeather = 0x6CA7C6;
				metricsText = 0x24384A;
				setColor4BTIcon(0xAEBBC6, 0x4B81AC);
				setColor4BatteryIcon(0x5E9472, 0xC08F4E, 0xB76565, metricsText);
				background = 0xF7FBFF;
				setTrackLine(0xB9CDDC, 0x70B2D0, background);
				break;

			case RetroGreenPhosphor:
				setClockColors(0xC9FFB5, 0x9EF58B, 0x69D96B);
				phrase = 0x92F08D;
				date = 0x75CC73;
				iconCalories = 0xC8DD6A;
				iconSteps = 0x81EB89;
				iconHeart = 0x95D384;
				iconNotif = 0x9CE3A9;
				iconfloorsClimbed = 0x78BC72;
				iconWeather = 0xA5EE9F;
				metricsText = 0xB8FFAB;
				setColor4BTIcon(0x365038, 0x99FF91);
				setColor4BatteryIcon(0x7DE574, 0xC1D660, 0xB98A5D, metricsText);
				background = 0x010601;
				setTrackLine(0x214821, 0x99FF91, background);
				break;

			case SunsetOrange:
				setClockColors(0xFFE1B9, 0xFFBB74, 0xF18A4E);
				phrase = 0xFFAA63;
				date = 0xD29379;
				iconCalories = 0xFFCA5E;
				iconSteps = 0xE18B52;
				iconHeart = 0xDF7077;
				iconNotif = 0xBD92B5;
				iconfloorsClimbed = 0xA5684C;
				iconWeather = 0xFFA06A;
				metricsText = 0xFFD0AE;
				setColor4BTIcon(0x674E4B, 0xFFA46E);
				setColor4BatteryIcon(0x98B583, 0xD9A358, 0xCB666A, metricsText);
				background = 0x160802;
				setTrackLine(0x7A4333, 0xFF9C52, background);
				break;

			case LapisVelvetEvening:
				setClockColors(0xE2D7C8, 0x9EB0D4, 0xB18ACF);
				phrase = 0x213885;
				date = 0x893172;
				iconCalories = 0xC6A06A;
				iconSteps = 0x7FA3C6;
				iconHeart = 0xC97C91;
				iconNotif = 0xA7A0CF;
				iconfloorsClimbed = 0x746A8E;
				iconWeather = 0x9DB7D8;
				metricsText = 0xCFCBDE;
				setColor4BTIcon(0x4C4A66, 0x9CB2D9);
				setColor4BatteryIcon(0x84AA95, 0xC9A56B, 0xB8717F, metricsText);
				background = 0x0A0C1A;
				setTrackLine(0x3A3B61, 0x9B8FC8, background);
				break;

			case UrbanNocturne:
				setClockColors(0xD7E0E5, 0xA9B6BF, 0x7B8992);
				phrase = 0xB8C3C8;
				date = 0x8A959D;
				iconCalories = 0xAFC16D;
				iconSteps = 0x8FA1AC;
				iconHeart = 0xC6868A;
				iconNotif = 0x95A8B3;
				iconfloorsClimbed = 0x6F7A82;
				iconWeather = 0x9DB4BE;
				metricsText = 0xCAD4D9;
				setColor4BTIcon(0x4F5861, 0x9FB9C8);
				setColor4BatteryIcon(0x89A88D, 0xBFAB63, 0xB47777, metricsText);
				background = 0x06080B;
				setTrackLine(0x2F343A, 0xA4B5BE, background);
				break;

			case YachtClub:
				setClockColors(0xD8D1C3, 0x7F9FC0, 0x8A5442);
				phrase = 0x5D7E9F;
				date = 0x9B6652;
				iconCalories = 0xC1A06F;
				iconSteps = 0x7EA6C1;
				iconHeart = 0xC7898C;
				iconNotif = 0x97AABD;
				iconfloorsClimbed = 0x6E7C89;
				iconWeather = 0x9DB8CC;
				metricsText = 0xCDD5DC;
				setColor4BTIcon(0x4A5562, 0x93B2CE);
				setColor4BatteryIcon(0x88A790, 0xC0A464, 0xB97777, metricsText);
				background = 0x081119;
				setTrackLine(0x30485A, 0x8FAFC9, background);
				break;

			case Neptune:
				setClockColors(0xD6EEFA, 0xA4D3EB, 0x72AFCF);
				phrase = 0xA3D0E4;
				date = 0x77A5BC;
				iconCalories = 0xCFAB6A;
				iconSteps = 0x65B1C9;
				iconHeart = 0xC47D8A;
				iconNotif = 0x88B6CB;
				iconfloorsClimbed = 0x5D8CA0;
				iconWeather = 0x8ED0E6;
				metricsText = 0xC0E1F0;
				setColor4BTIcon(0x3E6172, 0x7CC7DF);
				setColor4BatteryIcon(0x80AE93, 0xC9A360, 0xBA7075, metricsText);
				background = 0x031018;
				setTrackLine(0x245B76, 0x7FCFEB, background);
				break;

			case RoyalGlimmer:
				setClockColors(0xF0E3FF, 0xC9A6F4, 0x7FA8FF);
				phrase = 0xB894E8;
				date = 0xD6B37A;
				iconCalories = 0xD1A266;
				iconSteps = 0x8FA2D0;
				iconHeart = 0xD0849D;
				iconNotif = 0xA7A2D7;
				iconfloorsClimbed = 0x7B699E;
				iconWeather = 0xB4C0E4;
				metricsText = 0xD7C9EE;
				setColor4BTIcon(0x5D4E7A, 0xA8B7E3);
				setColor4BatteryIcon(0x8CA993, 0xCEA462, 0xC07482, metricsText);
				background = 0x10081C;
				setTrackLine(0x4F3D73, 0xAE93E2, background);
				break;

			case Inked:
				setClockColors(0xE9EEF0, 0xC0CCD1, 0x8E9FA7);
				phrase = 0xC8D2D6;
				date = 0x8D9AA0;
				iconCalories = 0xC3A06A;
				iconSteps = 0x67A3A7;
				iconHeart = 0xC58286;
				iconNotif = 0x91A5AF;
				iconfloorsClimbed = 0x6E7D84;
				iconWeather = 0x7AB9BE;
				metricsText = 0xD7DFE2;
				setColor4BTIcon(0x4B5B62, 0x79C5C9);
				setColor4BatteryIcon(0x88A990, 0xC7A361, 0xB87575, metricsText);
				background = 0x070A0D;
				setTrackLine(0x333C41, 0x6FC6CB, background);
				break;

			case TropicalHeat:
				setClockColors(0x0B3F4B, 0x1A5D8F, 0xA4432A);
				phrase = 0xFCEFC3;
				date = 0xEB4203;
				iconCalories = 0xFF6A00;
				iconSteps = 0x00A87E;
				iconHeart = 0xFF2E63;
				iconNotif = 0x0070D1;
				iconfloorsClimbed = 0x00B17D;
				iconWeather = 0x00A6FF;
				metricsText = 0x00424D;
				setColor4BTIcon(0x49A8B3, 0x006DAA);
				setColor4BatteryIcon(0x00A455, 0xF2A100, 0xE64545, metricsText);
				background = 0x00CEC8;
				setTrackLine(0x2A9D8F, 0xFF6B35, background);
				break;

			case HibiscusAura:
				setClockColors(0x2D1135, 0x4A1E59, 0xB12657);
				phrase = 0x5B2570;
				date = 0x713985;
				iconCalories = 0xFF8A3D;
				iconSteps = 0x2D7BA3;
				iconHeart = 0xB12657;
				iconNotif = 0x3A54A3;
				iconfloorsClimbed = 0x7C4B45;
				iconWeather = 0x5A3FC0;
				metricsText = 0x3B1648;
				setColor4BTIcon(0xD090C4, 0x523EC0);
				setColor4BatteryIcon(0x3E9F64, 0xE3A33A, 0xC53F5B, metricsText);
				background = 0xFF5FA2;
				setTrackLine(0xAA2D6F, 0x4B2EC0, background);
				break;

			case CelestialBurst:
				setClockColors(0x1B2F86, 0x2748B0, 0x3764D9);
				phrase = 0x2E56C4;
				date = 0x4A70C7;
				iconCalories = 0xFFB238;
				iconSteps = 0x00A2D1;
				iconHeart = 0xDB425F;
				iconNotif = 0x3569D8;
				iconfloorsClimbed = 0x5E5F7A;
				iconWeather = 0x2C89FF;
				metricsText = 0x162A78;
				setColor4BTIcon(0x95B9FF, 0x2B7BFF);
				setColor4BatteryIcon(0x27A45F, 0xE0A32F, 0xCF3E4D, metricsText);
				background = 0xFFD32A;
				setTrackLine(0xFF9C00, 0x1E4BCE, background);
				break;

			case NeonLagoon:
				setClockColors(0x0F3C3A, 0x17605D, 0x2B8582);
				phrase = 0x1C6E6B;
				date = 0x3C8A87;
				iconCalories = 0xFF7A33;
				iconSteps = 0x0FAF90;
				iconHeart = 0xD73D68;
				iconNotif = 0x2A73B4;
				iconfloorsClimbed = 0x4E7E6C;
				iconWeather = 0x00A8D4;
				metricsText = 0x124845;
				setColor4BTIcon(0x8EF0DF, 0x2B8FD6);
				setColor4BatteryIcon(0x2EA766, 0xE59E31, 0xCC4360, metricsText);
				background = 0x00FFC8;
				setTrackLine(0x00BFA0, 0x007BEA, background);
				break;

			case SeashellGarnetAfternoon:
				setClockColors(0x972121, 0xFF7237, 0x972121);
				phrase = 0xe6dcdc;
				date = 0xFF7237;
				iconCalories = 0xFFC9C1;
				iconSteps = 0xFFC9C1;
				iconHeart = 0xFFC9C1;
				iconNotif = 0xFFC9C1;
				iconfloorsClimbed = 0xFFC9C1;
				iconWeather = 0xFFC9C1;
				metricsText = 0xe6dcdc;
				setColor4BTIcon(0x972121, 0xFF7237);
				setColor4BatteryIcon(0x972121, 0xFF7237, 0x972121, 0xFFC9C1);
				background = 0x6B5757;
				setTrackLine(0xE2E2E2, 0xFFC9C1, background);
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
		iconWeather = color;
	}	
	private function setColor4BTIcon(off, on) {
		iconBtOff = off;
		iconBtOn = on;
	}
	private function setColor4BatteryIcon(ok, low, critical, text) {
		batteryOk = ok;
		batteryLow = low;
		batteryCritical = critical;
		batteryText = text;
	}
	private function setTrackLine(tl, tp, t4r) {
		trackLine = tl;
		trackProgress = tp;
		background4Runner = t4r;
	}
	
}