import 'package:flutter/material.dart';
import 'package:pet_care_app/view/style.dart'; // Assuming your style file is here

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850], // Dark grey background
      appBar: AppBar(
        backgroundColor: AppColors.ThemeColor,
        title: Text("Pet Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Handle logout
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Pet Image and details
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/pet_image.png'), // Hardcoded image
            ),
            SizedBox(height: 20),
            Text(
              'Buddy', // Hardcoded pet name
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Age: 2 years', // Hardcoded pet age
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            SizedBox(height: 5),
            Text(
              'Height: 50 cm', // Hardcoded pet height
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            SizedBox(height: 5),
            Text(
              'Weight: 10 kg', // Hardcoded pet weight
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            SizedBox(height: 30),
            // Options like automatic cleaning, light scheduling, food levels
            _buildOptionBox(Icons.cleaning_services, 'Automatic Cleaning'),
            _buildOptionBox(Icons.lightbulb, 'Light Scheduling'),
            _buildOptionBox(Icons.fastfood, 'Food Levels'),
            SizedBox(height: 30),
           
          ],
        ),
      ),
    );
  }

  // Widget to build option boxes
  Widget _buildOptionBox(IconData icon, String title) {
    return Container(
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
    );
  }
}
