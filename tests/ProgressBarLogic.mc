using Toybox.Math;

class ProgressBarLogic {

    // Calculate progress percent as a Number (0.0..)
    static function calculatePercent(steps, stepGoal) {
        if (stepGoal <= 0) {
            return 0.0;
        }
        var p = steps.toFloat() / stepGoal.toFloat();
        if (p < 0.0) {
            p = 0.0;
        }
        return p;
    }

    // Compute X position for a given percent inside a width with padding
    static function computeProgressX(percent, width, padding) {
        var usable = width - (padding * 2);
        var v = Math.round(usable * percent);
        return padding + v;
    }

    // Choose avatar string from ProgressBar enum-like value and profile gender
    // ProgressBar enum values: 0 = genderSettings, 1 = avatarRunnerGirl, 2 = avatarRunnerBoy, 3 = avatarRunnerDisabled
    static function chooseAvatar(runnerAvatarSetting, profileGender) {
        if (runnerAvatarSetting == 3) {
            return "disabled";
        }
        if (runnerAvatarSetting == 1) {
            return "female";
        }
        if (runnerAvatarSetting == 2) {
            return "male";
        }
        // genderSettings: fall back to profile gender
        var g = "male";
        if (profileGender != null) {
            g = profileGender;
        }
        var gText = g.toString();
        if (gText.equals("female") || gText.equals("Female")) {
            return "female";
        }
        return "male";
    }

    static function shouldShowTrophy(steps, stepGoal) {
        return (stepGoal > 0) && (steps >= stepGoal);
    }

}
