import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shop_rafi/homepage.dart';

class GridSepatuWanita extends StatefulWidget {
  const GridSepatuWanita({super.key});

  @override
  State<GridSepatuWanita> createState() => _GridSepatuWanitaState();
}

class _GridSepatuWanitaState extends State<GridSepatuWanita> {
  List<dynamic> sepatuWanitaProduct = [];

  Future<void> getSepatuWanita() async {
    String urlSepatuWanita = "http://10.0.2.2/servershop_rafi/getsepatuwanita.php";
    try {
      var response = await http.get(Uri.parse(urlSepatuWanita));
      setState(() {
        sepatuWanitaProduct = json.decode(response.body);
      });
    } catch (exc) {
      if (kDebugMode) {
        print(exc);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getSepatuWanita();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SepatuWanita Products",
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
            onPressed: () {},
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
          itemCount: sepatuWanitaProduct.length,
          itemBuilder: (context, index) {
            final item = sepatuWanitaProduct[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => DetailSepatuWanita(item: item),
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

class DetailSepatuWanita extends StatelessWidget {
  const DetailSepatuWanita({super.key, required this.item});

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
              MaterialPageRoute(builder: (context) => const GridSepatuWanita()),
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
          C(
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
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const GridSepatuWanita(),
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
