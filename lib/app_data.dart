import 'package:flutter/cupertino.dart';
import 'package:test/pages/pages.dart';

class Data extends ChangeNotifier {
  int numDrinks = 0;
  final double maxBAC = 0.3;
  int red = 0;
  int green = 255;
  Pages currentPage = Pages.home;
  List<DrinkLog> drinkLogs = [];
  int pendingDrinks = 1;
  static const double baseGridSize = 8;

  double get totalBAC {
    double sum = 0;
    for (DrinkLog log in drinkLogs) {
      sum += log.widmarkFormula(80, true);
    }
    return sum;
  }

  double get sliderBAC {
    if (totalBAC > maxBAC) {return maxBAC;}
    else{return totalBAC;}
  }

  final int maxDrinks = 10;

  int get gain => 2*255~/maxDrinks;

  double get progress => numDrinks/maxDrinks;

  Color get backgroundColour => Color.fromRGBO(red, green, 0, 1);

  void setCurrentPage(Pages page) {
    currentPage = page;
    notifyListeners();
  }

  void updateColour(int gain) {
    if (red < 255) {
      red += gain;
      if (red > 255) {red = 255;}
    }
    else {
      green -= gain;
      if (green<0) {green = 0;}
    }
  }

  void addDrink() {
    numDrinks+=1;
    updateColour(gain);
    notifyListeners();
  }

  void addDrinks() {
    for (int i = 0; i < pendingDrinks; i++) {
      addDrink();
    }
    drinkLogs.add(DrinkLog(standards: pendingDrinks.toDouble()));
    notifyListeners();
  }

  void reset() {
    numDrinks = 0;
    red = 0;
    green = 255;
    notifyListeners();
  }

  void updatePendingDrinks(int? n) {
    if (n != null) {
      pendingDrinks = n;
      notifyListeners();
    }
  }
}

class DrinkLog {
  late DateTime dateTime;

  Duration get _timeDifference => DateTime.now().difference(dateTime);
  String get secondsString => (_timeDifference.inSeconds%60).toString().padLeft(2,"0");
  String get minutesString => (_timeDifference.inMinutes%60).toString().padLeft(2, "0");
  String get hoursString => _timeDifference.inHours.toString().padLeft(2, "0");

  double get elapsedHours => _timeDifference.inMilliseconds/(1000*60*60);
  String get elapsedTimeString => "$hoursString:$minutesString:$secondsString";

  double standards;

  double widmarkFormula(double weightKG, bool isMale){
    double r = 0.55;
    if (isMale) {r = 0.65;}
    double bac = ((standards*10/(weightKG*1000))*100/r) - 0.015*elapsedHours*200;
    if (bac > 0) {return bac;}
    else {return 0;}
  }

  DrinkLog({required this.standards}) {
    dateTime = DateTime.now();
  }
  @override
  String toString() {
    return "$standards $dateTime";
  }
}