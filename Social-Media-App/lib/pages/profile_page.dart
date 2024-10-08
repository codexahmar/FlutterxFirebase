import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/my_back_button.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  // current logged in user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // Future to fetch user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (context, snapshot) {
          // loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          // error
          else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          // data received
          else if (snapshot.hasData) {
            // extract data
            final Map<String, dynamic>? user = snapshot.data!.data();
            return Center(
              child: Column(
                children: [
                  // back button
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, left: 20),
                    child: Row(
                      children: [
                        MyBackButton(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  // profile pic
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(24)),
                    child: Icon(
                      Icons.person,
                      size: 64,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  // username

                  Text(
                    user!["username"],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  // user email
                  Text(
                    user["email"],
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          } else {
            return Text("No data found");
          }
        },
      ),
    );
  }
}
