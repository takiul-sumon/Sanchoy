import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
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

              TextField(
                decoration: InputDecoration(
                  hintText: 'Phone',
                  prefixIcon: Image.asset('assets/icons/Iphone.png'),
                ),
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
                    onPressed: () {},
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
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Color(0xFFBBD3E8),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
