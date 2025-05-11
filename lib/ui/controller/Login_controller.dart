import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  String? errorMessage;

  Future<bool> login(String email, String password) async {
    try {
      // Sign in with Firebase
      UserCredential userCred = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Optional: Check if the email is verified
      if (!userCred.user!.emailVerified) {
        errorMessage = "Please verify your email before logging in.";
        return false;
      }

      return true;
    } on FirebaseAuthException catch (e) {
      errorMessage = _getFriendlyError(e);
      return false;
    }
  }

  String _getFriendlyError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return "No user found for that email.";
      case 'wrong-password':
        return "Wrong password provided.";
      case 'invalid-email':
        return "Invalid email address.";
      default:
        return e.message ?? "An error occurred.";
    }
  }
}
