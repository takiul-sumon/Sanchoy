import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:sanchoy/data/models/Urls.dart';
import 'package:sanchoy/data/models/services/Newtork_client.dart';
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
                const SizedBox(height: 10),
                Center(child: Image.asset('assets/images/sign_up.png')),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ToggleButtons(
                      isSelected: const [false, true],
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
                const SizedBox(height: 5),

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
                    RegExp regEx = RegExp(r"^(?:\+?88|0088)?01[1-9]\d{8}$");

                    if (regEx.hasMatch(number)) {
                      return "Enter Your Valid Mobile Number";
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
                      'Log In',
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
                    Text('Already have account? '),
                    TextButton(
                      onPressed: onTapSignIn,
                      child: Text(
                        "Sign In",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
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
    Map<String, dynamic> requestBody = {
      "email": _emailController.text.trim(),
      "firstName": _firstNameController.text.trim(),
      "lastName": _lasttNameController.text.trim(),
      "mobile": _phoneController.text.trim(),
      "password": _passwordController.text,
    };
    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.registerUrl,
      body: requestBody,
    );
    _regristrationInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      _clearTextFields();
      showShackBarMessenger(context, "Successful");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        ),
      );
    } else {
      showShackBarMessenger(context, response.errorMessage.toString(), true);
    }
  }

  void _clearTextFields() {
    _emailController.clear();
    _firstNameController.clear();
    _lasttNameController.clear();
    _phoneController.clear();
    _passwordController.clear();
  }
}
