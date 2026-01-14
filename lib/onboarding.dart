import 'package:flutter/material.dart';
import 'package:shop_rafi/homepage.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController boardController = PageController();
  int indexPage = 0;
  List<Map<String, String>> boardingData = [
    {
      "title": "Welcome to Rafi Shop",
      "subTitle": "Your one-stop shop for all your needs.",
      "image":
          "https://plus.unsplash.com/premium_vector-1726620999876-069a0ad16427?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "title": "Electronics Galore",
      "subTitle": "Find the latest gadgets and electronics here.",
      "image":
          "https://plus.unsplash.com/premium_vector-1721983446755-6336c22d4618?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "title": "Fashion for Everyone",
      "subTitle": "Discover trendy fashion for all seasons.",
      "image":
          "https://plus.unsplash.com/premium_vector-1724163333366-dc150b75f069?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "title": "Step into Style",
      "subTitle": "Explore our collection of stylish footwear.",
      "image":
          "https://images.unsplash.com/photo-1491553895911-0055eca6402d?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "title": "Heels that Speak",
      "subTitle": "Find the perfect heels for any occasion.",
      "image":
          "https://plus.unsplash.com/premium_vector-1734655863202-21f38f514400?q=80&w=764&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "title": "Get Started",
      "subTitle": "Join us today and start shopping!",
      "image":
          "https://plus.unsplash.com/premium_vector-1682303136986-bd37617f9b75?q=80&w=1039&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
  ];
  @override
  void initState() {
    super.initState();
    boardController.addListener(() {
      setState(() {
        indexPage = boardController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    boardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              controller: boardController,
              itemCount: boardingData.length,
              itemBuilder: (context, index) {
                return OnBoardingLayout(
                  title: "${boardingData[index]["title"]}",
                  subTitle: "${boardingData[index]["subTitle"]}",
                  image: "${boardingData[index]["image"]}",
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                indexPage == boardingData.length - 1
                    ? TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        child: Text("Get Started"),
                      )
                    : Text(""),
                Row(
                  children: List.generate(
                    boardingData.length,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: indexPage == index
                            ? Colors.black54
                            : Colors.blueAccent,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (indexPage == boardingData.length - 1) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } else {
                      boardController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  icon: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnBoardingLayout extends StatelessWidget {
  const OnBoardingLayout({
    super.key,
    required this.title,
    required this.subTitle,
    required this.image,
  });

  final String title;
  final String subTitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.network(image, height: 350, width: 300),
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            subTitle,
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.normal,
              fontSize: 17,
            ),
          ),
        ),
      ],
    );
  }
}
