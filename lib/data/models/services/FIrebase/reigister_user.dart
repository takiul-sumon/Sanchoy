import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> registerUser({
  required String email,
  required String password,
  required String firstName,
  required String lastName,
  required String mobile,
}) async {
  try {
    // 1. Register user with email and password
    UserCredential userCred = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    // 2. Send email verification (OTP-style link)
    await userCred.user!.sendEmailVerification();

    // 3. Save additional info in Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCred.user!.uid)
        .set({
          'firstName': firstName,
          'lastName': lastName,
          'mobile': mobile,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        });

    print('User registered and verification email sent!');
  } catch (e) {
    print('Error: $e');
  }
}
