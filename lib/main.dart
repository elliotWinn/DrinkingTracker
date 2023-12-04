import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const HomePage(key: Key("homepage"))
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int numDrinks = 0;
  final int _maxDrinks = 10;
  int get gain => 255~/_maxDrinks;
  int get red {
    if (numDrinks*gain > 255) {return 255;}
    else {return numDrinks*gain;}
  }
  int get green {
    if (numDrinks*gain > 255) {return 0;}
    else {return 255-numDrinks*gain;}
  }
  Color get backgroundColour => Color.fromRGBO(red, green, 0, 1);

  void addDrink() {
    setState(() {
      numDrinks++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      // appBar: AppBar(title: const Text("hello"),),
      backgroundColor: backgroundColour,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CentreOnPage(CircularButton(50, addDrink, "+1")),
          Text(numDrinks.toString()),
        ],
      )
    );
  }
}

// class Data extends ChangeNotifier {
//   int numDrinks = 0;
//   final int _maxDrinks = 10;
//
//   int get gain => 255~/_maxDrinks;
//
//   int get red {
//     if (numDrinks*gain > 255) {return 255;}
//     else {return numDrinks*gain;}
//   }
//
//   int get green {
//     if (numDrinks*gain > 255) {return 0;}
//     else {return 255-numDrinks*gain;}
//   }
//
//   Color get backgroundColour => Color.fromRGBO(red, green, 0, 1);
//
//   void addDrink() {
//     numDrinks++;
//     notifyListeners();
//   }
// }

class CentreOnPage extends StatelessWidget {
  final Widget widget;
  const CentreOnPage(this.widget, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          widget,
      ],
    );
  }
}

class CircularButton extends StatelessWidget {
  final double radius;
  final VoidCallback onPressed;
  final String text;


  const CircularButton(this.radius, this.onPressed, this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: EdgeInsets.all(radius),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 0.1),
        foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
        shadowColor: const Color.fromRGBO(255, 255, 255, 1),
        surfaceTintColor: const Color.fromRGBO(255, 255, 255, 1),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: radius),
      ),
    );
  }
}
