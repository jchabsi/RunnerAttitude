class PhraseTests {

    // Mirrors Phrases.getPhrasesList() branching:
    // scrolled=1, twinkling=0 -> 50; fixed=2 -> 23; personalized* -> 1
    static function derivePhraseRndMax(phraseType) {
        if (phraseType == 1 || phraseType == 0) {
            return 50;
        }
        if (phraseType == 2) {
            return 23;
        }
        return 1;
    }

    // Mirrors Phrases.selectPhrase() custom text branching
    // <16 chars -> fixed(2), else -> twinkling(0)
    static function deriveCustomPhraseTypeByLength(textLength) {
        if (textLength < 16) {
            return 2;
        }
        return 0;
    }

    static function runAll(allPass) {
        // Phrase selection/range logic coverage
        allPass = ProgressBarTests.assertNumberEqual(PhraseTests.derivePhraseRndMax(1), 50, "phrase rndMax scrolled") && allPass;
        allPass = ProgressBarTests.assertNumberEqual(PhraseTests.derivePhraseRndMax(0), 50, "phrase rndMax twinkling") && allPass;
        allPass = ProgressBarTests.assertNumberEqual(PhraseTests.derivePhraseRndMax(2), 23, "phrase rndMax fixed") && allPass;
        allPass = ProgressBarTests.assertNumberEqual(PhraseTests.derivePhraseRndMax(3), 1, "phrase rndMax personalized") && allPass;
        allPass = ProgressBarTests.assertNumberEqual(PhraseTests.deriveCustomPhraseTypeByLength(15), 2, "custom phrase <16 fixed") && allPass;
        allPass = ProgressBarTests.assertNumberEqual(PhraseTests.deriveCustomPhraseTypeByLength(16), 0, "custom phrase >=16 twinkling") && allPass;

        return allPass;
    }

}
