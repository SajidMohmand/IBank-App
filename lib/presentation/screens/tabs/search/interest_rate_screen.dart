import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InterestRateScreen extends StatelessWidget {
  const InterestRateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> interestData = [
      {"kind": "Individual customers", "deposit": "1m",  "rate": "4.50%"},
      {"kind": "Corporate customers",  "deposit": "2m",  "rate": "5.50%"},
      {"kind": "Individual customers", "deposit": "Im",  "rate": "4.50%"},
      {"kind": "Corporate customers",  "deposit": "6m",  "rate": "2.50%"},
      {"kind": "Individual customers", "deposit": "Im",  "rate": "4.50%"},
      {"kind": "Corporate customers",  "deposit": "8m",  "rate": "6.50%"},
      {"kind": "Individual customers", "deposit": "1m",  "rate": "4.50%"},
      {"kind": "Individual customers", "deposit": "Im",  "rate": "4.50%"},
      {"kind": "Corporate customers",  "deposit": "7m",  "rate": "6.80%"},
      {"kind": "Individual customers", "deposit": "1m",  "rate": "4.50%"},
      {"kind": "Individual customers", "deposit": "12m", "rate": "5.90%"},
      {"kind": "Individual customers", "deposit": "Im",  "rate": "4.50%"},
    ];

    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
        title: Text(
          "Interest rate",
          style: GoogleFonts.sourceSans3(
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 22,right: 22),
        child: Column(
          children: [
            // Table header
            SizedBox(height: 12,),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "Interest Kind",
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
                    "Deposit",
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
                    "Rate",
                    style: GoogleFonts.sourceSans3(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff989898),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            // Table data
            Expanded(
              child: ListView.builder(
                itemCount: interestData.length,
                itemBuilder: (context, index) {
                  final data = interestData[index];
                  return Container(
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
                          child: Text(
                            data["kind"]!,
                            style: GoogleFonts.sourceSans3(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            data["deposit"]!,
                            style: GoogleFonts.sourceSans3(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            data["rate"]!,
                            style: GoogleFonts.sourceSans3(
                              fontSize: 17,
                              color: Color(0xff3629b7),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
