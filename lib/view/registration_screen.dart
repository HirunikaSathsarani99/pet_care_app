import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_care_app/model/user_model.dart';
import 'package:pet_care_app/view/style.dart';
import 'package:pet_care_app/view_model/auth_services.dart'; // Your style file for color details

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _authService = AuthService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController petNameController = TextEditingController();
  TextEditingController birthdateController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  bool _isLoading = false;

  String? petImagePath; // For storing pet image path

  final _formKey = GlobalKey<FormState>(); // For form validation

  // Function to open date picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        birthdateController.text =
            "${picked.toLocal()}".split(' ')[0]; // Format the date
      });
    }
  }

  // Function to open file picker for pet image
  Future<void> _pickPetImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        petImagePath = result.files.single.path; // Save file path
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Same dark background
      body: Center(
        child: SingleChildScrollView(
          // Allows scrolling for smaller screens
          padding: EdgeInsets.all(30), // Padding around the screen content
          child: Form(
            key: _formKey, // Assign the form key
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align content to the left
              children: [
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                          'assets/register_image.png'), // Replace with your image asset
                      SizedBox(height: 20),
                      Text(
                        "Let's get Started",
                        style: TextStyle(
                          fontSize: 28, // Large heading text
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Create your account and manage your pet's profile",
                        style: TextStyle(
                          fontSize: 16, // Informational text
                          color: Colors
                              .white70, // Slightly transparent white for secondary text
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30), // Space between header and form

                // Email and Password Fields
                _buildTextField(
                  "Email",
                  Icons.email,
                  emailController,
                  false,
                  TextInputType.emailAddress,
                  false,
                  (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  "Password",
                  Icons.lock,
                  passwordController,
                  true,
                  TextInputType.text,
                  true,
                  (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    if (value.length < 5) {
                      return "Password must be a maximum of 5 characters";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20), // Space before Pet Info section
                Text(
                  "Pet Info",
                  style: TextStyle(
                    fontSize: 18, // Section heading text
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),

                // Pet Name, Pet Image, Birthdate, Height, Weight Fields
                _buildTextField(
                  "Pet Name",
                  Icons.pets,
                  petNameController,
                  false,
                  TextInputType.text,
                  false,
                  (value) {
                    if (value == null || value.isEmpty) {
                      return "Pet Name is required";
                    }
                    return null;
                  },
                ),

                // Pet Image Picker Field
                GestureDetector(
                  onTap: _pickPetImage,
                  child: AbsorbPointer(
                    // Prevent manual typing
                    child: _buildTextField(
                      "Pet Image (optional)",
                      Icons.image,
                      TextEditingController(text: petImagePath ?? ""),
                      false,
                      TextInputType.text,
                      false,
                      null,
                    ),
                  ),
                ),

                // Birthdate Field - Opens a date picker
                GestureDetector(
                  onTap: () {
                    _selectDate(context); // Open the date picker
                  },
                  child: AbsorbPointer(
                    // Prevent manual typing
                    child: _buildTextField(
                      "Birthdate",
                      Icons.calendar_today,
                      birthdateController,
                      false,
                      TextInputType.datetime,
                      false,
                      (value) {
                        if (value == null || value.isEmpty) {
                          return "Birthdate is required";
                        }
                        return null;
                      },
                    ),
                  ),
                ),

                _buildTextField(
                  "Height (cm)",
                  Icons.height,
                  heightController,
                  false,
                  TextInputType.number,
                  false,
                  (value) {
                    if (value == null || value.isEmpty) {
                      return "Height is required";
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  "Weight (kg)",
                  Icons.fitness_center,
                  weightController,
                  false,
                  TextInputType.number,
                  false,
                  (value) {
                    if (value == null || value.isEmpty) {
                      return "Weight is required";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 30), // Space before button

                // Create Account Button
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _isLoading = true; // Start loading
                      });
                      // Create LightSchedule and AutomaticCleaning objects
                      LightSchedule lightSchedule = LightSchedule(
                        scheduleNowEnabled: false,
                        scheduleTime: " ",
                      );

                      AutomaticCleaning automaticCleaning = AutomaticCleaning(
                        scheduleNowEnabled: false,
                        scheduleTime: " ",
                      );

                      PetInfo petInfo = PetInfo(
                          petName: petNameController.text,
                          imageUrl: "petImageUrl",
                       
                          weight: weightController.text,
                          height: heightController.text,
                          lightSchedule: lightSchedule,
                          automaticCleaning: automaticCleaning,
                          temperature: 0.0,
                          humidity: 0.0);

                      User? user =
                          await _authService.registerWithEmailAndPassword(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                        petInfo
                      );

                      setState(() {
                        _isLoading = false; // Stop loading
                      });

                      if (user != null) {
                        // If registration is successful, navigate to the login screen
                        Navigator.pushNamed(context, '/login');
                      } else {
                        // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Registration failed. Please try again.')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          AppColors.ThemeColor, // Orange color from style file
                      padding:
                          EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20), // Space before login text

                // Already have an account? Login here
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Colors.white70, // Secondary text color
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, '/login'); // Navigate to login screen
                        },
                        child: Text(
                          "Login here",
                          style: TextStyle(
                            color:
                                AppColors.ThemeColor, // Orange text for Login
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Custom reusable method for creating text fields
  Widget _buildTextField(
    String label,
    IconData icon,
    TextEditingController controller,
    bool isPassword,
    TextInputType keyboardType,
    bool isObscure,
    String? Function(String?)? validator,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10), // Space between fields
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          obscureText: isObscure, // If the field is for password, hide text
          keyboardType: keyboardType, // Set the keyboard type
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Colors.white70), // Label text color
            prefixIcon: Icon(icon, color: Colors.white70), // Icon color
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white70),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide:
                  BorderSide(color: AppColors.ThemeColor), // Focused color
            ),
          ),
          style: TextStyle(color: Colors.white), // Text field input color
          validator: validator, // Validation function
        ),
      ),
    );
  }
}
