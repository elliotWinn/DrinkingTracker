import 'package:flutter/material.dart';

abstract class ListItem extends StatelessWidget{
  const ListItem({super.key});

  @override
  Row build(BuildContext context);
}