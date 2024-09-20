import 'package:flutter/material.dart';
import 'package:pet_care_app/view/style.dart'; // Your style file for color details

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      body: Center(
        child: Padding(
          padding:  EdgeInsets.all(25.0),
          child: Container(
            padding: EdgeInsets.all(30), 
            decoration: BoxDecoration(
             color: Colors.black ,
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
                Spacer() ,
                Text(
                  "Smart Pet House",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold, 
                    color: Colors.white, 
                  ),
                ),
               Spacer() ,// Space between text and image
                Image.asset('assets/splash_image.png'),
                Spacer(), // Add your image asset here
               
                ElevatedButton(
                  onPressed: () {
                     Navigator.pushNamed(context, '/register'); // Navigate to login screen
                    
                    
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.ThemeColor, 
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded button corners
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Get Started',
                        style: TextStyle(
                          color: Colors.white, // Button text color
                          fontSize: 18, // Button text size
                        ),
                      ),
                      SizedBox(width: 15.0,),
                      Icon(Icons.arrow_circle_right,size: 50,color: Colors.white,)
                    ],
                  ),
                ),
                Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
