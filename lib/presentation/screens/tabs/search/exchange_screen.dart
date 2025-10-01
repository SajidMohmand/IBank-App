import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_bank/presentation/navigation/routes.dart';

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({super.key});

  @override
  State<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  String fromCurrency = "USD";
  String toCurrency = "USD";

  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();

  bool _isFocused = false;

  final List<String> currencies = [
    "VND (Viet Nam Dong)",
    "HKS (Hong Kong Dollar)",
    "USD (Dollar)",
    "NTS (Taiwan Dollar)",
    "JS (Jamaika Dollar)",
    "PKR (Pakistan Currency)",
    "INR (India Currency)",
  ];
  final Map<String, double> exchangeRates = {
    "USD": 1.0,        // base
    "VND": 26345.00,    // 1 USD = 25000 VND
    "HKS": 7.79,        // 1 USD = 7.8 HKS
    "NTS": 30.59,       // 1 USD = 31 NTS
    "JS": 160.77767,       // 1 USD = 150 JS
    "PKR": 281.75,       // 1 USD = 280 PKR
    "INR": 88.15,       // 1 USD = 280 PKR
  };

  @override
  void initState() {
    super.initState();

    _fromController.addListener(() {
      _convertCurrency();
    });
  }

  void _convertCurrency() {
    final input = double.tryParse(_fromController.text);
    if (input == null) {
      _toController.text = "";
      return;
    }

    // extract currency code (like "USD" from "USD (Dollar)")
    String fromCode = fromCurrency.split(" ").first;
    String toCode = toCurrency.split(" ").first;

    // Convert: First to USD, then to target currency
    double usdValue = input / exchangeRates[fromCode]!;
    double converted = usdValue * exchangeRates[toCode]!;

    // Update "To" textfield
    _toController.text = converted.toStringAsFixed(2);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            "Exchange",
            style: GoogleFonts.sourceSans3(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/searchBranch/5.png",
                  width: double.infinity,
                  height: 210,
                ),
                const SizedBox(height: 20),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// From label
                        const Text(
                          'From',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        const SizedBox(height: 5),
          
                        _currencyRow(isFrom: true, controller: _fromController),
                        const SizedBox(height: 5),
          
                        /// Arrow / exchange image in center
                        Center(
                          child: Image.asset(
                            "assets/images/searchBranch/6.png",
                            width: 55,
                            height: 55,
                            fit: BoxFit.contain,
                          ),
                        ),
          
                        /// To label
                        const Text(
                          'To',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        const SizedBox(height: 5),
          
                        _currencyRow(isFrom: false, controller: _toController),


                        const SizedBox(height: 10), // spacing

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Currency rate",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              _getExchangeRateText(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 40,
                        ),



                        Center(
                          child: SizedBox(
                            width: double.infinity, // full width
                            child: TextButton(
                              onPressed: () {

                                Navigator.pushNamed(context, Routes.transferScreen);
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .primaryColor, // button background color
                                foregroundColor: Colors.white, // text color
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(14), // round corners
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                              ),
                              child: const Text(
                                "Exchange",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
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
        ),
      ),
    );
  }

  String _getExchangeRateText() {
    String fromCode = fromCurrency.split(" ").first;
    String toCode = toCurrency.split(" ").first;

    if (fromCode == toCode) {
      return "1 $fromCode = 1 $toCode";
    }

    double rate = exchangeRates[toCode]! / exchangeRates[fromCode]!;
    return "1 $fromCode = ${rate.toStringAsFixed(2)} $toCode";
  }


  /// Currency Row (works for both From & To)
  Widget _currencyRow(
      {required bool isFrom, required TextEditingController controller}) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
      },
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "Amount",
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          suffixIcon: GestureDetector(
            onTap: () {
              _showCurrencyPopup(isFrom: isFrom);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: const Color(0xffbfbfbf),
                    width: 2,
                    height: 34,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    (isFrom ? fromCurrency : toCurrency).split(" ").first,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: (_isFocused ||
                              (isFrom ? fromCurrency : toCurrency) != "USD")
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.keyboard_arrow_up,
                          size: 18, color: Color(0xffbfbfbf)),
                      Icon(Icons.keyboard_arrow_down,
                          size: 18, color: Color(0xffbfbfbf)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        style: const TextStyle(   // 👈 this styles the typed text
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  /// Popup for selecting currency
  void _showCurrencyPopup({required bool isFrom}) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Select the currency"),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: currencies.length,
                itemBuilder: (context, index) {
                  final currency = currencies[index];
                  final isSelected = isFrom
                      ? fromCurrency == currency
                      : toCurrency == currency;

                  return InkWell(
                    splashColor: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      setState(() {
                        if (isFrom) {
                          fromCurrency = currency;
                        } else {
                          toCurrency = currency;
                        }
                      });

                      _convertCurrency();

                      setStateDialog(() {});

                      Future.delayed(const Duration(milliseconds: 20), () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      });
                    },
                    child: ListTile(
                      dense: true,
                      title: Text(
                        currency,
                        style: GoogleFonts.sourceSans3(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                        ),
                      ),
                      trailing: isSelected
                          ? Icon(Icons.check,
                              color: Theme.of(context).primaryColor)
                          : null,
                      selected: isSelected,
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
