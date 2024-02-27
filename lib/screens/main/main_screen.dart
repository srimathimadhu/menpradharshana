// ignore_for_file: camel_case_types

import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:menpradharshana/screens/main/about.dart';
import 'package:menpradharshana/screens/main/home_screen.dart';
import 'package:menpradharshana/screens/main/leaderboard_screen.dart';
import 'package:menpradharshana/screens/main/profile_screen.dart';

class Main_Screen extends StatefulWidget {
  const Main_Screen({super.key});

  @override
  State<Main_Screen> createState() => _Main_ScreenState();
}

class _Main_ScreenState extends State<Main_Screen> {
  int _selectedIndex = 0;

  List<Widget> tabItems = [
    Home_Screen(),
    Leaderboard_Screen(),
    Profile_Screen(),
    Aboutpage()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: tabItems[_selectedIndex],
      ),
      bottomNavigationBar: FlashyTabBar(
        backgroundColor: Colors.blue[600],
        animationCurve: Curves.bounceIn,
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            activeColor: Colors.white,
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            title: Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
          ),
          FlashyTabBarItem(
            activeColor: Colors.white,
            icon: Icon(
              Icons.leaderboard,
              color: Colors.white,
            ),
            title: Text(
              'Leaderboard',
              style: TextStyle(color: Colors.white),
            ),
          ),
          FlashyTabBarItem(
            activeColor: Colors.white,
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            title: Text(
              'Account',
              style: TextStyle(color: Colors.white),
            ),
          ),
          FlashyTabBarItem(
            activeColor: Colors.white,
            icon: Icon(
              Icons.info,
              color: Colors.white,
            ),
            title: Text(
              'About',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
