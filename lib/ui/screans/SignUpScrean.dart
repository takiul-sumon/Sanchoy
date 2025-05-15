import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sanchoy/ui/screans/Login_screan.dart';
import 'package:sanchoy/ui/widgets/SnackBarMessenger.dart';

class SignUpScrean extends StatefulWidget {
  const SignUpScrean({super.key});

  @override
  State<SignUpScrean> createState() => _SignUpScreanState();
}

class _SignUpScreanState extends State<SignUpScrean> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lasttNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _regristrationInProgress = false;
  List<bool> _isSelected = [false, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(child: Image.asset('assets/images/sign_up.png')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ToggleButtons(
                      isSelected: _isSelected,
                      onPressed: (index) {
                        setState(() {
                          if (index == 0) {
                            _isSelected = [true, false]; // Switch to Sign In
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          } else {
                            _isSelected = [false, true]; // Stay on Sign Up
                          }
                        });
                      },
                      borderRadius: BorderRadius.circular(10),
                      fillColor: Colors.lightBlue.shade100,
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Text('Sign In'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Text('Sign Up'),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Image.asset('assets/icons/User.png'),
                    hintText: 'First Name',
                  ),
                  controller: _firstNameController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 5),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Image.asset('assets/icons/User.png'),
                    hintText: 'Last Name',
                  ),
                  controller: _lasttNameController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Image.asset('assets/icons/Email.png'),
                    hintText: 'Email',
                  ),
                  validator: (String? value) {
                    String email = value?.trim() ?? '';
                    if (EmailValidator.validate(email) == false ||
                        email.isEmpty == true) {
                      return "Enter a Valid Email";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  controller: _emailController,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Image.asset('assets/icons/Iphone.png'),
                    hintText: 'Phone',
                  ),
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    String number = value?.trim() ?? '';
                    RegExp regEx = RegExp(r'^(?:\+?88)?01[3-9]\d{8}$');

                    if (number.isEmpty) {
                      return "Phone number is required";
                    } else if (!regEx.hasMatch(number)) {
                      return "Enter a valid Bangladeshi mobile number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Image.asset('assets/icons/view.png'),
                      onPressed: () {},
                    ),
                    hintText: 'Password',
                    prefixIcon: Image.asset('assets/icons/lock.png'),
                  ),
                  controller: _passwordController,
                  validator: (String? value) {
                    if (value?.isEmpty == true || value!.length < 6) {
                      return "Enter a Valid Password";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Image.asset('assets/icons/view.png'),
                      onPressed: () {},
                    ),
                    hintText: 'Confirm Password',
                    prefixIcon: Image.asset('assets/icons/lock.png'),
                  ),
                  controller: _confirmpPasswordController,
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: _regristrationInProgress == false,
                  replacement: CircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: onTapSubmitButton,
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontSize: 13,
                        color: Color(0xff0F2F4C),
                      ),
                    ),
                    TextButton(
                      onPressed: onTapSignIn,
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        "Sign In",
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xff0F2F4C),
                          fontSize: 13,
                          fontFamily: 'Poppins-Regular',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(height: 1, width: 140, color: Color(0xff0F2F4C)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Text(
                        "Or sign in with",
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          color: Color(0xff0F2F4C),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(height: 1, width: 140, color: Color(0xff0F2F4C)),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Color(0xFFBBD3E8),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: Image.asset('assets/icons/google.png'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onTapSignIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LoginScreen();
        },
      ),
    );
  }

  void onTapSubmitButton() {
    if (_formkey.currentState!.validate()) {
      _registerUser();
    }
  }

  Future<void> _registerUser() async {
    _regristrationInProgress = true;
    setState(() {});

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final firstName = _firstNameController.text.trim();
    final lastName = _lasttNameController.text.trim();
    final mobile = _phoneController.text.trim();

    try {
      // Register with Firebase Auth
      UserCredential userCred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Send email verification
      await userCred.user!.sendEmailVerification();

      // Save additional data to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCred.user!.uid)
          .set({
            'firstName': firstName,
            'lastName': lastName,
            'email': email,
            'mobile': mobile,
            'createdAt': FieldValue.serverTimestamp(),
          });

      showShackBarMessenger(
        context,
        "Verification email sent. Please check your inbox.",
      );
      _clearTextFields();

      // Redirect to login page
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
    } on FirebaseAuthException catch (e) {
      showShackBarMessenger(context, e.message ?? "Registration failed", true);
    }

    _regristrationInProgress = false;
    setState(() {});
  }

  void _clearTextFields() {
    _emailController.clear();
    _firstNameController.clear();
    _lasttNameController.clear();
    _phoneController.clear();
    _passwordController.clear();
  }
}
