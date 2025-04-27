import 'package:flutter/material.dart';

class ConfirmationResetPasswordPage extends StatelessWidget {
  const ConfirmationResetPasswordPage({super.key});

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
                      'Successful',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Image.asset('assets/images/undraw_confirmed_c5lo 1.png'),
            ),

            Text(
              'Password Updated',
              style: TextStyle(
                fontSize: 18,
                // fontWeight: FontWeight.bold,
                fontFamily: 'Poppins-Bold',
              ),
            ),
            SizedBox(height: 10),
            Text('Your password has been updated'),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
