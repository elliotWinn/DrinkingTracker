// import 'package:flutter/cupertino.dart';
//
// import '../data/app_data.dart';
// import 'navbar_item.dart';
//
// class NavBarScaffold extends StatelessWidget {
//   final List<NavBarItem> navBarItems;
//   int get numItems => navBarItems.length;
//   static const double height = AppData.baseGridSize*7;
//
//   const NavBarScaffold({super.key, required this.navBarItems});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: List<Widget>.generate(
//           navBarItems.length,
//               (int i) => SizedBox(
//             width: MediaQuery.of(context).size.width/numItems,
//             height: height,
//             child: navBarItems[i],
//           )
//       ),
//     );
//   }
// }