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
	//FOR TESTING
	//var test;	

    function initialize() {
    	runnerGirl = WatchUi.loadResource(Rez.Drawables.RunnerGirl);
    	runnerBoy = WatchUi.loadResource(Rez.Drawables.RunnerBoy);
        var dictionary = {
            :identifier => "ProgressBar"
        };

        Drawable.initialize(dictionary);
        
        //FOR TESTING
        //test = 100;
    }

    function draw(dc) {
        // Set the background color then call to clear the screen
        var width = dc.getWidth();
        var height = dc.getHeight();
        
        //var x = (width / 4.9).toLong();
        var x = (width / 4.6).toLong();
        var y = (height / 6.3).toLong();
        //var xw = ((width / 1.20) - x).toLong();
        var xw = ((width / 1.26) - x).toLong();
        var yh = ((height / 6) - y).toLong();
                
        dc.setColor(gTheme.trackLine, Graphics.COLOR_TRANSPARENT);
    	dc.fillRectangle(x, y, xw, yh);
    	
    	var steps = Mon.getInfo().steps;
    	var goal = Mon.getInfo().stepGoal;
    	
    	// If goal --> xw 
    	// steps -->  ?
    	
    	var stepsx = x + ((steps * xw) / goal);
    	var stepsxw = stepsx - x;  
    	dc.setColor(gTheme.trackProgress, Graphics.COLOR_TRANSPARENT);
    	
    	//For PROD
    	dc.fillRectangle(x, y, stepsxw, yh);
    	
    	//FOR TESTING
    	//dc.fillRectangle(x, y, stepsxw + test, yh);
    	
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
					    	    	 
	    	
	    	//FOR PROD
	    	dc.drawBitmap(stepsx - 5, y - 30, genderBitmap);
	    	
	    	//FOR TESTING
	    	//dc.drawBitmap(stepsx - 10 + test, y - 30, genderBitmap);
	    	//test = test + 3;
    	}
    	dc.clear();
    	
    }
    
    static function setRunnerAvatar() {
    	ProgressBar.runnerAvatar = Application.getApp().getProperty("RunnerAvatar").toNumber();
    }

}