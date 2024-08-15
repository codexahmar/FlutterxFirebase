import 'package:auth_practice/Screens/BottomNavbar/Person%20Screen/person_screen.dart';
import 'package:auth_practice/Screens/BottomNavbar/Users%20Screen/users_profile.dart';
import 'package:auth_practice/Screens/BottomNavbar/settings%20Screen/settings_screen.dart';
import 'package:auth_practice/Screens/home_screen.dart';

import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  var selectedIndex = 0;
  List<Widget> tabs = [];

  void onTap(index) {
    selectedIndex = index;
    setState(() {});
  }

  @override
  void initState() {
    tabs = [HomeScreen(), PersonScreen(), SettingsScreen(), UsersProfile()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => onTap(index),
        backgroundColor: Colors.white,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        iconSize: 28,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: "Users",
          ),
        ],
      ),
      body: tabs[selectedIndex],
    );
  }
}
