import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../data/app_data.dart';
import '../main.dart';
import '../utils/circular_button.dart';
import '../utils/display_list.dart';
import '../utils/drink_log_list_item.dart';
import '../utils/horizontal_spacer.dart';

class HomePage extends StatefulWidget {
  final AppData data;

  const HomePage({super.key, required this.data});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState();

  @override
  void initState() {
    final Timer generalTimer =
        Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
    final Timer graphTimer =
        Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (mounted) {
        while (widget.data.dataPoints.length > 1000) {
          widget.data.dataPoints.removeAt(0);
        }
        widget.data.addGraphData();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      backgroundColor: Colors.white,
      // bottomNavigationBar: const MyNavBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: AppData.baseGridSize * 3,
            horizontal: AppData.baseGridSize * 3,
          ),
          child: Column(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height -
                  AppData.baseGridSize * 18,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SleekCircularSlider(
                    initialValue: widget.data.sliderProgress,
                    min: 0,
                    max: widget.data.maxBAC,
                    appearance: CircularSliderAppearance(
                        size: AppData.baseGridSize * 32,
                        animationEnabled: false,
                        startAngle: 120,
                        angleRange: 300,
                        customWidths: CustomSliderWidths(
                          trackWidth: AppData.baseGridSize * 2.5,
                          progressBarWidth: AppData.baseGridSize * 2.5,
                          handlerSize: 0,
                        ),
                        customColors: CustomSliderColors(
                          trackColor: Colors.grey,
                          progressBarColor:
                              widget.data.backgroundColour.withOpacity(0.5),
                          hideShadow: true,
                        )),
                    innerWidget: (double value) {
                      return Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            Text(
                              widget.data.totalBAC.toStringAsFixed(5),
                              style: const TextStyle(
                                  fontSize: AppData.baseGridSize * 5),
                            ),
                            OutlinedButton(
                              onPressed: widget.data.reset,
                              style: OutlinedButton.styleFrom(
                                // backgroundColor: Colors.transparent,
                                // shadowColor: Colors.transparent,
                                foregroundColor: Colors.black,
                              ),
                              child: const Text("Reset"),
                            ),
                          ]));
                    },
                  ),
                  Text("You've had ${widget.data.numDrinks} drinks"),
                  Text(
                      "Approx. BAC: ${widget.data.totalBAC.toStringAsFixed(5)}"),
                  // LinearProgressIndicator(
                  //   borderRadius: const BorderRadiusDirectional.all(Radius.circular(Data.baseGridSize*1.5)),
                  //   value: data.numDrinks/data.maxDrinks,
                  //   minHeight: 15,
                  // ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: LineChart(LineChartData(
                        gridData: FlGridData(
                            show: true,
                            drawVerticalLine: true,
                            drawHorizontalLine: true,
                            horizontalInterval: 0.05,
                            verticalInterval: 3,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                  color: Colors.grey.withOpacity(0.5),
                                  strokeWidth: 1);
                            },
                            getDrawingVerticalLine: (value) {
                              return FlLine(
                                  color: Colors.grey.withOpacity(0.5),
                                  strokeWidth: 1);
                            }),
                        titlesData: const FlTitlesData(
                          show: true,

                        ),
                        borderData: FlBorderData(
                          show: true,
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.5)),
                        ),
                        minX: 0,
                        maxX: 50,
                        minY: 0,
                        maxY: 0.3,
                        lineBarsData: [
                          LineChartBarData(
                            show: widget.data.dataPoints.isNotEmpty,
                            spots: widget.data.dataPoints,
                            isCurved: true,
                            // gradient: LinearGradient(
                            //   colors: [Colors.red, Colors.green],
                            // ),
                            // barWidth: 5,

                            dotData: const FlDotData(
                              show: false,
                            ),
                            belowBarData: BarAreaData(
                              show: false,
                              // gradient: LinearGradient(
                              //   // colors: gradientColors
                              //       .map((color) => color.withOpacity(0.3))
                              //       .toList(),
                              // ),
                            ),
                          ),
                        ],
                      )),
                    ),
                  ),
                  Container(
                      // margin: EdgeInsets.only(top: Data.baseGridSize*1.5,),
                      child: DrinkInputFieldHorizontal(
                    data: widget.data,
                  )),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                  // margin: const EdgeInsets.symmetric(vertical: Data.baseGridSize*1.5),
                  padding: const EdgeInsets.all(AppData.baseGridSize * 2),
                  decoration: BoxDecoration(
                      // boxShadow: [BoxShadow(color: Colors.black, offset: Offset.fromDirection(2, 10))],
                      // color: data.backgroundColour.withOpacity(0.5),
                      borderRadius: const BorderRadius.all(
                          Radius.circular(AppData.baseGridSize * 1.5)),
                      border: Border.all()),
                  child: Column(children: [
                    const Text("History"),
                    DisplayList(List.generate(
                        widget.data.drinkLogs.length,
                        (i) => DrinkLogListItem(widget.data
                            .drinkLogs[widget.data.drinkLogs.length - i - 1]))),
                  ]),
                ))
              ],
            )
          ]),
        ),
      ),
    );
  }
}

class DrinkInputFieldVertical extends StatefulWidget {
  final AppData data;

  const DrinkInputFieldVertical({super.key, required this.data});

  @override
  State<DrinkInputFieldVertical> createState() =>
      _DrinkInputFieldVerticalState();
}

class _DrinkInputFieldVerticalState extends State<DrinkInputFieldVertical> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      widget.data.updatePendingDrinks(int.tryParse(controller.text) ?? 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularButton(
            radius: 50,
            // onPressed: widget.data.addDrink,
            onPressed: () {
              widget.data.addPendingDrinks();
              controller.clear();
            },
            text: "+${widget.data.pendingDrinks}",
          )
        ],
      ),
      const HorizontalSpacer(
        height: 20,
        showBar: false,
      ),
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
    ]);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    controller.dispose();
    super.dispose();
  }
}

class DrinkInputFieldHorizontal extends StatefulWidget {
  final AppData data;

  const DrinkInputFieldHorizontal({super.key, required this.data});

  @override
  State<DrinkInputFieldHorizontal> createState() =>
      _DrinkInputFieldHorizontalState();
}

class _DrinkInputFieldHorizontalState extends State<DrinkInputFieldHorizontal> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.addListener(() {
      widget.data.updatePendingDrinks(int.tryParse(controller.text) ?? 1);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              hoverColor: Colors.white,
              fillColor: Colors.white.withOpacity(0.9),
              filled: true,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: AppData.baseGridSize * 1.5),
          child: SizedBox(
            width: 50 * 1.61803,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      widget.data.backgroundColour.withOpacity(0.4),
                  shadowColor: Colors.transparent,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: const EdgeInsets.all(0),
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 0.8),
                      borderRadius: BorderRadius.all(Radius.circular(8)))),
              onPressed: () {
                widget.data.addPendingDrinks();
                controller.clear();
              },
              child: Text(
                "+${widget.data.pendingDrinks}",
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class InputDrinksCircular extends StatelessWidget {
  final AppData data;

  const InputDrinksCircular({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      min: 0,
      max: 10,
      initialValue: 0,
      appearance: const CircularSliderAppearance(
        startAngle: 110,
        angleRange: 320,
      ),
      onChange: (double value) {
        print(value.toInt());
      },
    );
  }
}
