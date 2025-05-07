import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:sanchoy/ui/screans/SignUpScrean.dart';
import 'package:sanchoy/ui/screans/forgetPasswordVerificationWithEmail.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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
                      isSelected: const [true, false],
                      onPressed: (index) {},
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
                    hintText: 'Phone',
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
                ),
                const SizedBox(height: 5),
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

                ElevatedButton(
                  onPressed: () {},
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

  onTapForgetPassword() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return Forgetpasswordverificationwithemail();
        },
      ),
    );
  }

  onTapSignUpPassword() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return SignUpScrean();
        },
      ),
    );
  }

  onTapLogin() {}
}
