import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmScreen extends StatefulWidget {
  final String from;
  final String name;
  final String cardNumber;
  final String amount;
  final String content;

  const ConfirmScreen({
    super.key,
    required this.from,
    required this.name,
    required this.cardNumber,
    required this.amount,
    required this.content,
  });

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  final TextEditingController otpController = TextEditingController();
  String generatedOtp = "1234"; // dummy OTP for example

  bool showFingerprint = false;
  bool confirmEnabled = false; // 🔹 Control confirm button

  void _onOtpChanged(String value) {
    setState(() {
      confirmEnabled = value == generatedOtp && !showFingerprint;
    });
  }

  void _onConfirmPressed() {
    if (!showFingerprint) {
      // Step 1: OTP verified, go to fingerprint
      setState(() {
        showFingerprint = true;
        confirmEnabled = false; // disable until fingerprint done
      });
    } else {
      // Step 2: Fingerprint verified
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Transaction Confirmed ✅")),
      );
      setState(() {
        confirmEnabled = true; // keep enabled after success
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Confirm",
          style: GoogleFonts.sourceSans3(
              fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        titleSpacing: -5, // ✅ Moves title closer to the back icon
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text("Confirm transaction information",style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff979797),
          ),),

              SizedBox(height: 14,),
              Text(
                "From",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff979797),
                ),
              ),
              SizedBox(height: 10,),
              _buildReadOnlyField("From", widget.from),

              SizedBox(height: 20,),

              Text(
                "To",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff979797),
                ),
              ),
              SizedBox(height: 10,),
              _buildReadOnlyField("From", widget.name),

              SizedBox(height: 20,),
              Text(
                "Card Number",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff979797),
                ),
              ),
              SizedBox(height: 10,),
              _buildReadOnlyField("Card Number", widget.cardNumber),
              SizedBox(height: 20,),
              Text(
                "Transaction fee",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff979797),
                ),
              ),
              SizedBox(height: 10,),
              _buildReadOnlyField("Transaction Fee", "\$10"),
              SizedBox(height: 20,),
              Text(
                "Content",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff979797),
                ),
              ),
              SizedBox(height: 10,),
              _buildReadOnlyField("Content", widget.content),
              SizedBox(height: 20,),
              Text(
                "Amount",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff979797),
                ),
              ),
              SizedBox(height: 10,),
              _buildReadOnlyField("Amount", widget.amount),

              const SizedBox(height: 20),

              Text("Get OTP to verify transaction",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff979797),
                ),),
              const SizedBox(height: 8),

              // 🔹 OTP Row
              // ✅ OTP Row OR Fingerprint Section
              if (!showFingerprint) ...[
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        onChanged: _onOtpChanged,
                        decoration: InputDecoration(
                          hintText: "OTP",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("OTP sent: 1234")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor),
                      child: const Text("Get OTP",
                          style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
                const SizedBox(height: 30),
              ] else ...[
                const SizedBox(height: 50),
                Center(
                  child: Column(
                    children: [
                      Image.asset("assets/images/fingerprint.png",
                          height: 120, width: 120),
                      const SizedBox(height: 20),
                      Text("Press your thumb to verify",
                          style: GoogleFonts.sourceSans3(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // ✅ Simulate fingerprint verification
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        confirmEnabled = true; // re-enable confirm
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Fingerprint Verified 👍")),
                      );
                    },
                    child: const Text("Simulate Fingerprint"),
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // 🔹 Single Confirm Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: confirmEnabled ? _onConfirmPressed : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: confirmEnabled
                        ? Theme.of(context).primaryColor
                        : const Color(0xfff2f1f9),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text("Confirm",
                      style: GoogleFonts.sourceSans3(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Helper for read-only fields
  Widget _buildReadOnlyField(String label, String value) {
    return TextField(
      readOnly: true,
      controller: TextEditingController(text: value),
      style: const TextStyle(
        fontWeight: FontWeight.bold, // Bold while typing
        fontSize: 16,
        fontFamily: 'Roboto', // You can replace with your preferred font
      ),
      decoration: InputDecoration(
        hintStyle: TextStyle(
          fontSize: 14,
          color: Color(0xffcacaca),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10, // Reduce vertical height
          horizontal: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xffcacaca), // Default border color
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xffcacaca), // Border when not focused
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xffcacaca), // Border when focused (you can change)
          ),
        ),
      ),
    );
  }
}
