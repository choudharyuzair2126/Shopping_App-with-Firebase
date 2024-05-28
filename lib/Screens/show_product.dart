// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:app_ui/Screens/buynow.dart';
import 'package:app_ui/Screens/cart.dart';
import 'package:app_ui/Services/uihelper.dart';
import 'package:app_ui/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShowProduct extends StatefulWidget {
  final image1;
  final name;
  final price;
  final description;
  final rating;
  final category;

  const ShowProduct(
      {required this.image1,
      super.key,
      required this.name,
      required this.price,
      required this.description,
      required this.rating,
      required this.category});

  @override
  State<ShowProduct> createState() => _ShowProductState();
}

class _ShowProductState extends State<ShowProduct> {
  uId() {
    token = FirebaseAuth.instance.currentUser!.uid;
  }

  futureBuilder(
    image,
    name,
    price,
  ) async {
    FirebaseFirestore.instance.collection(token).doc(name).set({
      "image": image,
      "name": name,
      "price": price,
    }).then((value) {
      count1 = count1 + 1;
      setState(() {});
    });
  }

  counter(int count1) {
    FirebaseFirestore.instance
        .collection(token)
        .doc('count')
        .update({'count': count1 + 1});
  }

  @override
  void initState() {
    super.initState();
    uId();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Product Details'),
            UiHelper.badge(IconButton(
              onPressed: () {
                UiHelper.push1(context, const Cart());
              },
              icon: const Icon(Icons.shopping_cart),
              style: const ButtonStyle(iconSize: MaterialStatePropertyAll(33)),
            ))
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.image1), fit: BoxFit.fill),
                      color: Colors.grey),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.name,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    "Rs.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.price.toString(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Icon(
                    Icons.star,
                    color: Colors.black,
                    size: 17,
                  ),
                  const SizedBox(
                    width: 1,
                  ),
                  const Text(
                    "Rating ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.rating.rate.toString(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "(${widget.rating.count.toString()})",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Category: ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.category,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
              const Text(
                "Description: ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.description,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                  width: double.infinity,
                  child: UiHelper.customElevatedButton('Buy Now', () {
                    UiHelper.push1(context, const BuyNow());
                  },
                      const ButtonStyle(
                          foregroundColor:
                              MaterialStatePropertyAll(Colors.black),
                          textStyle: MaterialStatePropertyAll(TextStyle(
                            fontSize: 25,
                          )),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.blue)))),
            ],
          ),
        ),
      ),
    );
  }
}
