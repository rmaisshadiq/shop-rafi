import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:shop_rafi/cart_page.dart';
import 'package:shop_rafi/homepage.dart';
import 'package:shop_rafi/providers/cart_provider.dart';

class GridSepatuPria extends StatefulWidget {
  const GridSepatuPria({super.key});

  @override
  State<GridSepatuPria> createState() => _GridSepatuPriaState();
}

class _GridSepatuPriaState extends State<GridSepatuPria> {
  List<dynamic> sepatuPriaProduct = [];

  Future<void> getSepatuPria() async {
    String urlSepatuPria =
        "https://backend-shop-production-fbd7.up.railway.app/products/shoes";
    try {
      var response = await http.get(Uri.parse(urlSepatuPria));
      if (response.statusCode == 200) {
        setState(() {
          var jsonResponse = json.decode(response.body);

          sepatuPriaProduct = jsonResponse['data'];
        });
      }
    } catch (exc) {
      if (kDebugMode) {
        print(exc);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getSepatuPria();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SepatuPria Products",
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
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shop_outlined,
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
      body: Center(
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemCount: sepatuPriaProduct.length,
          itemBuilder: (context, index) {
            final item = sepatuPriaProduct[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => DetailSepatuPria(item: item),
                  ),
                );
              },
              child: Card(
                child: Column(
                  children: <Widget>[
                    Image.network(
                      item['images'],
                      height: 125,
                      width: 150,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                      child: Text(
                        item['name'],
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rp ${item['price']}",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.favorite, color: Colors.red, size: 12),
                              Text(
                                "Rp ${item['promo']}",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ],
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
      ),
    );
  }
}

class DetailSepatuPria extends StatelessWidget {
  const DetailSepatuPria({super.key, required this.item});

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          item['name'],
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const GridSepatuPria()),
            );
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shop_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.network(
              item['images'],
              height: 350,
              width: 400,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25, top: 20),
            child: Text(
              "Product Description",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25, top: 5),
            child: Text(
              item['description'],
              style: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.normal,
                fontSize: 13,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25, top: 30, right: 25, bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Harga: Rp ${item['price']}",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.red, size: 12),
                    Text(
                      "Promo: Rp ${item['promo']}",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 140, top: 50),
            child: SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Add to Cart",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                onPressed: () {
                  Provider.of<CartProvider>(
                    context,
                    listen: false,
                  ).addToCart(item);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Item added to cart"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
