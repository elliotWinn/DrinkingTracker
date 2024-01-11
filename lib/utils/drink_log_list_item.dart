import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test/utils/list_item.dart';

import '../data/drink_log.dart';

class DrinkLogListItem extends ListItem {
  final DrinkLog log;

  const DrinkLogListItem(this.log, {super.key});

  @override
  Row build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          log.standards.toString(),
          // style: TextStyle(fontSize: Data.baseGridSize*3),
        ),
        Text(DateFormat('jm').format(log.timeConsumed)),
        Text(DateFormat('dd/MM/yyyy').format(log.timeConsumed)),
        Text(log.elapsedTimeString),
        Text(log.bacContribution.toStringAsFixed(5))
      ],
    );
  }
}