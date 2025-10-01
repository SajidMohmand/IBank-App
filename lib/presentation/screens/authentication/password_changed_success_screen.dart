import 'package:flutter/material.dart';
import 'package:i_bank/presentation/navigation/routes.dart';

class PasswordChangedSuccessScreen extends StatelessWidget {
  const PasswordChangedSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 30.0, top: 20.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context); // Handle back navigation
            },
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Image.asset(
              'assets/images/successChangePass.png', // Make sure this exists in your assets
              width: double.infinity,
              height: 210,
            ),
            const SizedBox(height: 30),
            Text(
              "Change password successfully!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              "You have successfully changed your password.\nPlease use the new password when Sign in.",
              textAlign: TextAlign.center,
              style: TextStyle( fontSize: 15,fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.tabScreen);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Minimal radius
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text("OK", style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
