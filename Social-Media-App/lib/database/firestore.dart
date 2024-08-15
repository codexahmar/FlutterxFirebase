import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*
This database stores post that users have published in the app.
it is stored in a collection called "Posts" in firebase.

Each post document has the following structure:

- a message
- an Email address
- a timestamp
*/

class FireStoreDatabase {
  // current logged in user
  User? user = FirebaseAuth.instance.currentUser;
  // get collection of posts from firebase
  final CollectionReference posts =
      FirebaseFirestore.instance.collection("Posts");

  // Post the message

  Future<void> addPost(String message) {
    return posts.add({
      "userEmail": user?.email,
      "postMessage": message,
      "Timestamp": Timestamp.now()
    });
  }

  // read posts from firebase
  Stream<QuerySnapshot> getPostStream() {
    final postStream = FirebaseFirestore.instance
        .collection("Posts")
        .orderBy("Timestamp", descending: true)
        .snapshots();
    return postStream;
  }
}
