import 'drink_log_state.dart';
import 'drink_not_processed.dart';

class DrinkComeUp extends DrinkLogState {
  DrinkComeUp(super.drinkLog);

  final double comeUpTime = 1000;

  @override
  double getBacContribution(double weightKG, bool isMale, double elapsedHours) {
    Duration timeElapsed = DateTime.now().difference(drinkLog.timeConsumed);
    // print("${timeElapsed.inMilliseconds}");
    if (timeElapsed.inMilliseconds > comeUpTime) {
      drinkLog.drinkLogState = DrinkNotProcessed(drinkLog);
    }
    return widmarkFormula(weightKG, isMale, 0)*(timeElapsed.inMilliseconds/comeUpTime);
  }
}