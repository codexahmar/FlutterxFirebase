import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/my_back_button.dart';
import 'package:social_media_app/components/my_list_tile.dart';
import 'package:social_media_app/helper/helper_functions.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          // any errors
          if (snapshot.hasError) {
            displayErrorMessageToUser("Something went wrong", context);
          }
          // show loading screen
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == null) {
            return Text("No User found");
          }
          // get all users
          if (snapshot.hasData) {
            final users = snapshot.data!.docs;
            return Column(
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

                // List of users in the app
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      // get data from each user
                      String username = user["username"];
                      String email = user["email"];
                      return MyListTile(title: username, subTitle: email);
                    },
                  ),
                ),
              ],
            );
          } else {
            return Text("No data available");
          }
        },
      ),
    );
  }
}
