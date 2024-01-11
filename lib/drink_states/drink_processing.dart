import 'drink_log_state.dart';
import 'drink_processed.dart';

class DrinkProcessing extends DrinkLogState {
  DrinkProcessing(super.drinkLog);

  @override
  double getBacContribution(double weightKG, bool isMale, double elapsedHours) {
    if (widmarkFormula(weightKG, isMale, elapsedHours) <= 0) {
      drinkLog.drinkLogState = DrinkProcessed(drinkLog);
    }
    return widmarkFormula(weightKG, isMale, elapsedHours);
  }
}