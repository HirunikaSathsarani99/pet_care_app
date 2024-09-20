import 'package:flutter/material.dart';

import 'package:pet_care_app/view/style.dart'; // Assuming your style file is here

class AutomaticCleaningPage extends StatefulWidget {
  @override
  _AutomaticCleaningPageState createState() => _AutomaticCleaningPageState();
}

class _AutomaticCleaningPageState extends State<AutomaticCleaningPage> {
  bool cleanLaterSelected = false;
  TimeOfDay? selectedTime;

  // Function to handle time picker
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: Text('Automatic Cleaning'),
        backgroundColor: AppColors.ThemeColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set Automatic Cleaning Time',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      cleanLaterSelected = false; 
                    });
                    // Handle Clean Now functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:cleanLaterSelected?Colors.grey[600]: AppColors.ThemeColor,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Clean Now',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
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
                    'Clean Later',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
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
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _selectTime(context); // Open time picker
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.ThemeColor,
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
          ],
        ),
      ),
    );
  }
}
