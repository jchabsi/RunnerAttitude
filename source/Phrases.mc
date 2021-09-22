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
	hidden const numberOfPhrases = 50;
	hidden const numberOfWords = 23;
	private var rndMax = 0;
	//hidden var phrasesList;		
	hidden var scrolledPhrase;
	hidden var phraseTime = 300;
	hidden var phraseSpeed;
	hidden enum {
		twinkling,
		scrolled,
		fixed,
		personalized,
		personalized2,
		personalized3
	}
	hidden enum {
		speed1X = 1,
		speed2X = 2,
		speed3X = 3
	}
	var phraseType;
	hidden var twinklingPhrase = new[15];
	hidden var twinklingCount;
	hidden var groupCount;
	hidden var timeBase;
	hidden var speedCount = 4;
	
	
	function initialize() {		
		
        getPhrasesList();   
        getPhraseRenewalTime(); 
        getPhraseSpeed();
        timeBase = new Time.Moment(Time.now().value()); 
        
	}		
	
	function getPhrasesList() {
		phraseType = Application.getApp().getProperty("MotivationalPhrase").toNumber();
		    	
    	if (phraseType == scrolled) {  	
    		rndMax = numberOfPhrases;
	    	
	    }
	    else if (phraseType == twinkling) {
	    	rndMax = numberOfPhrases;
	    	
	    }
	    else if (phraseType == fixed) {
	    	rndMax = numberOfWords;
	    	
	    }
	    else {
	    	rndMax = 1;	    	
	    }
	}
	
	function getPhraseFromRez(phraseNo) {
		var phrase;
		if (phraseType == scrolled || phraseType == twinkling) {
			switch (phraseNo) {
				case 0:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase1);				
					break;
				case 1:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase2);				
					break;
				case 2:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase3);				
					break;
				case 3:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase4);				
					break;
				case 4:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase5);				
					break;
				case 5:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase6);				
					break;
				case 6:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase7);				
					break;
				case 7:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase8);				
					break;
				case 8:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase9);				
					break;
				case 9:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase10);				
					break;
				case 10:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase11);				
					break;
				case 11:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase12);				
					break;
				case 12:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase13);				
					break;
				case 13:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase14);				
					break;
				case 14:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase15);				
					break;
				case 15:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase16);				
					break;
				case 16:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase17);				
					break;
				case 17:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase18);				
					break;
				case 18:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase19);				
					break;
				case 19:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase20);				
					break;
				case 20:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase21);				
					break;
				case 21:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase22);				
					break;
				case 22:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase23);				
					break;
				case 23:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase24);				
					break;
				case 24:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase25);				
					break;
				case 25:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase26);				
					break;
				case 26:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase27);				
					break;
				case 27:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase28);				
					break;
				case 28:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase29);				
					break;
				case 29:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase30);				
					break;
				case 30:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase31);				
					break;
				case 31:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase32);				
					break;
				case 32:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase33);				
					break;
				case 33:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase34);				
					break;
				case 34:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase35);				
					break;
				case 35:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase36);				
					break;
				case 36:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase37);				
					break;
				case 37:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase38);				
					break;
				case 38:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase39);				
					break;
				case 39:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase40);				
					break;
				case 40:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase41);				
					break;
				case 41:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase42);				
					break;
				case 42:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase43);				
					break;
				case 43:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase44);				
					break;
				case 44:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase45);				
					break;
				case 45:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase46);				
					break;
				case 46:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase47);				
					break;
				case 47:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase48);				
					break;
				case 48:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase49);				
					break;
				case 49:
					phrase = WatchUi.loadResource(Rez.Strings.Phrase50);				
					break;
			}
		} else {
			switch (phraseNo) {
				case 0:
					phrase = WatchUi.loadResource(Rez.Strings.Fixed1);				
					break;
				case 1:
					phrase = WatchUi.loadResource(Rez.Strings.Fixed2);				
					break;
				case 2:
					phrase = WatchUi.loadResource(Rez.Strings.Fixed3);				
					break;
				case 3:
					phrase = WatchUi.loadResource(Rez.Strings.Fixed4);				
					break;
				case 4:
					phrase = WatchUi.loadResource(Rez.Strings.Fixed5);				
					break;
				case 5:
					phrase = WatchUi.loadResource(Rez.Strings.Fixed6);				
					break;
				case 6:
					phrase = WatchUi.loadResource(Rez.Strings.Fixed7);				
					break;
				case 7:
					phrase = WatchUi.loadResource(Rez.Strings.Fixed8);				
					break;
				case 8:
					phrase = WatchUi.loadResource(Rez.Strings.Fixed9);				
					break;
				case 9:
					phrase = WatchUi.loadResource(Rez.Strings.Fixed10);				
					break;
				case 10:
					phrase = WatchUi.loadResource(Rez.Strings.Fixed11);				
					break;
				case 11:
					phrase = WatchUi.loadResource(Rez.Strings.Fixed12);				
					break;
				case 12:
					phrase = WatchUi.loadResource(Rez.Strings.Fixed13);				
					break;
				case 13:
					phrase = WatchUi.loadResource(Rez.Strings.Fixed14);				
					break;
				case 14:
					phrase = WatchUi.loadResource(Rez.Strings.Fixed15);				
					break;
				case 15:
					phrase = WatchUi.loadResource(Rez.Strings.Fixed16);				
					break;
				case 16:
					phrase = WatchUi.loadResource(Rez.Strings.Fixed17);				
					break;
				case 17:
					phrase = WatchUi.loadResource(Rez.Strings.Fixed18);				
					break;
				case 18:
					phrase = WatchUi.loadResource(Rez.Strings.Fixed19);				
					break;
				case 19:
					phrase = WatchUi.loadResource(Rez.Strings.Fixed20);				
					break;
				case 20:
					phrase = WatchUi.loadResource(Rez.Strings.Fixed21);				
					break;
				case 21:
					phrase = WatchUi.loadResource(Rez.Strings.Fixed22);				
					break;
				case 22:
					phrase = WatchUi.loadResource(Rez.Strings.Fixed23);				
					break;
			}			
		}		
		if (phraseType == scrolled) {
			phrase = sp + phrase + sl;
		}
		return phrase;
	}
	
	function getCustomPhrase() {
		var prop = "CustomText";
    	if (phraseType == personalized2) {
    		prop = "CustomText2";
    	} else if (phraseType == personalized3) {
    		prop = "CustomText3";
    	}
    	
    	var phrase = Application.getApp().getProperty(prop);
    	
    	if (phrase.length() == 0) {
    		phrase = WatchUi.loadResource(Rez.Strings.InsertYourPhrase);
    	}
    	return phrase;
	}
		
	function selectPhrase() {
		var rndInd;
		//If we have a list we choose a random phrase,
    	if (rndMax > 1) {
	    	Math.srand(System.getTimer());
			rndInd = Math.rand() % (rndMax - 1);			
			scrolledPhrase = getPhraseFromRez(rndInd);
		} else {
			
			scrolledPhrase = getCustomPhrase();
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
    		var firstChar;
    		if (phraseSpeed == speed1X) {
	    		firstChar = scrolledPhrase.substring(1,2);
		    	scrolledPhrase = scrolledPhrase.substring(1, scrolledPhrase.length()) + firstChar;
		    } else if (phraseSpeed == speed2X) {
		    	firstChar = scrolledPhrase.substring(1,3);
		    	scrolledPhrase = scrolledPhrase.substring(2, scrolledPhrase.length()) + firstChar;
		    } else {
		    	firstChar = scrolledPhrase.substring(1,4);
		    	scrolledPhrase = scrolledPhrase.substring(3, scrolledPhrase.length()) + firstChar;
		    }	    	
	    }
	    else if(phraseType == twinkling)
	    {
	    	speedCount --;
	    	if (speedCount == phraseSpeed) {
	    	
		    	scrolledPhrase = twinklingPhrase[twinklingCount];
		    	if (twinklingCount == groupCount -1) {
		    		twinklingCount = 0;
		    	} 
		    	else {
		    	   	twinklingCount++;
		    	}
		    	speedCount = 4;
		    }
	    }
	  	
    	return scrolledPhrase;
    	//System.println(firstChar);
    	//System.println(scrolledPhrase);
    	//motivationalDisplay.setColor(gTheme.phrase);  	
	    //motivationalDisplay.setText(scrolledPhrase);
    }
    
    function getPhraseRenewalTime()
    {
    	phraseTime = Application.getApp().getProperty("PhraseRenewalTime").toNumber();
    }
	
	function getPhraseSpeed()
    {
    	phraseSpeed = Application.getApp().getProperty("PhraseSpeed").toNumber();
    	speedCount = 4;
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