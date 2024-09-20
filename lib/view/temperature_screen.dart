import 'package:flutter/material.dart';
import 'package:pet_care_app/view/style.dart';

class TemperatureHumidityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Temperature and Humidity'),
      backgroundColor:AppColors.ThemeColor ,),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[900], // Background color
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          
          children: [
              Image.asset('assets/temp.png', height: 300),
            SizedBox(height: 30),
            _buildInfoBox(Icons.thermostat, 'Temperature', '25°C'),
            SizedBox(height: 20),
            _buildInfoBox(Icons.water, 'Humidity', '60%'),
          ],
        ),
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
