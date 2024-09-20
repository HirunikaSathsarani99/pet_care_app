import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pet_care_app/view/automatic_cleaning_page.dart';
import 'package:pet_care_app/view/food_level_page.dart';
import 'package:pet_care_app/view/home_screen.dart';
import 'package:pet_care_app/view/light_sheduling_page.dart';
import 'package:pet_care_app/view/login_screen.dart';
import 'package:pet_care_app/view/registration_screen.dart';
import 'package:pet_care_app/view/spalsh_screen.dart';
import 'package:pet_care_app/view/temperature_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'AIzaSyDpmwPSMUqrzzz-Oe4GC6UW-JEzwgtMpd4',
    appId: '1:535515887435:android:f240e863cd3cf9703c5ace',
    messagingSenderId: '535515887435',
    projectId: 'pet-care-app-2634d',
    storageBucket: 'pet-care-app-2634d.appspot.com',
  ));

  runApp(MyApp());
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
      home: SplashScreen(),
      routes: {
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/automatic Cleaning': (context) => AutomaticCleaningPage(),
        '/light sheduling': (context) => LightSchedulingPage(),
        '/temerature': (context) => TemperatureHumidityPage(),
        '/food level': (context) => FoodLevelPage(),
      },
    );
  }
}
