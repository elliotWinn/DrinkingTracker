import 'drink_log_state.dart';
import 'drink_processed.dart';
import 'drink_processing.dart';

class DrinkNotProcessed extends DrinkLogState {
  DrinkNotProcessed(super.drinkLog);

  @override
  double getBacContribution(double weightKG, bool isMale, double elapsedHours) {
    if (drinkLog.previousDrink == null || (drinkLog.previousDrink!.drinkLogState is DrinkProcessed)) {
      drinkLog.processStartTime = DateTime.now();
      drinkLog.drinkLogState = DrinkProcessing(drinkLog);
    }
    return widmarkFormula(weightKG, isMale, 0);
  }
}