import 'package:flutter/material.dart';
import 'list_item.dart';


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