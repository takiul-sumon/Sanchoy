import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanchoy/ui/controller/Login_controller.dart';
import 'package:sanchoy/ui/screans/MainButtomNavScreen.dart';
import 'package:sanchoy/ui/screans/SignUpScrean.dart';
import 'package:sanchoy/ui/screans/forgetPasswordVerificationWithEmail.dart';
import 'package:sanchoy/ui/widgets/SnackBarMessenger.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final LoginController _loginController = Get.find<LoginController>();
  List<bool> _isSelected = [true, false]; // [Sign In, Sign Up]

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Image.asset('assets/images/Group.png', height: 150),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ToggleButtons(
                      isSelected: _isSelected,
                      onPressed: (index) {
                        setState(() {
                          if (index == 0) {
                            _isSelected = [true, false]; // Stay on Sign In
                          } else {
                            _isSelected = [false, true]; // Switch to Sign Up
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScrean(),
                              ),
                            );
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

                // Email Input
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Image.asset('assets/icons/Iphone.png'),
                  ),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  validator: (String? value) {
                    String email = value?.trim() ?? '';
                    if (EmailValidator.validate(email) == false ||
                        email.isEmpty == true) {
                      return "Enter a Valid Email";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                // Password Input
                TextFormField(
                  obscureText: true,
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
                const SizedBox(height: 5),

                // Forget Password Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: onTapForgetPassword,
                      child: Text(
                        'Forget Password?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                // Login Button
                ElevatedButton(
                  onPressed: onTapSignInButton,
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: onTapSignUpPassword,
                      child: Text(
                        "Sign up",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Center(child: Text("Or sign in with")),
                const SizedBox(height: 10),

                // Google Sign In Button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Color(0xFFBBD3E8),
                    foregroundColor: Colors.black,
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

  // Sign In Button Tap
  onTapSignInButton() {
    if (_formkey.currentState!.validate()) {
      _login();
    }
  }

  // Login Logic
  Future<void> _login() async {
    final bool isSuccess = await _loginController.login(
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (isSuccess) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) {
            return Mainbuttomnavscreen();
          },
        ),
        (predicate) => false,
      );
    } else {
      showShackBarMessenger(context, _loginController.errorMessage!, true);
    }
  }

  // Forget Password Screen Navigation
  onTapForgetPassword() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return ForgetPasswordWithPhone();
        },
      ),
    );
  }

  // Navigate to Sign Up Screen
  onTapSignUpPassword() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return SignUpScrean();
        },
      ),
    );
  }
}
