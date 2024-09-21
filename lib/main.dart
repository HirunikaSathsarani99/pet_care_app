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
import 'package:pet_care_app/view_model/pet_provider.dart';
import 'package:pet_care_app/view_model/user_provider.dart';

import 'package:provider/provider.dart'; 


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    
    options: FirebaseOptions(apiKey: "AIzaSyBn-9095Ja5UIFJJMybrb4f2gbP6ruhU0U", 
    appId: "1:439130516692:android:6956e9539d8e438b379f41", 
    messagingSenderId: "439130516692", 
    projectId: "pet-home-app-bc6e3"
    )
    
  );
 runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PetProvider()), 
         ChangeNotifierProvider(create: (context) => UserProvider()), 
   
      ],
      child: MyApp(),
    ),
  );
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
      '/automatic Cleaning': (context) => AutomaticCleaningPage(), 
      '/light sheduling': (context) => LightSchedulingPage(), 
      '/temerature': (context) => TemperatureHumidityPage(), 
      '/food level': (context) => FoodLevelPage(),
    },
    );
  }
}
