import 'package:flutter/material.dart';

class SetNewPassword extends StatelessWidget {
  const SetNewPassword({super.key});

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
                      'Enter OTP Code',
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
                'assets/images/undraw_confirmation_sjm7 1.png',
              ),
            ),

            Text(
              'Create New Password',
              style: TextStyle(
                fontSize: 18,
                // fontWeight: FontWeight.bold,
                fontFamily: 'Poppins-Bold',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Your new password must be different from\n              previous used passwords',
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Image.asset('assets/icons/view.png'),
                  onPressed: () {},
                ),
                hintText: 'Enter New Password',
                prefixIcon: Image.asset('assets/icons/lock.png'),
              ),
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
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Create',
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
