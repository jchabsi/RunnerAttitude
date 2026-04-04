using Toybox.Application;
using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Lang;

class TestRunnerView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    function onUpdate(dc) {
        var w = dc.getWidth();
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(w / 2, 10, Graphics.FONT_SMALL, "ProgressBar Tests", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(w / 2, 30, Graphics.FONT_XTINY, ProgressBarTests.getSummaryLine(), Graphics.TEXT_JUSTIFY_CENTER);

        var y = 50;
        var lines = ProgressBarTests.getLines() as Lang.Array;
        for (var i = 0; i < lines.size(); i += 1) {
            if (y > (dc.getHeight() - 12)) {
                break;
            }
            dc.drawText(6, y, Graphics.FONT_XTINY, lines[i].toString(), Graphics.TEXT_JUSTIFY_LEFT);
            y = y + 12;
        }
    }

}

class TestRunnerApp extends Application.AppBase {

    hidden var sleep = false;

    function initialize() {
        AppBase.initialize();
    }

    // Run tests when the app starts
    function onStart(state) {
        ProgressBarTests.runAll();
        WatchUi.requestUpdate();
    }

    // Keep compatibility with RunnerAttitudeView compile-time app calls
    function isSleeping() {
        return sleep;
    }

    function setSleep(val) {
        sleep = val;
    }

    function getInitialView() {
        var v = new TestRunnerView();
        return [v];
    }

}
