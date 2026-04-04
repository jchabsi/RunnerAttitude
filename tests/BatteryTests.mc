class BatteryTests {

    // Mirrors RunnerAttitudeView battery threshold selection
    // 0 => ok, 1 => low, 2 => critical
    static function deriveBatteryBand(level) {
        if (level <= 10) {
            return 2;
        }
        if (level <= 25) {
            return 1;
        }
        return 0;
    }

    static function runAll(allPass) {
        // Battery threshold logic coverage
        allPass = ProgressBarTests.assertNumberEqual(BatteryTests.deriveBatteryBand(100), 0, "battery ok >25") && allPass;
        allPass = ProgressBarTests.assertNumberEqual(BatteryTests.deriveBatteryBand(25), 1, "battery low at 25") && allPass;
        allPass = ProgressBarTests.assertNumberEqual(BatteryTests.deriveBatteryBand(11), 1, "battery low at 11") && allPass;
        allPass = ProgressBarTests.assertNumberEqual(BatteryTests.deriveBatteryBand(10), 2, "battery critical at 10") && allPass;
        allPass = ProgressBarTests.assertNumberEqual(BatteryTests.deriveBatteryBand(0), 2, "battery critical at 0") && allPass;

        return allPass;
    }

}
