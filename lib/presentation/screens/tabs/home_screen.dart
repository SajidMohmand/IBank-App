import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> cards = [
    'assets/images/cards/1.jpg',
    'assets/images/cards/2.jpg',
    'assets/images/cards/3.jpg',
    'assets/images/cards/4.jpg',
    'assets/images/cards/5.jpg',
    'assets/images/cards/6.jpg',
    'assets/images/cards/7.jpg',
    'assets/images/cards/8.jpg',
  ];

  final List<Map<String, String>> gridItems = [
    {"image": "assets/images/homeGrid/1.png", "title": "Profile"},
    {"image": "assets/images/homeGrid/2.png", "title": "Messages"},
    {"image": "assets/images/homeGrid/3.png", "title": "Settings"},
    {"image": "assets/images/homeGrid/4.png", "title": "Photos"},
    {"image": "assets/images/homeGrid/5.png", "title": "Videos"},
    {"image": "assets/images/homeGrid/6.png", "title": "Music"},
    {"image": "assets/images/homeGrid/7.png", "title": "Friends"},
    {"image": "assets/images/homeGrid/8.png", "title": "Events"},
    {"image": "assets/images/homeGrid/9.png", "title": "More"},
  ];

  final CardSwiperController controller = CardSwiperController();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          const SizedBox(height: 30),
          // Custom AppBar
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage('assets/images/user.jpg'),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      "Hi, Sajid Ali Khan",
                      style: TextStyle(color: Color(0xfff5f4fb), fontSize: 20),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications,
                          color: Colors.white, size: 30),
                      onPressed: () {},
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: const Text(
                          '3',
                          style: TextStyle(
                              color: Colors.white, fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          // Main Content
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 24,right: 24,top: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  // Card Swiper Section
                  SizedBox(
                    height: screenHeight * 0.32, // Reduced height for cards
                    child: CardSwiper(
                      controller: controller,
                      cardsCount: cards.length,
                      numberOfCardsDisplayed: 3,
                      backCardOffset: const Offset(0, 20),
                      padding: const EdgeInsets.all(8),
                      cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                        return cardWidget(cards[index], screenHeight * 0.25);
                      },
                      onSwipe: (previousIndex, currentIndex, direction) {
                        debugPrint(
                            'Swiped from $previousIndex to $currentIndex direction: $direction');
                        return true;
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Grid Section
                  Expanded(
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 20),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1, // Adjusted aspect ratio
                      ),
                      itemCount: gridItems.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            debugPrint("${gridItems[index]['title']} clicked");
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  gridItems[index]['image']!,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                gridItems[index]['title']!,
                                style: const TextStyle(
                                  fontSize: 13, // Slightly smaller font
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget cardWidget(String imagePath, double height) {
    return SizedBox(
      height: height,
      child: ClipRRect(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}