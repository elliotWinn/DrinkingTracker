
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../drink_states/drink_come_up.dart';
import 'drink_log.dart';
import 'user.dart';

class AppData extends ChangeNotifier {
  static const double baseGridSize = 8;
  static const double timeWarp = 500;

  DateTime startTime = DateTime.now();

  final double maxBAC = 0.3;
  List<FlSpot> dataPoints = [const FlSpot(0, 0)];
  final double graphRange = 5;
  // double minX = 0;
  // late double maxX = graphRange;

  int pendingDrinks = 1;
  List<DrinkLog> drinkLogs = [];

  User currentUser = User(name: "Test", dob: DateTime(2003, 01, 03), male: false, weight: 80);

  double get numDrinks {
    double total = 0;
    for (DrinkLog log in drinkLogs) {
      total += log.standards;
    }
    return total;
  }

  double get totalBAC {
    double sum = 0;
    for (DrinkLog log in drinkLogs) {
      sum += log.bacContribution;
    }
    return sum;
  }

  double get sliderProgress {
    if (totalBAC > maxBAC) {return maxBAC;}
    else{return totalBAC;}
  }

  int get red {
    if (totalBAC < 0) {return 0;}
    else if (totalBAC > maxBAC/2) {return 255;}
    else {return 510*totalBAC~/maxBAC;}
  }
  int get green {
    if (totalBAC < maxBAC/2) {return 255;}
    else if (totalBAC > maxBAC) {return 0;}
    else {return -510*totalBAC~/maxBAC + 510;}
  }

  Color get backgroundColour => Color.fromRGBO(red, green, 0, 1);

  void addGraphData() {
    dataPoints.add(FlSpot(DateTime.now().difference(startTime).inMilliseconds*timeWarp/(1000*60*60), totalBAC));
    // print(dataPoints[dataPoints.length-1].x);
    // while (dataPoints[dataPoints.length-1].x - dataPoints[0].x >= graphRange) {
    //   dataPoints.removeAt(0);
    // }

    // if (dataPoints[dataPoints.length-1].x+1 >= graphRange)  {
    //   // minX = dataPoints[0].x;
    //   maxX = dataPoints[dataPoints.length-1].x+1;
    // }
  }

  void addPendingDrinks() {
    for (int i = 0; i < pendingDrinks; i++) {
      notifyListeners();
    }

    DrinkLog drinkLogToAdd = DrinkLog(standards: pendingDrinks.toDouble());
    drinkLogToAdd.drinkLogState = DrinkComeUp(drinkLogToAdd);

    if (drinkLogs.isNotEmpty) {
      drinkLogToAdd.previousDrink = drinkLogs[drinkLogs.length-1];
    }

    drinkLogs.add(drinkLogToAdd);

    notifyListeners();
  }

  void reset() {
    drinkLogs.clear();
    dataPoints = [const FlSpot(0, 0)];
    startTime = DateTime.now();
    notifyListeners();
  }

  void updatePendingDrinks(int? n) {
    if (n != null) {
      pendingDrinks = n;
      notifyListeners();
    }
  }
}






