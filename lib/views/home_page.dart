import 'package:chatt_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:chatt_app/widgets/search_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  static String id = "Home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Track the index of the selected tab
  final PageController _controller = PageController(viewportFraction: 0.7);

  // List of image paths
  final List<String> list = [
    "assets/meal-3-MightyZingerjpg.jpg",
    "assets/meal-4-MC.jpg",
    "assets/meal-5-Combo.png",
    "assets/meal-6-ss.jpg",
    "assets/meal-7-sss.jpg",
    "assets/meal-8-Grills-Kilo.jpg",
    "assets/meal-9-p.jpg",
    "assets/meal-10-kkers.jpg",
    "assets/meal-11-koshary.jpg",
    "assets/meal-12-Bzoka.jpg",
    "assets/meal-13-bzokka.jpg",
    "assets/meal-14-mbazokaa.jpg",
    "assets/meal-15-ABd.png",
    "assets/meal-16-.png",
    "assets/meal-17-bsk.png",
    "assets/meal-20-mmn.jpg",
  ];

  // List of meal names corresponding to the images
  final List<String> mealNames = [
    "Mighty Zinger",
    "Bzoka",
    "Combo Meal",
    "Combo Meal",
    "Grills Kilo",
    "Pizza",
    "Pizza",
    "Koshary",
    "Bzoka",
    "Bzokka",
    "Mabazokaa",
    "ABd",
    "Grills Kilo",
    "Bsk",
    "Combo Meal",
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),
          const SearchWidget(hint: 'ابحث عن وجبتك المفضلة'),
          SizedBox(
            height: 250,
            child: PageView.builder(
              controller: _controller,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    double value = 1.0;
                    if (_controller.position.haveDimensions) {
                      value = _controller.page! - index;
                      value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
                    }
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Center(
                        child: SizedBox(
                          height: Curves.easeOut.transform(value) * 250,
                          width: Curves.easeOut.transform(value) * 300,
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  list[index],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                      child: Icon(Icons.error),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  mealNames[index],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            thickness: 1,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: TextWidget(hinttext: "Most Popular", bold: true)),
          ),
          SizedBox(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 190,
                  height: 240,
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 247, 244, 244),
                  ),
                  child: Column(
                    children: [
                      Image.asset(width: 190, height: 150, list[index]),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            mealNames[index], // This could be dynamic too
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        '48EGP',
                        style: TextStyle(
                          color: Colors.brown,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'All Meals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex, // Highlight the selected index
        selectedItemColor: Colors.yellow, // Color for the selected item
        unselectedItemColor: Colors.grey, // Color for unselected items
        onTap: _onItemTapped, // Call when an item is tapped
        type: BottomNavigationBarType
            .fixed, // Fixed type for a more stable layout
      ),
    );
  }
}
