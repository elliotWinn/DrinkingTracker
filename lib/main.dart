import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomePage(
        key: Key("homepage"),
      ),
    );
  }
}

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _drinks = 0;

  void addDrink() {
    setState(() {
      _drinks++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(title: const Text("hello"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CentreOnPage(CircularButton(50, addDrink, "+1")),
          Text(_drinks.toString()),
        ],
      )
    );
  }
}

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
          padding: EdgeInsets.all(radius)
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: radius),
      ),
    );
  }
}
