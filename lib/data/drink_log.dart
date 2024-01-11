import '../drink_states/drink_come_up.dart';
import '../drink_states/drink_log_state.dart';

class DrinkLog {
  DateTime timeConsumed = DateTime.now();
  DateTime processStartTime = DateTime.now();

  Duration get _timeConsumedDifference => DateTime.now().difference(timeConsumed);
  Duration get _timeProcessedDifference => DateTime.now().difference(processStartTime);

  String get secondsString => (_timeConsumedDifference.inSeconds%60).toString().padLeft(2,"0");
  String get minutesString => (_timeConsumedDifference.inMinutes%60).toString().padLeft(2, "0");
  String get hoursString => _timeConsumedDifference.inHours.toString().padLeft(2, "0");
  String get elapsedTimeString => "$hoursString:$minutesString:$secondsString";

  double get processingHours => _timeProcessedDifference.inMilliseconds/(1000*60*60);

  double standards;
  late DrinkLogState drinkLogState;

  DrinkLog? previousDrink;

  double get bacContribution => drinkLogState.getBacContribution(80, false, processingHours);
  String get bacContributionString => "$bacContribution";

  DrinkLog({required this.standards, this.previousDrink}) {
    drinkLogState = DrinkComeUp(this);
  }

  @override
  String toString() {
    return "$standards $timeConsumed";
  }
}