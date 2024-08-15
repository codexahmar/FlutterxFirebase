import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/my_button.dart';
import 'package:social_media_app/components/my_text_field.dart';
import 'package:social_media_app/helper/helper_functions.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

// Register Function
  void register() async {
    // show loading indicator
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    // make sure password matches
    if (passwordController.text != confirmPassController.text) {
      // Pop Loading circle
      Navigator.pop(context);
      // Show error message
      displayErrorMessageToUser("Passwords dont match!", context);
    }
    // Try creating a new user if password matches
    else {
      try {
        // Create the user
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim());
        // create a user document and add to firestore
        createUserDocument(userCredential);
        // pop the loading indicator
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // pop the loading indicator
        Navigator.pop(context);

        // Display error message
        displayErrorMessageToUser(e.code, context);
      }
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential?.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential?.user!.email)
          .set({
        'email': userCredential?.user!.email,
        "username": userNameController.text
       });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),

                SizedBox(
                  height: 25,
                ),
                // App Name
                Text(
                  "M I N I M A L  S O C I A L  A P P",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 50,
                ),
                // Username text field
                MyTextField(
                    hintText: "Name",
                    controller: userNameController,
                    obscureText: false),
                SizedBox(
                  height: 15,
                ),
                // Email text field
                MyTextField(
                    hintText: "Email",
                    controller: emailController,
                    obscureText: false),
                SizedBox(
                  height: 15,
                ),
                // Password text field
                MyTextField(
                    hintText: "Password",
                    controller: passwordController,
                    obscureText: true),

                // Email text field
                SizedBox(
                  height: 15,
                ),
                MyTextField(
                    hintText: "Confirm Password",
                    controller: confirmPassController,
                    obscureText: true),

                // Forgot password text

                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot password?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                // Sign In Button
                MyButton(text: "Login", onTap: register),
                SizedBox(
                  height: 15,
                ),
                // Dont have an account?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.inversePrimary)),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        " Login here",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
