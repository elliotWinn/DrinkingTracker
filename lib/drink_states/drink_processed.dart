import 'drink_log_state.dart';

class DrinkProcessed extends DrinkLogState {
  DrinkProcessed(super.drinkLog);

  @override
  double getBacContribution(double weightKG, bool isMale, double elapsedHours) {
    return 0;
  }
}