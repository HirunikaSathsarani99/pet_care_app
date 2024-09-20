import 'package:flutter/material.dart';
import 'package:pet_care_app/view/style.dart'; 

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850], 
      appBar: AppBar(
        backgroundColor: AppColors.ThemeColor,
        title: Text("Pet Profile"),
        actions: [
          //log out 
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
             
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/pet_image.png'),
            ),
            SizedBox(height: 20),
            Text(
              'Buddy', 
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Age: 2 years', 
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            SizedBox(height: 5),
            Text(
              'Height: 50 cm', 
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            SizedBox(height: 5),
            Text(
              'Weight: 10 kg', 
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            SizedBox(height: 30),
           
            _buildOptionBox(context, Icons.cleaning_services, 'Automatic Cleaning', '/automatic Cleaning'),
            _buildOptionBox(context, Icons.lightbulb, 'Light Scheduling', '/light sheduling'),
            _buildOptionBox(context, Icons.fastfood, 'Food Levels', '/food level'),
            _buildOptionBox(context, Icons.thermostat, 'Temperature and Humidity', '/temerature'),
            SizedBox(height: 30),
           
          ],
        ),
      ),
    );
  }


  Widget _buildOptionBox(BuildContext contex,IconData icon, String title, String routeName) {
    return GestureDetector(
       onTap: () {
    
        Navigator.pushNamed(contex, routeName);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[700],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.ThemeColor, size: 30),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
