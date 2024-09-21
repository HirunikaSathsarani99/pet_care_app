import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_care_app/view/style.dart';

class SplashScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // Check if the user is logged in and navigate after a delay
    _auth.authStateChanges().listen((User? user) {
      Future.delayed(const Duration(seconds: 2), () {
        if (user != null) {
          // User is logged in, navigate to home
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          // User is not logged in, navigate to register
          Navigator.pushReplacementNamed(context, '/register');
        }
      });
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.7),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Spacer(),
                const Text(
                  "Smart Pet House",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                Image.asset('assets/splash_image.png'),
                Spacer(),
                // The button will not be shown since we are handling navigation automatically
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
