import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_data.dart';
import '../main.dart';

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