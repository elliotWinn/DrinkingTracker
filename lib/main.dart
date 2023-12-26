import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:test/pages/pages.dart';
import 'package:test/utils.dart';

import 'app_data.dart';

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