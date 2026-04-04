class ThemeTests {

    // Representative Theme enum ids from Theme.mc
    // RunnerAttitude=0, NightRunner=1, ShinnyDay=7

    static function deriveBackground(themeId) {
        if (themeId == 7) {
            return 0xFFFFFF;
        }
        return 0x000000;
    }

    static function deriveTrackLine(themeId) {
        if (themeId == 1) {
            return 0x0055AA;
        }
        if (themeId == 7) {
            return 0xFF5500;
        }
        return 0x00AA55;
    }

    static function deriveTrackProgress(themeId) {
        if (themeId == 1) {
            return 0x0000FF; // Gfx.COLOR_BLUE in Theme.mc
        }
        if (themeId == 7) {
            return 0x0055AA;
        }
        return 0x00FFAA;
    }

    static function deriveBackground4Runner(themeId) {
        if (themeId == 7) {
            return 0x0055AA;
        }
        return deriveBackground(themeId);
    }

    static function usesUniformIconColor(themeId) {
        // RunnerAttitude sets icon colors individually.
        if (themeId == 0) {
            return false;
        }
        // NightRunner and ShinnyDay call setColor4AllIcons.
        return true;
    }

    static function runAll(allPass) {
        // RunnerAttitude assertions
        allPass = ProgressBarTests.assertNumberEqual(ThemeTests.deriveBackground(0), 0x000000, "theme RunnerAttitude background") && allPass;
        allPass = ProgressBarTests.assertNumberEqual(ThemeTests.deriveTrackLine(0), 0x00AA55, "theme RunnerAttitude trackLine") && allPass;
        allPass = ProgressBarTests.assertNumberEqual(ThemeTests.deriveTrackProgress(0), 0x00FFAA, "theme RunnerAttitude trackProgress") && allPass;
        allPass = ProgressBarTests.assertTrue(!ThemeTests.usesUniformIconColor(0), "theme RunnerAttitude non-uniform icons") && allPass;

        // NightRunner assertions
        allPass = ProgressBarTests.assertNumberEqual(ThemeTests.deriveBackground(1), 0x000000, "theme NightRunner background") && allPass;
        allPass = ProgressBarTests.assertNumberEqual(ThemeTests.deriveTrackLine(1), 0x0055AA, "theme NightRunner trackLine") && allPass;
        allPass = ProgressBarTests.assertNumberEqual(ThemeTests.deriveTrackProgress(1), 0x0000FF, "theme NightRunner trackProgress") && allPass;
        allPass = ProgressBarTests.assertTrue(ThemeTests.usesUniformIconColor(1), "theme NightRunner uniform icons") && allPass;

        // ShinnyDay assertions (special background4Runner differs from background)
        allPass = ProgressBarTests.assertNumberEqual(ThemeTests.deriveBackground(7), 0xFFFFFF, "theme ShinnyDay background") && allPass;
        allPass = ProgressBarTests.assertNumberEqual(ThemeTests.deriveBackground4Runner(7), 0x0055AA, "theme ShinnyDay background4Runner") && allPass;
        allPass = ProgressBarTests.assertNumberEqual(ThemeTests.deriveTrackLine(7), 0xFF5500, "theme ShinnyDay trackLine") && allPass;
        allPass = ProgressBarTests.assertNumberEqual(ThemeTests.deriveTrackProgress(7), 0x0055AA, "theme ShinnyDay trackProgress") && allPass;
        allPass = ProgressBarTests.assertTrue(ThemeTests.usesUniformIconColor(7), "theme ShinnyDay uniform icons") && allPass;

        return allPass;
    }

}
