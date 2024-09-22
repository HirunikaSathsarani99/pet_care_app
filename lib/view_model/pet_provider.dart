import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pet_care_app/model/user_model.dart';
import 'package:pet_care_app/view_model/user_provider.dart';
import 'package:provider/provider.dart';

class PetProvider with ChangeNotifier {
  PetInfo? _petInfo;
  String? _userId;

  PetInfo? get petInfo => _petInfo;



  Future<void> fetchPetInfo(String _userId) async {
    if (_userId == null) return; // Ensure userId is set

    try {
      final DatabaseReference ref = FirebaseDatabase.instance.ref('Users/$_userId/petInfo');
      final DatabaseEvent event = await ref.once();

      if (event.snapshot.exists) {
        final data = event.snapshot.value as Map<dynamic, dynamic>?;
        if (data != null) {
          _petInfo = PetInfo.fromMap(data);
          notifyListeners();
        }
      }
    } catch (e) {
      print('Error fetching pet info: $e');
    }
  }

Future<void> setCleanNow(String userId) async {
    if (userId == null) return; // Ensure userId is set

    try {
      final DatabaseReference ref = FirebaseDatabase.instance.ref('Users/$userId/petInfo/automaticCleaning');
      await ref.set({
        'scheduleNowEnabled': true,
        'scheduleTime': 0, 
      });
      notifyListeners(); // Notify listeners if necessary
    } catch (e) {
      print('Error updating automatic cleaning: $e');
    }
  }

Future<void> setCleanLater(String userId, int scheduleTime) async {
  if (userId == null) return; // Ensure userId is set

  try {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('Users/$userId/petInfo/automaticCleaning');
    await ref.set({
      'scheduleNowEnabled': false,
      'scheduleTime': scheduleTime, // Save hour as int
    });
    notifyListeners(); // Notify listeners if necessary
  } catch (e) {
    print('Error updating automatic cleaning: $e');
  }
}


//Light set

  Future<void> setLightStatus(bool status, String userId) async {
    try {
      final DatabaseReference ref = FirebaseDatabase.instance.ref('Users/$userId/petInfo/lightSchedule');
      await ref.set({
        'scheduleNowEnabled': status,
      });
      notifyListeners();
    } catch (e) {
      print('Error updating light status: $e');
    }
  }

  Future<void> scheduleLight({
  required String userId,
  required int scheduleTime, // Accepting int for scheduleTime
  required bool scheduleNowEnabled,
}) async {
  try {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('Users/$userId/petInfo/lightSchedule');
    await ref.set({
      'scheduleNowEnabled': scheduleNowEnabled,
      'scheduleTime': scheduleTime, // Storing scheduleTime as an int
    });
    notifyListeners();
  } catch (e) {
    print('Error scheduling light: $e');
  }
}
}
