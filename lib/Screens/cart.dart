// ignore_for_file: deprecated_member_use

import 'package:app_ui/Screens/bottomnavigation.dart';
import 'package:app_ui/Screens/buynow.dart';
import 'package:app_ui/Services/uihelper.dart';
import 'package:app_ui/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNAvigation(index1: 0)));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Cart'),
              UiHelper.badge(IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: const Icon(Icons.shopping_cart),
                style:
                    const ButtonStyle(iconSize: MaterialStatePropertyAll(33)),
              ))
            ],
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                UiHelper.pushReplacement(
                    context,
                    BottomNAvigation(
                      index1: 0,
                    ));
              },
              icon: const Icon(Icons.arrow_back_sharp)),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection(token).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return snapshot.data!.docs.length == 1
                ? const Center(
                    child:
                        Text("Your Cart is empty Add some items to your cart"),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.docs.length - 1,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(snapshot
                                                .data!.docs[index]["image"]))),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Price: ${snapshot.data!.docs[index]["price"]}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const Text(' \$',
                                      style: TextStyle(fontSize: 15)),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const Icon(
                                    Icons.star,
                                    size: 15,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                ],
                              ),
                              Text(
                                snapshot.data!.docs[index]["name"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: UiHelper.customElevatedButton(
                                        "Buy Now",
                                        () => UiHelper.push1(
                                            context,
                                            BuyNow(
                                                name: snapshot.data!.docs[index]
                                                    ["name"],
                                                price: snapshot
                                                    .data!.docs[index]["price"],
                                                description:
                                                    snapshot.data!.docs[index]
                                                        ["description"])),
                                        const ButtonStyle(
                                            foregroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.black),
                                            textStyle: MaterialStatePropertyAll(
                                                TextStyle(
                                              fontSize: 25,
                                            )),
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.blue))),
                                  ),
                                  // const Expanded(child: SizedBox()),
                                  IconButton(
                                      iconSize: 30,
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            duration:
                                                Duration(milliseconds: 800),
                                            backgroundColor: Colors.orange,
                                            content: Text('Product Removed'),
                                          ),
                                        );
                                        snapshot.data!.docs[index].reference
                                            .delete();
                                        count1 = count1 - 1;
                                        setState(() {});

                                        if (snapshot.data!.docs.length == 2 ||
                                            snapshot.data!.docs.length == 1) {
                                          FirebaseFirestore.instance
                                              .collection(token)
                                              .doc("count")
                                              .update({"count": 0});
                                          setState(() {});
                                          count1 = 0;
                                        }
                                      },
                                      icon: const Icon(EvaIcons.trash))
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
