using Toybox.Math;
using Toybox.System as Sys;

class ProgressBarTests {

    static var _lines = [];
    static var _passCount = 0;
    static var _failCount = 0;

    static function reset() {
        _lines = [];
        _passCount = 0;
        _failCount = 0;
    }

    static function addResultLine(line) {
        _lines.add(line);
    }

    static function getLines() {
        return _lines;
    }

    static function getSummaryLine() {
        return "PASS " + _passCount + "  FAIL " + _failCount;
    }

    static function assertNumberEqual(actual, expected, name) {
        var diff = actual.toFloat() - expected.toFloat();
        if (diff < 0.0) {
            diff = 0.0 - diff;
        }

        if (diff < 0.0001) {
            var linePass = "[PASS] " + name;
            _passCount = _passCount + 1;
            addResultLine(linePass);
            Sys.println(linePass);
            return true;
        } else {
            var lineFail = "[FAIL] " + name + " expected:" + expected + " actual:" + actual;
            _failCount = _failCount + 1;
            addResultLine(lineFail);
            Sys.println(lineFail);
            return false;
        }
    }

    static function assertTextEqual(actual, expected, name) {
        var a = actual.toString();
        var e = expected.toString();
        if (a.equals(e)) {
            var linePass = "[PASS] " + name;
            _passCount = _passCount + 1;
            addResultLine(linePass);
            Sys.println(linePass);
            return true;
        }
        var lineFail = "[FAIL] " + name + " expected:" + expected + " actual:" + actual;
        _failCount = _failCount + 1;
        addResultLine(lineFail);
        Sys.println(lineFail);
        return false;
    }

    static function assertTrue(cond, name) {
        if (cond) {
            var linePass = "[PASS] " + name;
            _passCount = _passCount + 1;
            addResultLine(linePass);
            Sys.println(linePass);
            return true;
        }
        var lineFail = "[FAIL] " + name + " expected true";
        _failCount = _failCount + 1;
        addResultLine(lineFail);
        Sys.println(lineFail);
        return false;
    }

    static function runAll() {
        reset();

        var allPass = true;

        // Percent calculation tests
        allPass = ProgressBarTests.assertNumberEqual(ProgressBarLogic.calculatePercent(0,100), 0.0, "percent 0/100") && allPass;
        allPass = ProgressBarTests.assertNumberEqual(ProgressBarLogic.calculatePercent(50,100), 0.5, "percent 50/100") && allPass;
        allPass = ProgressBarTests.assertNumberEqual(ProgressBarLogic.calculatePercent(100,100), 1.0, "percent 100/100") && allPass;
        allPass = ProgressBarTests.assertNumberEqual(ProgressBarLogic.calculatePercent(150,100), 1.5, "percent 150/100") && allPass;
        allPass = ProgressBarTests.assertNumberEqual(ProgressBarLogic.calculatePercent(0,0), 0.0, "percent 0/0") && allPass;
        allPass = ProgressBarTests.assertNumberEqual(ProgressBarLogic.calculatePercent(100,0), 0.0, "percent 100/0") && allPass;
        allPass = ProgressBarTests.assertNumberEqual(ProgressBarLogic.calculatePercent(-10,100), 0.0, "percent negative clamped") && allPass;
        allPass = ProgressBarTests.assertNumberEqual(ProgressBarLogic.calculatePercent(1000000,10000), 100.0, "percent large numbers") && allPass;

        // computeProgressX tests
        var expectedX = 10 + Math.round((200 - 20) * 0.5);
        allPass = ProgressBarTests.assertNumberEqual(ProgressBarLogic.computeProgressX(0.5, 200, 10), expectedX, "computeX 50%") && allPass;
        allPass = ProgressBarTests.assertNumberEqual(ProgressBarLogic.computeProgressX(0.0, 200, 10), 10, "computeX 0% left bound") && allPass;
        allPass = ProgressBarTests.assertNumberEqual(ProgressBarLogic.computeProgressX(1.0, 200, 10), 190, "computeX 100% right bound") && allPass;

        // Avatar selection tests (ProgressBar enum values used in chooseAvatar)
        allPass = ProgressBarTests.assertTextEqual(ProgressBarLogic.chooseAvatar(3, "male"), "disabled", "avatar disabled") && allPass;
        allPass = ProgressBarTests.assertTextEqual(ProgressBarLogic.chooseAvatar(1, "male"), "female", "avatar female forced") && allPass;
        allPass = ProgressBarTests.assertTextEqual(ProgressBarLogic.chooseAvatar(2, "female"), "male", "avatar male forced") && allPass;
        allPass = ProgressBarTests.assertTextEqual(ProgressBarLogic.chooseAvatar(0, "female"), "female", "avatar auto female") && allPass;
        allPass = ProgressBarTests.assertTextEqual(ProgressBarLogic.chooseAvatar(0, "male"), "male", "avatar auto male") && allPass;
        allPass = ProgressBarTests.assertTextEqual(ProgressBarLogic.chooseAvatar(0, null), "male", "avatar null defaults male") && allPass;
        allPass = ProgressBarTests.assertTextEqual(ProgressBarLogic.chooseAvatar(0, "FEMALE"), "male", "avatar uppercase fallback") && allPass;
        allPass = ProgressBarTests.assertTextEqual(ProgressBarLogic.chooseAvatar(99, "female"), "female", "avatar unknown setting uses profile") && allPass;

        // Trophy condition tests
        allPass = ProgressBarTests.assertTrue(ProgressBarLogic.shouldShowTrophy(100,100), "trophy at goal") && allPass;
        allPass = ProgressBarTests.assertTrue(!ProgressBarLogic.shouldShowTrophy(99,100), "no trophy below goal") && allPass;
        allPass = ProgressBarTests.assertTrue(ProgressBarLogic.shouldShowTrophy(101,100), "trophy above goal") && allPass;
        allPass = ProgressBarTests.assertTrue(!ProgressBarLogic.shouldShowTrophy(100,0), "no trophy with zero goal") && allPass;

        // Cross-check scenario
        var scenarioPercent = ProgressBarLogic.calculatePercent(500, 1000);
        var scenarioX = ProgressBarLogic.computeProgressX(scenarioPercent, 200, 10);
        allPass = ProgressBarTests.assertNumberEqual(scenarioPercent, 0.5, "scenario percent 500/1000") && allPass;
        allPass = ProgressBarTests.assertNumberEqual(scenarioX, 100, "scenario x at 50%") && allPass;
        allPass = ProgressBarTests.assertTrue(!ProgressBarLogic.shouldShowTrophy(500,1000), "scenario trophy false") && allPass;

        allPass = PhraseTests.runAll(allPass);
        allPass = BatteryTests.runAll(allPass);
        allPass = ThemeTests.runAll(allPass);

        if (allPass) {
            addResultLine("ALL TESTS PASS");
            Sys.println("ALL TESTS PASS");
        } else {
            addResultLine("SOME TESTS FAILED");
            Sys.println("SOME TESTS FAILED");
        }
        return allPass;
    }

}
