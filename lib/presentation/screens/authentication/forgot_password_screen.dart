import 'package:flutter/material.dart';
import 'package:i_bank/presentation/navigation/routes.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String _phoneNumber = "";
  late TextEditingController _phoneController;
  String _focusedField = 'phone';



  bool _showCodeInput = false;
  String _code = '';
  final String _correctCode = '1234'; // Simulated OTP for testing


  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }


  void _onKeyTap(String value) {
    setState(() {
      if (_focusedField == 'phone' && _phoneController.text.length < 11) {
        _phoneController.text += value;
        _phoneNumber = _phoneController.text;
      } else if (_focusedField == 'code' && _code.length < 4) {
        _code += value;
      }
    });
  }


  void _onBackspace() {
    setState(() {
      if (_focusedField == 'phone' && _phoneController.text.isNotEmpty) {
        _phoneController.text = _phoneController.text.substring(0, _phoneController.text.length - 1);
        _phoneNumber = _phoneController.text;
      } else if (_focusedField == 'code' && _code.isNotEmpty) {
        _code = _code.substring(0, _code.length - 1);
      }
    });
  }


  bool _isValidPhoneNumber(String phone) {
    final regex = RegExp(r'^03[0-9]{9}$');
    return regex.hasMatch(phone);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return Scaffold(
      backgroundColor: Color(0xffffffff),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back_ios),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Forgot Password",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(height: 20),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              children: [

                                if (!_showCodeInput)
                                  Card(
                                    color: const Color(0xfff9f9fd),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Type your phone number",
                                            style: TextStyle(color: Color(0xff979797)),
                                          ),
                                          const SizedBox(height: 16),
                                          TextField(
                                            readOnly: true,
                                            onTap: () {
                                              setState(() {
                                                _focusedField = 'phone';
                                              });
                                            },
                                            controller: _phoneController,
                                            decoration: InputDecoration(
                                              prefix: Text("+92 "),
                                              hintText: "03XXXXXXXXX",
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                            ),

                                          ),
                                          const SizedBox(height: 12),
                                          const Text(
                                            "We texted you a code to verify your phone number",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          const SizedBox(height: 20),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: _isValidPhoneNumber(_phoneNumber)
                                                    ? primaryColor
                                                    : Colors.grey, // Disabled color
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(14),
                                                ),
                                                padding: const EdgeInsets.symmetric(vertical: 12),
                                              ),
                                              onPressed: _isValidPhoneNumber(_phoneNumber)
                                                  ? () {
                                                setState(() {
                                                  _showCodeInput = true; // Show OTP input
                                                });
                                              }
                                                  : null, // Disable the button
                                              child: const Text(
                                                "Send",
                                                style: TextStyle(color: Colors.white, fontSize: 16),
                                              ),
                                            ),

                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (_showCodeInput)
                                  Card(
                                    color: const Color(0xfff9f9fd),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Type a code",
                                            style: TextStyle(color: Color(0xff979797)),
                                          ),
                                          const SizedBox(height: 16),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: TextField(
                                                  readOnly: true,
                                                  controller: TextEditingController(text: _code),
                                                  onTap: () {
                                                    setState(() {
                                                      _focusedField = 'code';
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText: "Code",
                                                    isDense: true, // Reduces height a bit
                                                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 14), // Controls inner padding
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _code = value;
                                                    });
                                                  },
                                                ),

                                              ),
                                              const SizedBox(width: 10),
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                  backgroundColor: Theme.of(context).primaryColor,
                                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(14),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  // Trigger resend logic here
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(content: Text('Code resent!')),
                                                  );
                                                },
                                                child: const Text(
                                                  "Resend",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          RichText(
                                            text: TextSpan(
                                              style: const TextStyle(color: Colors.black,fontSize: 15),
                                              children: [
                                                const TextSpan(
                                                  text: "We texted you a code to verify your phone number ",
                                                ),
                                                TextSpan(
                                                  text: "(+92) $_phoneNumber",
                                                  style: TextStyle(color: Theme.of(context).primaryColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          const Text(
                                            "This code will expire 10 minutes after this message. If you don't get a message.",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          const SizedBox(height: 20),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: _code == _correctCode
                                                    ? primaryColor
                                                    : Colors.grey,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(14),
                                                ),
                                                padding: const EdgeInsets.symmetric(vertical: 12),
                                              ),
                                              onPressed: _code == _correctCode
                                                  ? () {

                                                Navigator.pushNamed(context, Routes.changePassword);

                                              }
                                                  : null,
                                              child: const Text(
                                                "Change Password",
                                                style: TextStyle(color: Colors.white, fontSize: 16),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                const SizedBox(height: 40),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildKeyboard(),
            ),
          ],

        ),
      ),
    );
  }

  Widget _buildKeyboard() {
    return Container(
      color: Color(0xffd6d9df),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildKeyRow(['1', '2', '3']),
          SizedBox(height: 4),
          _buildKeyRow(['4', '5', '6']),
          SizedBox(height: 4),
          _buildKeyRow(['7', '8', '9']),
          SizedBox(height: 4),
          _buildKeyRow(['.', '0', '⌫']),
        ],
      ),
    );
  }

  Widget _buildKeyRow(List<String> labels) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: labels.map((label) {
        if (label == '⌫') {
          return _buildKey(label, onTap: _onBackspace);
        }else {
          return _buildKey(label);
        }
      }).toList(),
    );
  }

  Widget _buildKey(String label, {VoidCallback? onTap, bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0,),
      child: GestureDetector(
        onTap: enabled
            ? (onTap ?? () {
          _onKeyTap(label);
        })
            : null,
        child: Container(
          width: 130,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: label != '⌫' && label != '.' ? Colors.white : Color(0xffd6d9df),
            borderRadius: BorderRadius.circular(10), // Full rounded style
            border: label != '⌫' && label != '.'  ? Border.all(color: Colors.grey.shade400): null,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
