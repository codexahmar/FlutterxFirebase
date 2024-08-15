import 'package:auth_practice/Screens/BottomNavbar/bottom_navbar.dart';
import 'package:auth_practice/Screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return BottomNavbar();
    } else {
      return LoginScreen();
    }
  }
}
