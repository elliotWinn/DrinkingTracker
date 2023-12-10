import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:test/pages.dart';

void main() {
  // debugPaintSizeEnabled=true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Data(),
      child: Consumer<Data>(
        builder: (BuildContext context, Data data, Widget? child){
          return MaterialApp (
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: data.backgroundColour),
                useMaterial3: true,
              ),
              home: data.currentPage.page
          );
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(
      builder: (BuildContext context, Data data, Widget? child) {
        return Scaffold (
        // appBar: AppBar(title: const Text("hello"),),
          backgroundColor: data.backgroundColour,
          // bottomNavigationBar: NavigationBar(
          //   // indicatorShape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          //   destinations: const [
          //     NavigationDestination(icon: Icon(Icons.home), label: ""),
          //     NavigationDestination(icon: Icon(Icons.document_scanner), label: "")
          //   ]
          // ),
          bottomNavigationBar: MyNavBar(data: data,),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(50),
                    child: CircularButton(50, data.addDrink, "+1")
                  ),
                ],
              ),
              Text(
                  "You've had ${data.numDrinks} drinks"
              ),
              Container(
                // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                margin: const EdgeInsets.only(top: 50, bottom: 50, left: 100, right: 100),
                child: LinearProgressIndicator(
                  // backgroundColor: LinearGradient(colors: Colors.red, Colors.yellow,
                  borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
                  value: data.numDrinks/data.maxDrinks,
                  minHeight: 15,
                )
              ),
              // const GradientProgressIndicator(
              //   gradient: LinearGradient(colors: [Colors.green, Colors.yellow, Colors.red]),
              // ),
              ElevatedButton(
                  onPressed: data.reset,
                  child: const Text("Reset")),
            ],
          ),
        );
      },
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, Data data, Widget? child) {
        return Scaffold(
          appBar: AppBar(title: Text("settings"),),
          body: Placeholder(),
          bottomNavigationBar: MyNavBar(data: data),
        );
      }
    );
  }
}

class Data extends ChangeNotifier {
  int numDrinks = 0;
  int red = 0;
  int green = 255;
  Pages currentPage = Pages.home;

  final int _maxDrinks = 10;
  int get maxDrinks => _maxDrinks;

  int get gain => 2*255~/_maxDrinks;

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
    numDrinks++;
    updateColour(gain);
    notifyListeners();
  }

  void reset() {
    numDrinks = 0;
    red = 0;
    green = 255;
    notifyListeners();
  }
}

class NavBarScaffold extends StatelessWidget {
  final List<NavBarItem> navBarItems;
  int get numItems => navBarItems.length;
  static const double height = 75;

  const NavBarScaffold({super.key, required this.navBarItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.0),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15))
      ),
      // padding: const EdgeInsets.only(top: height/2, bottom: height/2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List<Widget>.generate(
            navBarItems.length,
                (int i) => SizedBox(
                  width: MediaQuery.of(context).size.width/numItems,
                  height: height,
                  child: navBarItems[i],
                )
        ),
      ),
    );
  }
}

class MyNavBar extends StatelessWidget {
  final Data data;

  const MyNavBar({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return NavBarScaffold(navBarItems: [
      NavBarItem(icon: const Icon(Icons.home), page: Pages.home, data: data,),
      NavBarItem(icon: const Icon(Icons.settings), page: Pages.settings, data: data,)
    ]);
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
      child: FilledButton(
          onPressed: () {data.setCurrentPage(page);},
          style: FilledButton.styleFrom(
            foregroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
            backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
            // surfaceTintColor: const Color.fromRGBO(255, 255, 255, 0.0),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular((15)))),
            elevation: 0,
          ),
          child: icon
      ),
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
