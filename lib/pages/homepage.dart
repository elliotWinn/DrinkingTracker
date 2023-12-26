import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../app_data.dart';
import '../main.dart';
import '../utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final Timer timer = Timer.periodic(Duration(milliseconds: 20), (timer) {setState(() {});});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(
      builder: (BuildContext context, Data data, Widget? child) {
        return Scaffold (
          extendBody: false,
          backgroundColor: Colors.white,
          bottomNavigationBar: MyNavBar(data: data,),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: Data.baseGridSize*3,
                horizontal: Data.baseGridSize*3,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height - Data.baseGridSize*18,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SleekCircularSlider(
                          initialValue: data.sliderBAC,
                          min: 0,
                          max: data.maxBAC,
                          appearance: CircularSliderAppearance(
                            size: Data.baseGridSize*32,
                            animationEnabled: false,
                            startAngle: 120,
                            angleRange: 300,
                            customWidths: CustomSliderWidths(
                              trackWidth: Data.baseGridSize*2.5,
                              progressBarWidth: Data.baseGridSize*2.5,
                              handlerSize: 0,
                            ),
                            customColors: CustomSliderColors(
                              trackColor: Colors.grey,
                              progressBarColor: data.backgroundColour.withOpacity(0.5),
                              hideShadow: true,
                            )
                          ),
                          innerWidget: (double value) {
                            return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(data.totalBAC.toStringAsFixed(5), style: TextStyle(fontSize: Data.baseGridSize*5),),
                                    OutlinedButton(
                                        onPressed: data.reset,
                                        child: const Text("Reset"),
                                      style: OutlinedButton.styleFrom(
                                        // backgroundColor: Colors.transparent,
                                        // shadowColor: Colors.transparent,
                                        foregroundColor: Colors.black,
                                      ),
                                    ),
                                  ]
                                )
                              );
                            },
                        ),
                        Text("You've had ${data.numDrinks} drinks"),
                        Text("Approx. BAC: ${data.totalBAC.toStringAsFixed(5)}"),
                        // LinearProgressIndicator(
                        //   borderRadius: const BorderRadiusDirectional.all(Radius.circular(Data.baseGridSize*1.5)),
                        //   value: data.numDrinks/data.maxDrinks,
                        //   minHeight: 15,
                        // ),
                        const Placeholder(
                            fallbackHeight: Data.baseGridSize*20,
                          ),
                        Container(
                          // margin: EdgeInsets.only(top: Data.baseGridSize*1.5,),
                          child: DrinkInputFieldHorizontal(data: data,)
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          // margin: const EdgeInsets.symmetric(vertical: Data.baseGridSize*1.5),
                          padding: const EdgeInsets.all(Data.baseGridSize*2),
                          decoration: BoxDecoration(
                            // boxShadow: [BoxShadow(color: Colors.black, offset: Offset.fromDirection(2, 10))],
                            color: data.backgroundColour.withOpacity(0.5),
                            borderRadius: const BorderRadius.all(Radius.circular(Data.baseGridSize*1.5))
                          ),
                          child: Column(
                            children: [
                              Text("History"),
                              DisplayList(
                                List.generate(
                                    data.drinkLogs.length,
                                        (i) => DrinkLogListItem(data.drinkLogs[data.drinkLogs.length-i-1])
                                )
                              ),
                            ]
                          ),
                        )
                      )
                    ],
                  )
                ]
              ),
            ),
          ),
        );
      },
    );
  }
}

class DrinkInputFieldVertical extends StatefulWidget {
  final Data data;
  const DrinkInputFieldVertical({super.key, required this.data});

  @override
  State<DrinkInputFieldVertical> createState() => _DrinkInputFieldVerticalState();
}

class _DrinkInputFieldVerticalState extends State<DrinkInputFieldVertical> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener((){widget.data.updatePendingDrinks(int.tryParse(controller.text) ?? 1);});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularButton(
                radius: 50,
                // onPressed: widget.data.addDrink,
                onPressed: (){widget.data.addDrinks();controller.clear();},
                text: "+${widget.data.pendingDrinks}",
              )
            ],
          ),
          HorizontalSpacer(height: 20, showBar: false,),
          SizedBox(
            width: 250,
            child: TextField(
              controller: controller,
              // textInputAction: TextInputAction.values,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                hintText: "Enter number of drinks",
                border: const OutlineInputBorder(),
                hoverColor: Colors.white,
                fillColor: Colors.white.withOpacity(0.9),
                filled: true,
              ),
            ),
          ),
        ]
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    controller.dispose();
    super.dispose();
  }
}

class DrinkInputFieldHorizontal extends StatefulWidget{
  final Data data;
  const DrinkInputFieldHorizontal({super.key, required this.data});

  @override
  State<DrinkInputFieldHorizontal> createState() => _DrinkInputFieldHorizontalState();
}

class _DrinkInputFieldHorizontalState extends State<DrinkInputFieldHorizontal> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.addListener(() {widget.data.updatePendingDrinks(int.tryParse(controller.text) ?? 1);});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: TextField(
              expands: true,
              maxLines: null,
              controller: controller,
              // textInputAction: TextInputAction.values,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                hintText: "Enter number of drinks",
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                hoverColor: Colors.white,
                fillColor: Colors.white.withOpacity(0.9),
                filled: true,
              ),
            ),
          ),

        Container(
          margin: EdgeInsets.only(left: Data.baseGridSize*1.5),
          child: SizedBox(
            width: 50*1.61803,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.all(0),
                shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 0.8) ,
                  borderRadius: BorderRadius.all(Radius.circular(8))
                )
              ),
              onPressed: (){widget.data.addDrinks();controller.clear();},
              child: Text(
                "+${widget.data.pendingDrinks}",
                style: TextStyle(fontSize: 24),
                ),
              ),
          ),
        ),
        ]
      ),
    );
  }
}

class InputDrinksCircular extends StatelessWidget{
  final Data data;

  const InputDrinksCircular({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      min: 0,
      max: 10,
      initialValue: 0,
      appearance: CircularSliderAppearance(
        startAngle: 110,
        angleRange: 320,
      ),
      onChange: (double value) {print(value.toInt());},
    );
  }
}