using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;
using Toybox.Math;
using Toybox.ActivityMonitor as Mon;
using Toybox.UserProfile;

class ProgressBar extends WatchUi.Drawable {

	static var runnerAvatar;
	
	hidden enum {
		genderSettings = 0,
		avatarRunnerGirl,
		avatarRunnerBoy,
		avatarRunnerDisabled
	}
	
	hidden var runnerGirl;
	hidden var runnerBoy;
	hidden var trophyIcon;
	hidden var height;
	hidden var width;
	
	//FOR TESTING
	//var test;	

    function initialize() {
    	runnerGirl = WatchUi.loadResource(Rez.Drawables.RunnerGirl);
    	runnerBoy = WatchUi.loadResource(Rez.Drawables.RunnerBoy);
    	trophyIcon = WatchUi.loadResource(Rez.Drawables.TrophyIcon);
    	
        var dictionary = {
            :identifier => "ProgressBar"
        };

        Drawable.initialize(dictionary);
                        
        //FOR TESTING
        //test = 1200;
        //test = 3200;
        //test = 10000;
    }

    function draw(dc) {
        
        width = dc.getWidth();
        height = dc.getHeight();
        
        //FOR PROD
        var steps = Mon.getInfo().steps;
        //FOR TEST
        //steps = test;
        
    	var goal = Mon.getInfo().stepGoal;
        
        var x = (width / 4.6).toLong();
        var y = (height / 6.4).toLong();
       
        var xw = ((width / 1.26) - x).toLong();
        var yh = ((height / 6) - y).toLong();
        
        if (steps < goal) {	        
	                
	        dc.setColor(gTheme.trackLine, Graphics.COLOR_TRANSPARENT);
	    	dc.fillRectangle(x, y, xw, yh);	    	
	    	
	    	// If goal --> xw 
	    	// steps -->  ?	    	
	    	var stepsx = x + ((steps * xw) / goal);
	    	var stepsxw = stepsx - x;  
	    	dc.setColor(gTheme.trackProgress, Graphics.COLOR_TRANSPARENT);
	    	
	    	dc.fillRectangle(x, y, stepsxw, yh);	
	    	
	    	if (ProgressBar.runnerAvatar != avatarRunnerDisabled) {
	    		drawAvatar(stepsx, y, dc);		    	
		    	
		    	//FOR TESTING		    	
		    	//test = test + 200;		 
		    } 
		    		
    	}
    	else {
    		drawTrophy(dc);
				
	    	dc.setColor(gTheme.trackProgress, Graphics.COLOR_TRANSPARENT);
	    	dc.fillRectangle(x, y, xw, yh);			   
		}	    
    	dc.clear();
    	
    }
    
    private function drawAvatar(stepsx, y, dc) {
		var xAvatar;
    	var yAvatar; 
    	var xwAvatar;
    	var ywAvatar;
    	
    	if (height < 360){
    		xAvatar = stepsx - 5;
    		yAvatar = y - 30;
    		xwAvatar = 20; 
    		ywAvatar = 31;
    	} else {
    		xAvatar = stepsx - 12;
    		yAvatar = y - 50;
    		xwAvatar = 33; 
    		ywAvatar = 51;
    	}
    	var genderBitmap;
	    	
    	if (ProgressBar.runnerAvatar == genderSettings) {
	    	var profile = UserProfile.getProfile();
	    	genderBitmap = runnerGirl;
	    	if (profile.gender == UserProfile.GENDER_MALE) {
	    		genderBitmap = runnerBoy;
	    	}
	    }
	    else if (ProgressBar.runnerAvatar == avatarRunnerGirl) {
	    	genderBitmap = runnerGirl;
		}
		else {
			genderBitmap = runnerBoy;
		}
						
		if(gTheme.background4Runner != gTheme.background) {				
			dc.setColor(gTheme.background4Runner, Graphics.COLOR_TRANSPARENT);
			dc.fillRoundedRectangle(xAvatar - 1, yAvatar - 1, xwAvatar, ywAvatar, 5);
		}
    	
    	dc.drawBitmap(xAvatar, yAvatar, genderBitmap);

    }
    
    private function drawTrophy(dc) {
    	var xTrophy;
		var yTrophy; 
		var xwTrophy;
		var ywTrophy;
		
		if (height < 360){
    		xTrophy = (width / 2) - 16;
    		yTrophy = (height / 6.3) - 34;
    		xwTrophy = 34; 
    		ywTrophy = 34;
    	} else {
    		xTrophy = (width / 2) - 26;
    		yTrophy = (height / 6.3) - 50;
    		xwTrophy = 53; 
    		ywTrophy = 50;
    	}
		
		dc.setColor(gTheme.background4Runner, Graphics.COLOR_TRANSPARENT);
		dc.fillRoundedRectangle(xTrophy - 1, yTrophy - 1, xwTrophy, ywTrophy, 5);
    	dc.drawBitmap(xTrophy, yTrophy, trophyIcon);
    }
    static function setRunnerAvatar() {
    	ProgressBar.runnerAvatar = Application.getApp().getProperty("RunnerAvatar").toNumber();
    }

}