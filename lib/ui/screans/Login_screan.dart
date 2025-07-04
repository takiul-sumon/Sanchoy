import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanchoy/ui/controller/Login_controller.dart';
import 'package:sanchoy/ui/screans/SignUpScrean.dart';
import 'package:sanchoy/ui/screans/bottom_navigation_bar.dart';
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
  // List<bool> _isSelected = [true, false]; // [Sign In, Sign Up]

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
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
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 60,
                        width: 250,
                        // color: Colors.amber,
                        decoration: BoxDecoration(
                          color: Color(0xffBBD3E8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        left: 5,
                        right: 5,
                        top: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Color(0xff2370B4),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins-Regular',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: onTapSignUpPassword,
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: Color(0xff0F2F4C),
                                      fontFamily: 'Poppins-Regular',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
            
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Image.asset('assets/icons/Iphone.png'),
                    ),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      String email = value?.trim() ?? '';
                      if (EmailValidator.validate(email) == false ||
                          email.isEmpty == true) {
                        return "Enter a Valid Email";
                      }
                      return null;
                    },
                  ),
            
                  const SizedBox(height: 10),
            
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
            
                  // const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: onTapForgetPassword,
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        'Forget Password?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff0F2F4C),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
            
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
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          fontSize: 13,
                          color: Color(0xff0F2F4C),
                        ),
                      ),
                      TextButton(
                        onPressed: onTapSignUpPassword,
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: Text(
                          "Sign up",
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
                  const SizedBox(height: 10),
            
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
            return BottomNaviationBar();
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
          return ForgetPasswordWithEmail();
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
