import 'package:flutter/material.dart';

import '../../navigation/routes.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {


  bool _agreedToTnC = false;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final primaryColor = Theme.of(context).primaryColor;


    return Scaffold(
      backgroundColor: primaryColor,
      resizeToAvoidBottomInset: true, // Important for avoiding keyboard overflow
      body: SafeArea(
        child: Column(
          children: [
            // Top Section (AppBar)
            Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Section
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Scrollable Form Area
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(24, 10, 24, 24),
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome to us,",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Hello there, create New account",
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 10),

                            Center(
                              child: Image.asset(
                                'assets/images/signupIllustration.png',
                                height: size.height * 0.15,
                              ),
                            ),
                            const SizedBox(height: 10),

                            TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: "Name",
                                contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),

                            TextFormField(
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: "Phone Number",
                                prefixText: "+92 ",
                                contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),

                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "Password",
                                contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),

                            Row(
                              children: [
                                Transform.scale(
                                  scale: 1.3,
                                  child: Checkbox(
                                    value: _agreedToTnC,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _agreedToTnC = value ?? false;
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Text.rich(
                                    TextSpan(
                                      text: 'By creating an account you agree to our ',
                                      style: const TextStyle(fontSize: 14),
                                      children: [
                                        TextSpan(
                                          text: 'Terms and Conditions',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            Center(
                              child: SizedBox(
                                width: double.infinity,
                                height: 42,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text("Sign Up"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ✅ Fixed Bottom Row: "Have an account?"
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Have an account?"),
                          const SizedBox(width: 6),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.login);
                            },
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),

                  ],
                ),
              ),
            ),

          ],
        ),
      ),

    );
  }
}
