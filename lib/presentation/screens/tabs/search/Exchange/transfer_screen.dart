import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_bank/presentation/navigation/routes.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  bool saveBeneficiary = false;
  String selectedCard = "Choose account / card";

  int selectedIndex = -1;
  int transactionIndex = -1;


  final TextEditingController nameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController contentController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Transfer",
          style: GoogleFonts.sourceSans3(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        titleSpacing: -5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              readOnly: true,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                suffixIcon: PopupMenuButton<String>(
                  icon: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.keyboard_arrow_up,
                        size: 18,
                        color: Color(0xffbfbfbf),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 18,
                        color: Color(0xffbfbfbf),
                      ),
                    ],
                  ),
                  onSelected: (value) {
                    setState(() {
                      selectedCard = value;
                    });
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: "VISA **** **** **** 1234",
                      child: Text("VISA **** **** **** 1234"),
                    ),
                    PopupMenuItem(
                      value: "MASTER **** **** **** 4321",
                      child: Text("MASTER **** **** **** 4321"),
                    ),
                  ],
                ),
              ),
              controller: TextEditingController(text: selectedCard),
            ),

            const SizedBox(height: 20),

            // 🔹 Choose Transaction Section
            Text("Choose transaction",
                style: GoogleFonts.sourceSans3(
                    color: Color(0xff979797), fontWeight: FontWeight.bold)),

            const SizedBox(height: 10),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTransactionCard(0,
                      Icons.credit_card, "Transfer via card number"),
                  SizedBox(
                    width: 5,
                  ),
                  _buildTransactionCard(1,
                      Icons.person, "Transfer to the same bank"),
                  SizedBox(
                    width: 5,
                  ),
                  _buildTransactionCard(2,
                      Icons.account_balance, "Transfer to another bank"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Choose Beneficiary Section
            Text("Choose beneficiary",
                style: GoogleFonts.sourceSans3(
                    color: Color(0xff979797), fontWeight: FontWeight.bold)),

            const SizedBox(height: 10),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 125,
                child: Row(
                  children: [
                    _buildBeneficiaryCard(0, isAddCard: true),
                    _buildBeneficiaryCard(1,
                      name: "Emma",
                      assetImage: "assets/images/beneficiary/1.png",
                    ),
                    _buildBeneficiaryCard(2,
                      name: "Justin",
                      assetImage: "assets/images/beneficiary/2.png",
                    ),
                    _buildBeneficiaryCard(3,
                      name: "Sajid",
                      assetImage: "assets/images/beneficiary/2.png",
                    ),
                  ],
                ),
              ),
            ),


            const SizedBox(height: 40),

            // 🔹 Card with TextFields
            Card(

              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildInputField("Name",nameController),
                    const SizedBox(height: 16),
                    _buildInputField("Card Number",cardNumberController),
                    const SizedBox(height: 16),
                    _buildInputField("Amount",amountController),
                    const SizedBox(height: 16),
                    _buildInputField("Content",contentController),



                    const SizedBox(height: 15),

                    // 🔹 Checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: saveBeneficiary,
                          activeColor: Colors.white,
                          checkColor: Theme.of(context).primaryColor,
                          side: MaterialStateBorderSide.resolveWith(
                                (states) {
                              if (states.contains(MaterialState.selected)) {
                                return BorderSide(color: Theme.of(context).primaryColor, width: 2); // when checked
                              }
                              return const BorderSide(color: Colors.grey, width: 2);   // when unchecked
                            },
                          ),
                          onChanged: (val) {
                            setState(() {
                              saveBeneficiary = val ?? false;
                            });
                          },
                        ),

                        Expanded(
                          child: Text("Save to directory of beneficiary",
                              style: GoogleFonts.sourceSans3(fontSize: 16,fontWeight: FontWeight.w600)),
                        )
                      ],
                    ),

                    const SizedBox(height: 20),

                    // 🔹 Confirm Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: _isFormValid()
                              ? Theme.of(context).primaryColor
                              : Color(0xfff2f1f9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: _isFormValid()
                            ? () {
                          Navigator.pushNamed(context, Routes.confirmScreen,
                            arguments: {
                            "from": selectedCard,
                              'name': nameController.text.toString(),
                              'cardNumber': cardNumberController.text.toString(),
                              'amount': amountController.text.toString(),
                              'content': contentController.text.toString(),
                            },
                          );
                        }
                            : null,
                        child: Text(
                          "Confirm",
                          style: GoogleFonts.sourceSans3(color: Colors.white,
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }

  // Helper Widgets
  Widget _buildTransactionCard(int index,IconData icon, String text) {

    bool isSelected = transactionIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          transactionIndex = index;
        });
      },


      child: Container(
        width: 135,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor :Color(0xffe0e0e0),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 42, color: Colors.white),
            Text(
              text,
              style: GoogleFonts.sourceSans3(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBeneficiaryCard(int index,{
    String name = "",
    String? assetImage,
    bool isAddCard = false,
  }) {

    bool isSelected = selectedIndex == index;

    return GestureDetector(

      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        width: 110,
        height: 120,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected && !isAddCard ? Theme.of(context).primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // soft shadow
              blurRadius: 1,
              spreadRadius: 1,
              offset: Offset(0,3), // shadow direction: bottom
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isAddCard)
              CircleAvatar(
                radius: 30,
                backgroundColor:isSelected?Theme.of(context).primaryColor: Color(0xfff2f1f9), // blue background
                child:Icon(Icons.add, color: Colors.white, size: 30),
              )
            else if (assetImage != null)
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(assetImage),
              ),
            const SizedBox(height: 8),
            if(name != "")
              Text(
              name,
              style: GoogleFonts.sourceSans3(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildInputField(String hint,TextEditingController controller) {
    return TextField(


      controller: controller,
      style: const TextStyle(
        fontWeight: FontWeight.bold,   // Bold while typing
        fontSize: 16,
        fontFamily: 'Roboto',          // You can replace with your preferred font
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 14,
          color: Color(0xffcacaca),
          ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,   // Reduce vertical height
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

  bool _isFormValid() {
    return selectedCard != "Choose account / card" &&
        nameController.text.isNotEmpty &&
        cardNumberController.text.isNotEmpty &&
        amountController.text.isNotEmpty &&
        contentController.text.isNotEmpty &&
        saveBeneficiary;
  }


}
