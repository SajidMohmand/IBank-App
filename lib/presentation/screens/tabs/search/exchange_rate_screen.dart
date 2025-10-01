import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_flags/country_flags.dart';

class ExchangeRateScreen extends StatelessWidget {
  const ExchangeRateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> exchangeData = [
      {"country": "Vietnam", "code": "vn", "buy": 1.403, "sell": 1.746},
      {"country": "Nicaragua", "code": "ni", "buy": 9.123, "sell": 12.09},
      {"country": "Korea South", "code": "kr", "buy": 3.704, "sell": 5.151},
      {"country": "Russia", "code": "ru", "buy": 116.0, "sell": 144.4},
      {"country": "China", "code": "cn", "buy": 1.725, "sell": 2.234},
      {"country": "Portugal", "code": "pt", "buy": 1.403, "sell": 1.746},
      {"country": "Korea North", "code": "kr", "buy": 3.454, "sell": 4.312},
      {"country": "France", "code": "fr", "buy": 23.45, "sell": 34.56},
      {"country": "Nicaragua", "code": "ni", "buy": 263.1, "sell": 300.3},
    ];



    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Exchange rate",
          style: GoogleFonts.sourceSans3(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 22, right: 22),
        child: Column(
          children: [
            const SizedBox(height: 15),

            // Table Header
            Padding(
              padding: const EdgeInsets.only(left: 12,),

              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Country",
                      style: GoogleFonts.sourceSans3(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff989898),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Buy",
                      style: GoogleFonts.sourceSans3(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff989898),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Sell",
                      style: GoogleFonts.sourceSans3(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff989898),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 6),

            // Table Rows
            Expanded(
              child: ListView.builder(
                itemCount: exchangeData.length,
                itemBuilder: (context, index) {
                  final data = exchangeData[index];
                  return GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "${data["country"]} clicked!",
                            style: GoogleFonts.sourceSans3(fontSize: 16),
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                CountryFlag.fromCountryCode(
                                  data["code"],
                                  width: 40,
                                  height: 30,
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    data["country"],
                                    style: GoogleFonts.sourceSans3(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              data["buy"].toString(),
                              style: GoogleFonts.sourceSans3(
                                  fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              data["sell"].toString(),
                              style: GoogleFonts.sourceSans3(
                                  fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
