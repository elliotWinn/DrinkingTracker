import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:test/pages/pages.dart';

import 'app_data.dart';
import 'main.dart';

class NavBarScaffold extends StatelessWidget {
  final List<NavBarItem> navBarItems;
  int get numItems => navBarItems.length;
  static const double height = Data.baseGridSize*7;

  const NavBarScaffold({super.key, required this.navBarItems});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List<Widget>.generate(
          navBarItems.length,
              (int i) => SizedBox(
            width: MediaQuery.of(context).size.width/numItems,
            height: height,
            child: navBarItems[i],
          )
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final Icon icon;
  final Pages page;
  final Data data;

  const NavBarItem({super.key, required this.icon, required this.page, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: IconButton(
          onPressed: () {data.setCurrentPage(page);},
          hoverColor: Colors.white,
          style: FilledButton.styleFrom(
            foregroundColor: const Color.fromRGBO(0, 0, 0, 1),
            backgroundColor: const Color.fromRGBO(0,0,0, 0.2),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            elevation: 0,
          ),
          icon: icon,
          // child: icon
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  final double radius;
  final VoidCallback onPressed;
  final String text;


  const CircularButton({required this.radius, required this.onPressed, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: EdgeInsets.all(radius),
        // backgroundColor: const Color.fromRGBO(255, 255, 255, 0.1),
        // foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
        // shadowColor: const Color.fromRGBO(255, 255, 255, 1),
        // surfaceTintColor: const Color.fromRGBO(255, 255, 255, 1),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: radius),
      ),
    );
  }
}

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
            width: Data.baseGridSize*7,
            height: Data.baseGridSize*1,
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

abstract class ListItem extends StatelessWidget{
  const ListItem({super.key});

  @override
  Row build(BuildContext context);
}

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
        Text(DateFormat('jm').format(log.dateTime)),
        Text(DateFormat('dd/MM/yyyy').format(log.dateTime)),
        Text(log.elapsedTimeString),
        Text(log.widmarkFormula(80, true).toStringAsFixed(5))
      ],
    );
  }
}

class DisplayList extends StatelessWidget {
  final List<ListItem> list;

  const DisplayList(this.list, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: list
    );
  }
}