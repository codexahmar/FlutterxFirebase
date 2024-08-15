import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // Drawer header
              DrawerHeader(
                  child: Icon(
                Icons.favorite,
                color: Theme.of(context).colorScheme.inversePrimary,
              )),
              SizedBox(
                height: 25,
              ),
              // Home Tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text('H O M E'),
                  onTap: () {
                    // This is already home page so just pop the screen
                    Navigator.pop(context);
                  },
                ),
              ),
              // Profile Tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('P R O F I L E'),
                  onTap: () {
                    // Pop drawer
                    Navigator.pop(context);

                    // Navigate to Settings page
                    Navigator.pushNamed(context, "/profile_page");
                  },
                ),
              ),
              // Settings Tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(Icons.group),
                  title: Text('U S E R S'),
                  onTap: () {
                    // Pop drawer
                    Navigator.pop(context);

                    // Navigate to Settings page
                    Navigator.pushNamed(context, "/users_page");
                  },
                ),
              ),
            ],
          ),
          // Logout Tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25),
            child: ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('L O G O U T'),
              onTap: () {
                // Pop drawer
                Navigator.pop(context);

                // Logout

                signOut();
              },
            ),
          )
        ],
      ),
    );
  }
}
