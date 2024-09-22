import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet_care_app/view/style.dart';
import 'package:pet_care_app/view_model/pet_provider.dart';
import 'package:provider/provider.dart';

class AutomaticCleaningPage extends StatefulWidget {
  @override
  _AutomaticCleaningPageState createState() => _AutomaticCleaningPageState();
}

class _AutomaticCleaningPageState extends State<AutomaticCleaningPage> {
  String? userId;

  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid; // Get the user ID
    }
  }

  bool cleanLaterSelected = false;
  TimeOfDay? selectedTime;

  // Function to handle time picker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _handleCleaningAction(bool isCleanNow) {
    if (isCleanNow) {
      // Update database for immediate cleaning
      _setCleanNow();
    } else {
      // Open time picker for scheduled cleaning
      _selectTime(context);
    }
  }

  Future<void> _setCleanNow() async {
    final petProvider = Provider.of<PetProvider>(context, listen: false);
    if (userId != null) {
      await petProvider.setCleanNow(userId!);
      Fluttertoast.showToast(
        msg: "Automatic cleaning enabled now.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
      );
    }
  }

  Future<void> _saveScheduledTime() async {
    final petProvider = Provider.of<PetProvider>(context, listen: false);

    if (selectedTime != null) {
      int scheduleHour = selectedTime!.hour; // Save only the hour
      await petProvider.setCleanLater(userId!, scheduleHour);
      Fluttertoast.showToast(
        msg: "Scheduled cleaning time saved: $scheduleHour:00",
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
            Center(child: Image.asset('assets/cleaning_image.png', height: 300)),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton('Clean Now', true),
                _buildActionButton('Clean Later', false),
              ],
            ),
            SizedBox(height: 30),
            if (cleanLaterSelected) _buildTimeSelection(),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String title, bool isCleanNow) {
    return ElevatedButton(
      onPressed: () {
        _handleCleaningAction(isCleanNow);
        if (!isCleanNow) {
          setState(() {
            cleanLaterSelected = true; // Only allow selecting time if "Clean Later" is clicked
          });
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: cleanLaterSelected == !isCleanNow
            ? AppColors.ThemeColor
            : Colors.grey[600],
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  Widget _buildTimeSelection() {
    return Column(
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                selectedTime != null ? '${selectedTime!.hour}:00' : 'Select Time',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: _saveScheduledTime,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.ThemeColor,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
        ),
      ],
    );
  }
}
