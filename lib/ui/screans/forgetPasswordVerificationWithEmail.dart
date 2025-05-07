import 'package:flutter/material.dart';

class Forgetpasswordverificationwithemail extends StatelessWidget {
  const Forgetpasswordverificationwithemail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: 24,
              child: Stack(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: Image.asset('assets/icons/Success Icon.png'),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Forget Password',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/undraw_forgot-password_odai 1.png',
              ),
            ),
            Text(
              'Please enter your Email and we will send OTP code in \n                       the next step to reset your\n                                    password',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: Image.asset('assets/icons/Iphone.png'),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Back to Sign In',
                style: TextStyle(color: Color(0xff0F2F4C)),
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Send',
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
    );
  }
}
