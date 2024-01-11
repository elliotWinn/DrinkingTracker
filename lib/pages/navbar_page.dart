import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:test/pages/homepage.dart';
import 'package:test/pages/settings_page.dart';

import '../data/app_data.dart';

class NavbarPage extends StatefulWidget {
  final AppData data;
  const NavbarPage({super.key, required this.data});

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  int _pageIndex = 0;
  late PageController _pageController;
  late final List<Widget> _pages;

  @override
  void initState() {
    _pages = [
      HomePage(data: widget.data,),
      const SettingsPage()
    ];
    _pageController = PageController(initialPage: _pageIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _pageIndex = index;
      _pageController.animateToPage(
          _pageIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: PageTransitionSwitcher(
      //   duration: const Duration(seconds: 1),
      //   transitionBuilder: (child, animation, secondaryAnimation) =>
      //     FadeScaleTransition(
      //       animation: animation,
      //       // secondaryAnimation: secondaryAnimation,
      //       child: child,
      //     ),
      //   child: _pages[_pageIndex]
      // ),
      body: PageView(
        controller: _pageController,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "settings"),
        ]
      ),
    );
  }
}
