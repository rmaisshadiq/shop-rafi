import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_rafi/cart_page.dart';
import 'package:shop_rafi/gridbajupria.dart';
import 'package:shop_rafi/gridbajuwanita.dart';
import 'dart:convert';

import 'package:shop_rafi/gridelektronik.dart';
import 'package:shop_rafi/gridsepatupria.dart';
import 'package:shop_rafi/gridsepatuwanita.dart';
import 'package:shop_rafi/splashscreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchProduct = TextEditingController();
  PageController bannerController = PageController();
  List<dynamic> listProductItem = [];
  Timer? bannerTimer;
  int indexBanner = 0;

  @override
  void initState() {
    super.initState();
    bannerController.addListener(() {
      setState(() {
        indexBanner = bannerController.page?.round() ?? 0;
      });
    });
    bannerOnBoarding();
    getProductItem();
  }

  void bannerOnBoarding() {
    bannerTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (indexBanner < 2) {
        indexBanner++;
      } else {
        indexBanner = 0;
      }
      bannerController.animateToPage(
        indexBanner,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  Future<void> getProductItem() async {
    String urlProductItem = "http://10.0.2.2:3000/products";
    try {
      var response = await http.get(Uri.parse(urlProductItem));

      if (response.statusCode == 200) {
        setState(() {
          var jsonResponse = json.decode(response.body);

          listProductItem = jsonResponse['data'];
        });
      }
    } catch (exc) {
      if (kDebugMode) {
        print(exc);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> bannerImage = [
      'lib/images/b_cloth.jpg',
      'lib/images/b_electronic.jpg',
      'lib/images/b_shoes.jpg',
    ];

    List<Map<String, dynamic>> categories = [
      {
        'name': 'Elektronik',
        'icon': 'lib/images/ic_laptop.png',
        'page': const GridElektronik(),
      },
      {
        'name': 'Baju Pria',
        'icon': 'lib/images/ic_cloth.png',
        'page': const GridBajuPria(),
      },
      {
        'name': 'Baju Wanita',
        'icon': 'lib/images/ic_dress.png',
        'page': const GridBajuWanita(),
      },
      {
        'name': 'Sepatu Pria',
        'icon': 'lib/images/ic_shoes.png',
        'page': const GridSepatuPria(),
      },
      {
        'name': 'Sepatu Wanita',
        'icon': 'lib/images/ic_heels.png',
        'page': const GridSepatuWanita(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Store Rafi",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => SplashScreen()),
            );
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => const CartPage()));
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
              size: 22,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: searchProduct,
              decoration: InputDecoration(
                hintText: 'Search Product',
                hintStyle: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.normal,
                  fontSize: 13,
                ),
                suffixIcon: Icon(
                  Icons.filter_list,
                  size: 17,
                  color: Colors.black,
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  size: 17,
                  color: Colors.black,
                ),
                filled: true,
                fillColor: Colors.green.shade50,
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 150,
              child: PageView.builder(
                controller: bannerController,
                itemCount: bannerImage.length,
                itemBuilder: (context, index) {
                  return Image.asset(bannerImage[index], fit: BoxFit.cover);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: SizedBox(
                height: 90,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: categories.map((cat) {
                    return _buildCategoryCard(
                      context,
                      cat['name'],
                      cat['icon'],
                      cat['page'],
                    );
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  const Text(
                    'Popular Product',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  if (listProductItem.isEmpty) ...[
                    Center(
                      child: const Text(
                        'Product not Found',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ] else ...[
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemCount: listProductItem.length,
                      itemBuilder: (context, index) {
                        final productItem = listProductItem[index];
                        return GestureDetector(
                          onTap: () {
                            Widget? targetPage;
                            String category = productItem['category'];

                            if (category == 'electronic') {
                              targetPage = DetailElektronik(item: productItem);
                            } else if (category == 'baju pria') {
                              targetPage = DetailBajuPria(item: productItem);
                            } else if (category == 'baju wanita') {
                              targetPage = DetailBajuWanita(item: productItem);
                            } else if (category == 'sepatu pria') {
                              targetPage = DetailSepatuPria(item: productItem);
                            } else if (category == 'sepatu wanita') {
                              targetPage = DetailSepatuWanita(
                                item: productItem,
                              );
                            }

                            if (targetPage != null) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => targetPage!,
                                ),
                              );
                            }
                          },
                          child: Card(
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.network(
                                          productItem['images'],
                                          height: 120,
                                          width: 120,
                                          fit: BoxFit.cover,
                                        ),
                                        Text(
                                          productItem['name'],
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        color: Colors.pink,
                                        size: 15,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        "Rp${productItem['price']}",
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String title,
    String iconPath,
    Widget targetPage,
  ) {
    return Card(
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => targetPage));
        },
        child: SizedBox(
          height: 80,
          width: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(iconPath, height: 45, width: 45),
              const SizedBox(height: 5),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
