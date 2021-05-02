using Toybox.WatchUi;
using Toybox.Application;
using Toybox.System;
using Toybox.Lang;
using Toybox.Math;
using Toybox.Graphics;
using Toybox.Timer;
using Toybox.Time;
using Toybox.Time.Gregorian;


class Phrases {
	
	hidden const sp = " ";
	hidden const sl = " - ";
	hidden const numberOfPhrases = 26;
	hidden const numberOfWords = 23;
	private var rndMax = 0;
	hidden var phrasesList;		
	hidden var scrolledPhrase;
	hidden var phraseTime = 300;
	hidden enum {
		twinkling,
		scrolled,
		fixed,
		personalized
	}
	var phraseType;
	hidden var twinklingPhrase = new[15];
	hidden var twinklingCount;
	hidden var groupCount;
	hidden var timeBase;
	
	
	function initialize() {		
		
        setPhrasesList();   
        setPhraseRenewalTime(); 
        timeBase = new Time.Moment(Time.now().value()); 
        
	}		
	
	function setPhrasesList() {
		phraseType = Application.getApp().getProperty("MotivationalPhrase").toNumber();
		phrasesList = 0;		
    	
    	if (phraseType == scrolled) {  	
    		phrasesList = new [numberOfPhrases];
    		rndMax = numberOfPhrases;
	    	phrasesList[0] = sp + WatchUi.loadResource(Rez.Strings.Phrase1) + sl;
	    	phrasesList[1] = sp + WatchUi.loadResource(Rez.Strings.Phrase2) + sl;
	    	phrasesList[2] = sp + WatchUi.loadResource(Rez.Strings.Phrase3) + sl;
	    	phrasesList[3] = sp + WatchUi.loadResource(Rez.Strings.Phrase4) + sl;
	    	phrasesList[4] = sp + WatchUi.loadResource(Rez.Strings.Phrase5) + sl;
	    	phrasesList[5] = sp + WatchUi.loadResource(Rez.Strings.Phrase6) + sl;
	    	phrasesList[6] = sp + WatchUi.loadResource(Rez.Strings.Phrase7) + sl;
	    	phrasesList[7] = sp + WatchUi.loadResource(Rez.Strings.Phrase8) + sl;
	    	phrasesList[8] = sp + WatchUi.loadResource(Rez.Strings.Phrase9) + sl;
	    	phrasesList[9] = sp + WatchUi.loadResource(Rez.Strings.Phrase10) + sl;
	    	phrasesList[10] = sp + WatchUi.loadResource(Rez.Strings.Phrase11) + sl;
	    	phrasesList[11] = sp + WatchUi.loadResource(Rez.Strings.Phrase12) + sl;
	    	phrasesList[12] = sp + WatchUi.loadResource(Rez.Strings.Phrase13) + sl;
	    	phrasesList[13] = sp + WatchUi.loadResource(Rez.Strings.Phrase14) + sl;
	    	phrasesList[14] = sp + WatchUi.loadResource(Rez.Strings.Phrase15) + sl;
	    	phrasesList[15] = sp + WatchUi.loadResource(Rez.Strings.Phrase16) + sl;
	    	phrasesList[16] = sp + WatchUi.loadResource(Rez.Strings.Phrase17) + sl;
	    	phrasesList[17] = sp + WatchUi.loadResource(Rez.Strings.Phrase18) + sl;
	    	phrasesList[18] = sp + WatchUi.loadResource(Rez.Strings.Phrase19) + sl;
	    	phrasesList[19] = sp + WatchUi.loadResource(Rez.Strings.Phrase20) + sl;
	    	phrasesList[20] = sp + WatchUi.loadResource(Rez.Strings.Phrase21) + sl;
	    	phrasesList[21] = sp + WatchUi.loadResource(Rez.Strings.Phrase22) + sl;
	    	phrasesList[22] = sp + WatchUi.loadResource(Rez.Strings.Phrase23) + sl;
	    	phrasesList[23] = sp + WatchUi.loadResource(Rez.Strings.Phrase24) + sl;
	    	phrasesList[24] = sp + WatchUi.loadResource(Rez.Strings.Phrase25) + sl;
	    	phrasesList[25] = sp + WatchUi.loadResource(Rez.Strings.Phrase26) + sl;
	    }
	    else if (phraseType == twinkling) {
	    	phrasesList = new [numberOfPhrases];
    		rndMax = numberOfPhrases;
	    	phrasesList[0] = WatchUi.loadResource(Rez.Strings.Phrase1);
	    	phrasesList[1] = WatchUi.loadResource(Rez.Strings.Phrase2);
	    	phrasesList[2] = WatchUi.loadResource(Rez.Strings.Phrase3);
	    	phrasesList[3] = WatchUi.loadResource(Rez.Strings.Phrase4);
	    	phrasesList[4] = WatchUi.loadResource(Rez.Strings.Phrase5);
	    	phrasesList[5] = WatchUi.loadResource(Rez.Strings.Phrase6);
	    	phrasesList[6] = WatchUi.loadResource(Rez.Strings.Phrase7);
	    	phrasesList[7] = WatchUi.loadResource(Rez.Strings.Phrase8);
	    	phrasesList[8] = WatchUi.loadResource(Rez.Strings.Phrase9);
	    	phrasesList[9] = WatchUi.loadResource(Rez.Strings.Phrase10);
	    	phrasesList[10] = WatchUi.loadResource(Rez.Strings.Phrase11);
	    	phrasesList[11] = WatchUi.loadResource(Rez.Strings.Phrase12);
	    	phrasesList[12] = WatchUi.loadResource(Rez.Strings.Phrase13);
	    	phrasesList[13] = WatchUi.loadResource(Rez.Strings.Phrase14);
	    	phrasesList[14] = WatchUi.loadResource(Rez.Strings.Phrase15);
	    	phrasesList[15] = WatchUi.loadResource(Rez.Strings.Phrase16);
	    	phrasesList[16] = WatchUi.loadResource(Rez.Strings.Phrase17);
	    	phrasesList[17] = WatchUi.loadResource(Rez.Strings.Phrase18);
	    	phrasesList[18] = WatchUi.loadResource(Rez.Strings.Phrase19);
	    	phrasesList[19] = WatchUi.loadResource(Rez.Strings.Phrase20);
	    	phrasesList[20] = WatchUi.loadResource(Rez.Strings.Phrase21);
	    	phrasesList[21] = WatchUi.loadResource(Rez.Strings.Phrase22);
	    	phrasesList[22] = WatchUi.loadResource(Rez.Strings.Phrase23);
	    	phrasesList[23] = WatchUi.loadResource(Rez.Strings.Phrase24);
	    	phrasesList[24] = WatchUi.loadResource(Rez.Strings.Phrase25);
	    	phrasesList[25] = WatchUi.loadResource(Rez.Strings.Phrase26);
	    }
	    else if (phraseType == fixed) {
	    	phrasesList = new [numberOfWords];
	    	rndMax = numberOfWords;
	    	phrasesList[0] = WatchUi.loadResource(Rez.Strings.Fixed1);
	    	phrasesList[1] = WatchUi.loadResource(Rez.Strings.Fixed2);
	    	phrasesList[2] = WatchUi.loadResource(Rez.Strings.Fixed3);
	    	phrasesList[3] = WatchUi.loadResource(Rez.Strings.Fixed4);
	    	phrasesList[4] = WatchUi.loadResource(Rez.Strings.Fixed5);
	    	phrasesList[5] = WatchUi.loadResource(Rez.Strings.Fixed6);
	    	phrasesList[6] = WatchUi.loadResource(Rez.Strings.Fixed7);
	    	phrasesList[7] = WatchUi.loadResource(Rez.Strings.Fixed8);
	    	phrasesList[8] = WatchUi.loadResource(Rez.Strings.Fixed9);
	    	phrasesList[9] = WatchUi.loadResource(Rez.Strings.Fixed10);
	    	phrasesList[10] = WatchUi.loadResource(Rez.Strings.Fixed11);
	    	phrasesList[11] = WatchUi.loadResource(Rez.Strings.Fixed12);
	    	phrasesList[12] = WatchUi.loadResource(Rez.Strings.Fixed13);
	    	phrasesList[13] = WatchUi.loadResource(Rez.Strings.Fixed14);
	    	phrasesList[14] = WatchUi.loadResource(Rez.Strings.Fixed15);
	    	phrasesList[15] = WatchUi.loadResource(Rez.Strings.Fixed16);
	    	phrasesList[16] = WatchUi.loadResource(Rez.Strings.Fixed17);
	    	phrasesList[17] = WatchUi.loadResource(Rez.Strings.Fixed18);
	    	phrasesList[18] = WatchUi.loadResource(Rez.Strings.Fixed19);
	    	phrasesList[19] = WatchUi.loadResource(Rez.Strings.Fixed20);
	    	phrasesList[20] = WatchUi.loadResource(Rez.Strings.Fixed21);
	    	phrasesList[21] = WatchUi.loadResource(Rez.Strings.Fixed22);
	    	phrasesList[22] = WatchUi.loadResource(Rez.Strings.Fixed23);
	    }
	    else {
	    	phrasesList = new [1];
	    	rndMax = 1;
	    	phrasesList[0] = Application.getApp().getProperty("CustomText");
	    	
	    	if (phrasesList[0].length() == 0) {
	    		phrasesList[0] = WatchUi.loadResource(Rez.Strings.InsertYourPhrase);
	    	} 	
	    	
	    }
	}
		
	function selectPhrase() {
		var rndInd;
		//If we have a list we choose a random phrase,
    	if (rndMax > 1) {
	    	Math.srand(System.getTimer());
			rndInd = Math.rand() % (rndMax - 1);
			scrolledPhrase = phrasesList[rndInd];
		} else {
			rndInd = 0;
			scrolledPhrase = phrasesList[rndInd];
			if (scrolledPhrase.length() < 16) {
				phraseType = fixed;  
			} else {
				phraseType = twinkling;
			}			
		}			
		
		if (phraseType == fixed) {
			var tempPhrase = scrolledPhrase;
			var lng = scrolledPhrase.length();
			lng = (20 - lng) / 2;			
			lng = lng.toNumber();
			
			/*for (var i = 0; i <= lng; ++i) {
				tempPhrase = " " + scrolledPhrase;
				scrolledPhrase = tempPhrase;				
			}*/
			//System.print(scrolledPhrase + " " + lng);			
		}	
		else if (phraseType == twinkling) {
			var lng = scrolledPhrase.length();
			twinklingCount = 0;
			var firstPos = 0;
			//var currentPos = 1;
			var wordsCount = 0;
			var wordsArray = new[50];
			
			for (var i = 0; i <= lng; ++i) {
				var currentChar = scrolledPhrase.substring(i, i+1);
				if (currentChar.equals(" ") || i == lng){
					wordsArray[wordsCount] = scrolledPhrase.substring(firstPos, i);
					++i; //dismiss the white space
					//System.println(wordsArray[wordsCount]);
					wordsCount ++;
					firstPos = i;
				}			
			} 
			if (wordsCount == 1) {
				twinklingPhrase[0] = wordsArray[0];				
			}
			else
			{
				groupCount = 0;
				var tt = (wordsArray[0].length() + wordsArray[1].length() + wordsArray[2].length());
				//System.println(tt);
				for (var i = 0; i < wordsCount; ++i) {
					if (i < (wordsCount - 2) && (wordsArray[i].length() + wordsArray[i+1].length() + wordsArray[i+2].length()) < 16) {
						twinklingPhrase[groupCount] = wordsArray[i] + " " + wordsArray[i+1] + " " + wordsArray[i+2];
						i+=2;					
					}
					else if (i < (wordsCount - 1) && wordsArray[i].length() + wordsArray[i+1].length() < 16) {
						twinklingPhrase[groupCount] = wordsArray[i] + " " + wordsArray[i+1];
						++i;					
					}
					else {
						twinklingPhrase[groupCount] = wordsArray[i];
					}
					//System.println(twinklingPhrase[groupCount]);
					++groupCount;					
				}
				
			}
		}	
		//System.print("nro:  " + rndInd);
			
		return scrolledPhrase;
    }
    
    function setMotivationalPhrase() {
    	//Changes the phrase every certain seconds according to phraseTime value 
    	var timeNow = new Time.Moment(Time.now().value());
		var timeInc = timeNow.compare(timeBase);
		    	
    	if (timeInc > phraseTime)
    	{
    		selectPhrase();
    		timeBase = new Time.Moment(Time.now().value());
    	}
    	    	
    	if (phraseType == scrolled) { 
    		var firstChar = scrolledPhrase.substring(1,2);
	    	scrolledPhrase = scrolledPhrase.substring(1, scrolledPhrase.length()) + firstChar;
	    }
	    else if(phraseType == twinkling)
	    {
	    	scrolledPhrase = twinklingPhrase[twinklingCount];
	    	if (twinklingCount == groupCount -1) {
	    		twinklingCount = 0;
	    	} 
	    	else {
	    	   	twinklingCount++;
	    	}
	    }
	  	
    	return scrolledPhrase;
    	//System.println(firstChar);
    	//System.println(scrolledPhrase);
    	//motivationalDisplay.setColor(gTheme.phrase);  	
	    //motivationalDisplay.setText(scrolledPhrase);
    }
    
    function setPhraseRenewalTime()
    {
    	phraseTime = Application.getApp().getProperty("PhraseRenewalTime").toNumber();
    }
	
	function getJustification()
	{
		if (phraseType == scrolled){
			//System.println("left");
			return Graphics.TEXT_JUSTIFY_LEFT;			
		}
		else {
			//System.println("center");
			return Graphics.TEXT_JUSTIFY_CENTER;
		}		
	}

}