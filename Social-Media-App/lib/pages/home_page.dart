import 'package:flutter/material.dart';
import 'package:social_media_app/components/my_drawer.dart';
import 'package:social_media_app/components/my_list_tile.dart';
import 'package:social_media_app/components/my_post_button.dart';
import 'package:social_media_app/components/my_text_field.dart';
import 'package:social_media_app/database/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Firestore access
  final FireStoreDatabase database = FireStoreDatabase();
  final TextEditingController newPostController = TextEditingController();

  // post message function
  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
      newPostController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text("W A L L"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(
                      hintText: "Say Something...",
                      controller: newPostController,
                      obscureText: false),
                ),
                // post button
                MyPostButton(
                  onTap: postMessage,
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          // POSTS
          StreamBuilder(
            stream: database.getPostStream(),
            builder: (context, snapshot) {
              // show loading indicator
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              // get all posts
              final posts = snapshot.data!.docs;
              // no data?
              if (snapshot.data == null || posts.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text("No posts.. Post something!"),
                  ),
                );
              }
              // return as a list

              return Expanded(
                  child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        // Get individual posts
                        final post = posts[index];
                        // Get data from each post
                        String message = post["postMessage"];
                        String userEmail = post["userEmail"];

                        // return as a list tile
                        return MyListTile(title: message, subTitle: userEmail);
                      }));
            },
          )
        ],
      ),
    );
  }
}
