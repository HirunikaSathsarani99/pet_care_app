
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pet_care_app/model/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

    final FirebaseDatabase _database = FirebaseDatabase.instance;

 Future<User?> registerWithEmailAndPassword(
      String email, String password, PetInfo petInfo) async {
    print("Register function called");

    try {
      // Create user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get user ID
      String userId = userCredential.user?.uid ?? "";

      // Create UserDetails object (optional)
      UserDetails userDetails = UserDetails(
        userId: userId,
        email: email,
        petInfo: petInfo,
      );

      // Store user data in Realtime Database
      await _database.ref().child('Users').child(userId).set({
        'email': email,
        'petInfo': petInfo.toMap(),
      });

      print("User registered: ${userCredential.user?.email}");
      print("User ID: $userId");
      return userCredential.user;
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print("Error in registration: ${e.message}");
      }
      return null;
    } catch (e) {
      print("Error in registration: ${e.toString()}");
      return null;
    }
  }


  Future<User?> signInWithEmailAndPassword(String email, String password) async {
  print("Login function called");

  try {
    // Sign in the user with email and password
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // User is successfully logged in
    print("User logged in: ${userCredential.user?.email}");
    print("User ID: ${userCredential.user?.uid}");
    
    return userCredential.user;

  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    } else {
      print("Error in login: ${e.message}");
    }
    return null;
  } catch (e) {
    print("Error in login: ${e.toString()}");
    return null;
  }
}

}

  