import 'package:flutter/material.dart';
import '../data/app_data.dart';

class HorizontalSpacer extends StatelessWidget {
  final double height;
  final bool showBar;

  const HorizontalSpacer({super.key, required this.height, required this.showBar});

  @override
  Widget build(BuildContext context) {
    Column? bar;
    if (showBar) {
      bar = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: AppData.baseGridSize*7,
            height: AppData.baseGridSize*1,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.black.withOpacity(0.5),
            ),
          )
        ],
      );
    }
    return Container(
        decoration: const BoxDecoration(
          // color: Colors.purple,
        ),
        constraints: BoxConstraints.expand(height: height),
        child: bar
    );
  }
}