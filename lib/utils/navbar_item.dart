// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../data/app_data.dart';
//
// class NavBarItem extends StatelessWidget {
//   final Icon icon;
//   final Widget appPage;
//
//   const NavBarItem({super.key, required this.icon, required this.appPage});
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (BuildContext context, AppData data, Widget? child) {
//         return SizedBox.expand(
//           child: IconButton(
//             onPressed: () {
//               Type pageType = appPage.runtimeType;
//               if (data.lastPage.runtimeType == (appPage.runtimeType)) {return;}
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) {data.lastPage = appPage; return appPage;},
//                 ),
//               );
//             },
//             hoverColor: Colors.white,
//             style: FilledButton.styleFrom(
//               foregroundColor: const Color.fromRGBO(0, 0, 0, 1),
//               backgroundColor: const Color.fromRGBO(0,0,0, 0.2),
//               shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//               elevation: 0,
//             ),
//             icon: icon,
//             // child: icon
//           ),
//         );
//       },
//     );
//   }
// }