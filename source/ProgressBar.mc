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
	
	//FOR TESTING
	var test;	

    function initialize() {
    	runnerGirl = WatchUi.loadResource(Rez.Drawables.RunnerGirl);
    	runnerBoy = WatchUi.loadResource(Rez.Drawables.RunnerBoy);
    	trophyIcon = WatchUi.loadResource(Rez.Drawables.TrophyIcon);
    	
        var dictionary = {
            :identifier => "ProgressBar"
        };

        Drawable.initialize(dictionary);
                        
        //FOR TESTING
        test = 3200;
    }

    function draw(dc) {
        
        var width = dc.getWidth();
        var height = dc.getHeight();
        
        //FOR PROD
        var steps = Mon.getInfo().steps;
        //FOR TEST
        steps = test;
        
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
						    	    	 
		    	dc.drawBitmap(stepsx - 5, y - 30, genderBitmap);
		    	
		    	//FOR TESTING		    	
		    	//test = test + 200;
		 
		    } 
		    		
    	}
    	else {
	    	dc.drawBitmap((width / 2) - 16, (height / 6.3) - 34, trophyIcon);
	    	dc.setColor(gTheme.trackProgress, Graphics.COLOR_TRANSPARENT);
	    	dc.fillRectangle(x, y, xw, yh);			   
		}	    
    	dc.clear();
    	
    }
    
    static function setRunnerAvatar() {
    	ProgressBar.runnerAvatar = Application.getApp().getProperty("RunnerAvatar").toNumber();
    }

}