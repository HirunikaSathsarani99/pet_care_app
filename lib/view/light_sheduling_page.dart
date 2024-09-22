import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_care_app/view/style.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet_care_app/view_model/pet_provider.dart'; 
import 'package:provider/provider.dart';

class LightSchedulingPage extends StatefulWidget {
  @override
  _LightSchedulingPageState createState() => _LightSchedulingPageState();
}

class _LightSchedulingPageState extends State<LightSchedulingPage> {
  bool _isLightOn = false;
  bool cleanLaterSelected = false;
  TimeOfDay? selectedTime;
  String? userId;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid; // Get the user ID
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Light Scheduling'),
        backgroundColor: AppColors.ThemeColor,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[900], // Background color
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Image.asset('assets/light.png', height: 300)),
            SizedBox(height: 30),
            Text(
              'Light is currently ${_isLightOn ? 'ON' : 'OFF'}',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text('Turn Light On/Off', style: TextStyle(color: Colors.white)),
              value: _isLightOn,
              onChanged: (bool value) {
                setState(() {
                  _isLightOn = value;
                });
                _setLightStatus(value); // Update the status in the database
              },
              activeColor: AppColors.ThemeColor,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  cleanLaterSelected = true; // Schedule Later selected
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: cleanLaterSelected
                    ? AppColors.ThemeColor
                    : Colors.grey[600],
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Schedule Later',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 30),
            if (cleanLaterSelected) _buildTimeSelection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Time:',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _selectTime(context); // Open time picker
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.ThemeColor,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  selectedTime != null
                      ? selectedTime!.format(context)
                      : 'Select Time',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: _saveScheduledTime,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.ThemeColor,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            'Save Time',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Future<void> _setLightStatus(bool status) async {
    // Assuming you have a provider to handle the light status
    final petProvider = Provider.of<PetProvider>(context, listen: false);
    await petProvider.setLightStatus(status, userId.toString()); // Save the light status in the database
  }

  Future<void> _saveScheduledTime() async {
    if (selectedTime != null) {
      // Convert selectedTime to an integer hour
      int scheduleHour = selectedTime!.hour;
      
      final petProvider = Provider.of<PetProvider>(context, listen: false);
      await petProvider.scheduleLight(
        userId: userId.toString(),
        scheduleTime: scheduleHour, // Pass the hour as an int
        scheduleNowEnabled: false,
      );
      Fluttertoast.showToast(
        msg: "Scheduled light time saved: $scheduleHour hours",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Please select a time first.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
      );
    }
  }
}