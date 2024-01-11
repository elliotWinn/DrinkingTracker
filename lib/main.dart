import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/pages/homepage.dart';
import 'package:test/pages/navbar_page.dart';
import 'package:test/pages/settings_page.dart';

import 'data/app_data.dart';
import 'utils/navbar_item.dart';
import 'utils/navbar_scaffold.dart';

void main() {
  // debugPaintSizeEnabled=true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: Consumer<AppData>(
        builder: (BuildContext context, AppData data, Widget? child){
          return MaterialApp (
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: data.backgroundColour),
                useMaterial3: true,
              ),
              home: NavbarPage(data: data,),
              // home: const HomePage(key: Key("homepage"),)
          );
        },
      ),
    );
  }
}

// class MyNavBar extends StatelessWidget {
//   const MyNavBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const NavBarScaffold(navBarItems: [
//       NavBarItem(icon: Icon(Icons.home), appPage: HomePage(key: Key("homepage"),)),
//       NavBarItem(icon: Icon(Icons.settings), appPage: SettingsPage(key: Key("settings")))
//     ]);
//   }
// }