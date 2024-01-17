import 'package:test/data/app_data.dart';

import '../data/drink_log.dart';

abstract class DrinkLogState {
  final DrinkLog drinkLog;
  final double timeWarp = AppData.timeWarp;
  double getBacContribution(double weightKG, bool isMale, double elapsedHours);
  DrinkLogState(this.drinkLog);

  double widmarkFormula(double weightKG, bool isMale, double elapsedHours){
    double r = 0.55;
    if (isMale) {r = 0.65;}
    double bac = ((drinkLog.standards*10/(weightKG*1000))*100/r) - 0.015*elapsedHours*timeWarp;
    if (bac > 0) {return bac;}
    else {return 0;}
  }
}