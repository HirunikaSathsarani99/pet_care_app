import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_care_app/view/style.dart';
import 'package:pet_care_app/view_model/auth_services.dart';
import 'package:pet_care_app/view_model/user_provider.dart';
import 'package:provider/provider.dart';
// Your style file for color details

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  // Controllers for email and password fields
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // For form validation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.grey[900], // Same dark background as in Register Screen
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30), // Padding around the screen content
          child: Form(
            key: _formKey, // Assign the form key
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Image.asset('assets/login_image.png'),
                      SizedBox(height: 15),
                      Text(
                        "Let's get Started",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Login to your account and manage your pet's profile",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),

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
                    return null;
                  },
                ),

                SizedBox(height: 30), // Space before button

                // Login Button
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        User? user =
                            await _authService.signInWithEmailAndPassword(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );

                        if (user != null) {
                          // Use the actual user ID here
                          final userProvider =
                              Provider.of<UserProvider>(context, listen: false);
                          await userProvider.setUserId();
                          Navigator.pushNamed(context, '/home');
                        } else {
                          // Show error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('Login failed. Please try again.')),
                          );
                        }
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
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20), // Space before register text

                // You haven't an account? Register here
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You haven't an account?",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context,
                              '/register'); // Navigate to register screen
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: AppColors
                                .ThemeColor, // Orange text for Register
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
      padding: const EdgeInsets.symmetric(vertical: 10),
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
          obscureText: isObscure,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Colors.white70),
            prefixIcon: Icon(icon, color: Colors.white70),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white70),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: AppColors.ThemeColor),
            ),
          ),
          style: TextStyle(color: Colors.white),
          validator: validator,
        ),
      ),
    );
  }
}
