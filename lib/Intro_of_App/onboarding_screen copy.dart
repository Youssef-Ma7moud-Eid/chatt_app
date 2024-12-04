import 'package:chatt_app/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() => isLastPage = index == 2);
            },
            children: [
              buildPage(
                  color: Color(0xFFF76B2F),
                  title: "Welcome",
                  subtitle: "You can Get any Order From any Resturant",
                  image: "Images/d6ce2e37-ebd0-4bab-9828-64135e5d1f37.gif"),
              buildPage(
                  color: Color(0xFFFBE907),
                  title: "Your Breakfast",
                  subtitle: "24 hour Work",
                  image: "Images/Coffe Cup.gif"),
              buildPage(
                  color: Color(0xFF433963),
                  title: "Get Started",
                  subtitle: "Any of fast Food",
                  image: "Images/Hop Hop Dog.gif"),
            ],
          ),
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: WormEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.blue,
                  ),
                ),
                SizedBox(height: 40),
                isLastPage
                    ? ElevatedButton(
                        onPressed: () {
                          // Navigate to the second page
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Text("Get Started"),
                      )
                    : TextButton(
                        onPressed: () {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Text("Next"),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildPage({
    required Color color,
    required String title,
    required String subtitle,
    required String image,
  }) {
    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 200, width: 200),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          SizedBox(height: 20),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
