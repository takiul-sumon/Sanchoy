import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sanchoy/ui/screans/ForgetPinVerificationScrean.dart';
import 'package:sanchoy/ui/screans/Login_screan.dart';
import 'package:sanchoy/ui/widgets/SnackBarMessenger.dart';

class ForgetPasswordWithPhone extends StatefulWidget {
  const ForgetPasswordWithPhone({super.key});

  @override
  State<ForgetPasswordWithPhone> createState() =>
      _ForgetPasswordWithPhoneState();
}

class _ForgetPasswordWithPhoneState extends State<ForgetPasswordWithPhone> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isSendingOtp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                  Text(
                    'Forget Password',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(width: 40), // Placeholder to balance back icon
                ],
              ),
              const SizedBox(height: 20),
              Image.asset('assets/images/undraw_forgot-password_odai 1.png'),
              const SizedBox(height: 10),
              Text(
                'Enter your phone number to receive an OTP \n to reset your password.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      value.length < 10) {
                    return 'Enter a valid phone number';
                  }
                  return null;
                },
              ),
              TextButton(
                onPressed: onTapSignIn,
                child: Text(
                  'Back to Sign In',
                  style: TextStyle(color: Color(0xff0F2F4C)),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSendingOtp ? null : _sendOtp,
                  child:
                      _isSendingOtp
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                            'Send OTP',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapSignIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  Future<void> _sendOtp() async {
    if (_formkey.currentState!.validate()) {
      setState(() => _isSendingOtp = true);

      String phone = _phoneController.text.trim();

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          showShackBarMessenger(context, "OTP Failed: ${e.message}", true);
          setState(() => _isSendingOtp = false);
        },
        codeSent: (String verificationId, int? resendToken) {
          showShackBarMessenger(context, "OTP sent to $phone", false);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>   ForgetPinverificationwithemail(
                    // phoneNumber: phone,
                    // verificationId: verificationId,
                    email: _phoneController.text,
                  ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }
}
