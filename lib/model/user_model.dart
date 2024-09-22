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
  final DateTime birthdate;
  final int foodScope;  

  PetInfo({
    required this.petName,
    required this.imageUrl,
    required this.weight,
    required this.height,
    required this.lightSchedule,
    required this.automaticCleaning,
    required this.temperature,
    required this.humidity,
    required this.birthdate,
    required this.foodScope,  
  });

  factory PetInfo.fromMap(Map<dynamic, dynamic> map) {
    return PetInfo(
      petName: map['petName'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      weight: map['weight'] ?? '',
      height: map['height'] ?? '',
      lightSchedule: LightSchedule.fromMap(map['lightSchedule'] ?? {}),
      automaticCleaning: AutomaticCleaning.fromMap(map['automaticCleaning'] ?? {}),
      temperature: (map['temperature'] as num?)?.toDouble() ?? 0.0,
      humidity: (map['humidity'] as num?)?.toDouble() ?? 0.0,
      birthdate: DateTime.parse(map['birthdate']),
      foodScope: map['foodScoope'] ?? 1,  
    );
  }

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
      'birthdate': birthdate.toIso8601String(),
      'foodScoope': foodScope,  
    };
  }
}


class LightSchedule {
  final bool scheduleNowEnabled;
  final int scheduleTime; 

  LightSchedule({
    required this.scheduleNowEnabled,
    required this.scheduleTime,
  });

  factory LightSchedule.fromMap(Map<dynamic, dynamic> map) {
    return LightSchedule(
      scheduleNowEnabled: map['scheduleNowEnabled'] ?? false,
      scheduleTime: map['scheduleTime'] ?? 0, 
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'scheduleNowEnabled': scheduleNowEnabled,
      'scheduleTime': scheduleTime,
    };
  }
}


class AutomaticCleaning {
  final bool scheduleNowEnabled;
  final int scheduleTime; // Changed from String to int

  AutomaticCleaning({
    required this.scheduleNowEnabled,
    required this.scheduleTime,
  });

  factory AutomaticCleaning.fromMap(Map<dynamic, dynamic> map) {
    return AutomaticCleaning(
      scheduleNowEnabled: map['scheduleNowEnabled'] ?? false,
      scheduleTime: (map['scheduleTime'] as num?)?.toInt() ?? 0, // Handle as int
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'scheduleNowEnabled': scheduleNowEnabled,
      'scheduleTime': scheduleTime,
    };
  }
}