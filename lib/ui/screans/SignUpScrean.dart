import 'package:flutter/material.dart';

class SignUpScrean extends StatelessWidget {
  const SignUpScrean({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              Center(
                child: Image.asset('assets/images/sign_up.png', height: 150),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToggleButtons(
                    isSelected: const [false, true],
                    onPressed: (index) {},
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
                    borderRadius: BorderRadius.circular(10),
                    fillColor: Colors.lightBlue.shade100,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Image.asset('assets/icons/User.png'),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Image.asset('assets/icons/Email.png'),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Image.asset('assets/icons/Iphone.png'),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Image.asset(
                    'assets/icons/Financial Institution.png',
                  ),
                ),
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
              const SizedBox(height: 10),

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
              Center(
                child: Text.rich(
                  TextSpan(
                    text: "Don't have an account? ",
                    children: [
                      TextSpan(
                        text: "Sign up",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(child: Text("Or sign in with")),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                child: Image.asset('assets/icons/google.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
