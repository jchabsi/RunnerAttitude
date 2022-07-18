using Toybox.Application;
using Toybox.WatchUi;

var gTheme = 0;
var gPhrase = 0;

class RunnerAttitudeApp extends Application.AppBase {
	var runnerAttitudeView;
	hidden var sleep = false;
	

    function initialize() {
    
    	gTheme = new Theme();
    	gPhrase = new Phrases();   	
    	
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
    	runnerAttitudeView = new RunnerAttitudeView();
		onSettingsChanged(); 
		return [runnerAttitudeView];        
    }

    // New app settings have been received so trigger a UI update
    function onSettingsChanged() {
    	
        gTheme.getTheme();        
        gPhrase.getPhrasesList();
        gPhrase.selectPhrase(); 
        gPhrase.getPhraseRenewalTime(); 
        gPhrase.getPhraseSpeed();
        LaHora.getSecondsConfig();
        LaHora.getLeadingZeroConfig();
        ProgressBar.getRunnerAvatar();  
        runnerAttitudeView.getDistanceConfig();
        runnerAttitudeView.getAltitudeConfig(); 
        runnerAttitudeView.getPhraseOnSleepMode();
        Battery.getBatteryPercentage();
        runnerAttitudeView.getDateConfig();
        //runnerAttitudeView.getTemperatureUnits();
        WatchUi.requestUpdate();
    }
    
    function isSleeping() {
    	return sleep;
    }
    function setSleep(val){
    	sleep = val;
    }
     

}