import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pet_care_app/view/style.dart';

class TemperatureHumidityPage extends StatefulWidget {
  @override
  _TemperatureHumidityPageState createState() => _TemperatureHumidityPageState();
}

class _TemperatureHumidityPageState extends State<TemperatureHumidityPage> {
  String? userId; // Declare without initialization
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid; // Assign user ID
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature and Humidity'),
        backgroundColor: AppColors.ThemeColor,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[900],
        ),
        child: userId != null
            ? StreamBuilder<DatabaseEvent>(
                stream: _databaseRef.child('Users/$userId/petInfo').onValue,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
                    return Center(child: Text('No data available'));
                  }

                  final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                  final temperature = data['temperature'] ?? 'N/A';
                  final humidity = data['humidity'] ?? 'N/A';

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/temp.png', height: 300),
                      SizedBox(height: 30),
                      _buildInfoBox(Icons.thermostat, 'Temperature', '$temperature°C'),
                      SizedBox(height: 20),
                      _buildInfoBox(Icons.water, 'Humidity', '$humidity%'),
                    ],
                  );
                },
              )
            : Center(child: Text('User not logged in')),
      ),
    );
  }

  Widget _buildInfoBox(IconData icon, String title, String value) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.ThemeColor, size: 30),
              SizedBox(width: 20),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
