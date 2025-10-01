import 'package:flutter/material.dart';
import 'package:i_bank/presentation/navigation/routes.dart';
import 'package:i_bank/presentation/screens/tabs/search/exchange_rate_screen.dart';
import 'package:i_bank/presentation/screens/tabs/search/exchange_screen.dart';
import 'package:i_bank/presentation/screens/tabs/search/interest_rate_screen.dart';
import 'package:i_bank/presentation/screens/tabs/search/search_branch_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        "image": "assets/images/searchBranch/1.png",
        "title": "Branch",
        "subtitle": "Search for branch",
        "nav" : Routes.searchBranchScreen,

      },
      {
        "image": "assets/images/searchBranch/2.png",
        "title": "Interest rate",
        "subtitle": "Search for interest rate",
        "nav" : Routes.interestRateScreen,

      },
      {
        "image": "assets/images/searchBranch/3.png",
        "title": "Exchange rate",
        "subtitle": "Search for exchange rate",
        "nav" : Routes.exchangeRateScreen,

      },
      {
        "image": "assets/images/searchBranch/4.png",
        "title": "Exchange",
        "subtitle": "Exchange amount of money",
        "nav" : Routes.exchangeScreen,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Search")),
      body: ListView.builder(
        itemCount: items.length,
        padding: const EdgeInsets.all(22),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              debugPrint("${items[index]['title']} clicked");
              Navigator.pushNamed(context, items[index]["nav"]);
            },
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          items[index]['title']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis, // Prevent overflow
                        ),
                        const SizedBox(height: 4),
                        Text(
                          items[index]['subtitle']!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis, // Prevent overflow
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Image - fixed size
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      items[index]['image']!,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Texts - take remaining space

                ],
              )

            ),
          );
        },
      ),
    );
  }
}
