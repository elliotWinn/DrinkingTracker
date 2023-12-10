import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/main.dart';

enum Pages {
  home(HomePage(key: Key("homepage"))),
  settings(SettingsPage(key: Key("settings"),));

  final Widget _page;
  Widget get page => _page;
  const Pages(this._page);
}