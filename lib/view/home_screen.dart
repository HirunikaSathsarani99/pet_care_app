import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_care_app/view_model/pet_provider.dart';
import 'package:provider/provider.dart';
import 'package:pet_care_app/view/style.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    final petProvider = Provider.of<PetProvider>(context, listen: false);

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid; // Get the user ID

      // Fetch pet info using the userId
      petProvider.fetchPetInfo(userId);
    }
  }

  

  @override
  Widget build(BuildContext context) {
    final petProvider = Provider.of<PetProvider>(context);
    final petInfo = petProvider.petInfo;


    int calculateAge(DateTime birthdate) {
      final today = DateTime.now();
      int age = today.year - birthdate.year;

      if (today.month < birthdate.month ||
          (today.month == birthdate.month && today.day < birthdate.day)) {
        age--;
      }

      return age;
    }

    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: AppColors.ThemeColor,
        title: Text("Pet Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut(); // Sign out the user
                // Optionally, navigate to the splash screen or login screen
                Navigator.pushReplacementNamed(context, '/register');
              } catch (e) {
                // Handle any errors that occur during logout
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logout failed: ${e.toString()}')),
                );
              }
            },
          ),
        ],
      ),
      body: petProvider.petInfo == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                        petInfo?.imageUrl ?? 'assets/app_icon.png'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    petInfo?.petName ?? 'Buddy',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                   Text(
                    'Age: ${calculateAge(petInfo!.birthdate)} years',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Height: ${petInfo?.height ?? 'N/A'} cm',
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Weight: ${petInfo?.weight ?? 'N/A'} kg',
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                  SizedBox(height: 30),
                  _buildOptionBox(context, Icons.cleaning_services,
                      'Automatic Cleaning', '/automatic Cleaning'),
                  _buildOptionBox(context, Icons.lightbulb, 'Llight sheduling',
                      '/light sheduling'),
                  _buildOptionBox(
                      context, Icons.fastfood, 'Food Levels', '/food level'),
                  _buildOptionBox(context, Icons.thermostat,
                      'Temperature and Humidity', '/temerature'),
                  SizedBox(height: 30),
                ],
              ),
            ),
    );
  }

  Widget _buildOptionBox(
      BuildContext context, IconData icon, String title, String routeName) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Container(
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
      ),
    );
  }
}
