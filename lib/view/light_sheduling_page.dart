import 'package:flutter/material.dart';
import 'package:pet_care_app/view/style.dart';

class LightSchedulingPage extends StatefulWidget {
  @override
  _LightSchedulingPageState createState() => _LightSchedulingPageState();
}

class _LightSchedulingPageState extends State<LightSchedulingPage> {
  bool _isLightOn = false;
  bool cleanLaterSelected = false;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Light Scheduling'),
       backgroundColor: AppColors.ThemeColor,),
     
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[900], // Background color
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              },
              activeColor: AppColors.ThemeColor,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  cleanLaterSelected = true; // Clean Later selected
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
            if (cleanLaterSelected)
              Column(
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
          ],
        ),
      ),
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
}
