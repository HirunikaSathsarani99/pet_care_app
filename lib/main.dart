import 'package:flutter/material.dart';
import 'package:pet_care_app/view/home_screen.dart';
import 'package:pet_care_app/view/login_screen.dart';
import 'package:pet_care_app/view/registration_screen.dart';
import 'package:pet_care_app/view/spalsh_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Care',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home:  SplashScreen(),
       routes: {
      '/register': (context) => RegisterScreen(), 
      '/login': (context) => LoginScreen(), 
       '/home': (context) => HomeScreen(), 
    },
    );
  }
}
