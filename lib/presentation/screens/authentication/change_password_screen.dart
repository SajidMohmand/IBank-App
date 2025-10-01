import 'package:flutter/material.dart';
import 'package:i_bank/presentation/navigation/routes.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String _newPassword = '';
  String _confirmPassword = '';
  bool _passwordsMatch = false;

  void _checkPasswords() {
    setState(() {
      _passwordsMatch =
          _newPassword.isNotEmpty && _confirmPassword.isNotEmpty && _newPassword == _confirmPassword;
    });
  }

  void _changePassword() {

    Navigator.pushNamed(context, Routes.successChangePassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change Password")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          color: const Color(0xfff9f9fd),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Type your new password", style: TextStyle(color: Color(0xff979797))),
                const SizedBox(height: 5),
                TextField(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: "New Password",
                    isDense: true, // Reduces height a bit
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 14), // Controls inner padding

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onChanged: (value) {
                    _newPassword = value;
                    _checkPasswords();
                  },
                ),
                const SizedBox(height: 12),
                const Text("Confirm password", style: TextStyle(color: Color(0xff979797))),
                const SizedBox(height: 5),
                TextField(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    isDense: true, // Reduces height a bit
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 14), // Controls inner padding

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onChanged: (value) {
                    _confirmPassword = value;
                    _checkPasswords();
                  },
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _passwordsMatch ? _changePassword : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14), // Reduced radius
                      ),
                    ),
                    child: const Text(
                      "Change Password",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
