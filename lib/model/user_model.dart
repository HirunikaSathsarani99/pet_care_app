class UserDetails {
  final String userId;
  final String email;
  final PetInfo petInfo;

  UserDetails({
    required this.userId,
    required this.email,
    required this.petInfo,
  });
}

class PetInfo {
  final String petName;
  final String imageUrl;

  final String weight;
  final String height;
  final LightSchedule lightSchedule;
  final AutomaticCleaning automaticCleaning;
  final double temperature;
  final double humidity;

  PetInfo({
    required this.petName,
    required this.imageUrl,
    
    required this.weight,
    required this.height,
    required this.lightSchedule,
    required this.automaticCleaning,
    required this.temperature,
    required this.humidity,
  });

  Map<String, dynamic> toMap() {
    return {
      'petName': petName,
      'imageUrl': imageUrl,
     
      'weight': weight,
      'height': height,
      'lightSchedule': lightSchedule.toMap(),
      'automaticCleaning': automaticCleaning.toMap(),
      'temperature': temperature,
      'humidity': humidity,
    };
  }
}

class LightSchedule {
  final bool scheduleNowEnabled;
  final String scheduleTime;

  LightSchedule({required this.scheduleNowEnabled, required this.scheduleTime});

  Map<String, dynamic> toMap() {
    return {
      'scheduleNowEnabled': scheduleNowEnabled,
      'scheduleTime': scheduleTime,
    };
  }
}

class AutomaticCleaning {
  final bool scheduleNowEnabled;
  final String scheduleTime;

  AutomaticCleaning({required this.scheduleNowEnabled, required this.scheduleTime});

  Map<String, dynamic> toMap() {
    return {
      'scheduleNowEnabled': scheduleNowEnabled,
      'scheduleTime': scheduleTime,
    };
  }
}
