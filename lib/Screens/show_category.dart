// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:app_ui/Screens/bottomnavigation.dart';
import 'package:app_ui/Screens/cart.dart';
import 'package:app_ui/Screens/show_product.dart';
import 'package:app_ui/Services/ingection.dart';
import 'package:app_ui/Services/product_model.dart';
import 'package:app_ui/Services/uihelper.dart';
import 'package:app_ui/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowCategory extends StatefulWidget {
  final category;
  const ShowCategory({super.key, required this.category});

  @override
  State<ShowCategory> createState() => _ShowCategoryState();
}

class _ShowCategoryState extends State<ShowCategory> {
  List<ProductModel> product = [];
  products() {
    client.getProducts().then((value) {
      setState(() {
        product = value;
        isloading = false;
      });
    }).onError((error, stackTrace) {
      SnackBar(content: Text(error.toString()));
    });
  }

  bool isloading = true;

  @override
  void initState() {
    super.initState();
    products();
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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        UiHelper.pushReplacement(
            context,
            BottomNAvigation(
              index1: 1,
            ));
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.category.toString()),
                UiHelper.badge(IconButton(
                  onPressed: () {
                    UiHelper.push1(context, const Cart());
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
                        index1: 1,
                      ));
                },
                icon: const Icon(Icons.arrow_back)),
          ),
          body: isloading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: product.length,
                  itemBuilder: (BuildContext context, int index) {
                    final data = product[index];

                    return InkWell(
                      onTap: () => UiHelper.push1(
                          context,
                          ShowProduct(
                              image1: data.image.toString(),
                              name: data.title,
                              price: data.price,
                              description: data.description,
                              rating: data.rating,
                              category: data.category)),
                      child: data.category == widget.category.toString()
                          ? Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      data.image.toString()))),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Price: ${data.price}",
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
                                        Text(
                                          "Rating: ${data.rating?.rate.toString()}",
                                          textScaler:
                                              const TextScaler.linear(1.1),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          "(${data.rating?.count.toString()})",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500),
                                          textScaler:
                                              const TextScaler.linear(1.1),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      data.title.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                        width: double.infinity,
                                        child: UiHelper.customElevatedButton(
                                            'Add to Cart', () async {
                                          bool isProductAlreadyAdded =
                                              await FirebaseFirestore.instance
                                                  .collection(token)
                                                  .doc(data.title.toString())
                                                  .get()
                                                  .then((docSnapshot) =>
                                                      docSnapshot.exists);

                                          if (!isProductAlreadyAdded) {
                                            counter(count1);

                                            futureBuilder(
                                              data.image.toString(),
                                              data.title.toString(),
                                              data.price.toString(),
                                            );

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                duration:
                                                    Duration(milliseconds: 500),
                                                backgroundColor: Colors.blue,
                                                content: Text('Added to Cart'),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                duration:
                                                    Duration(milliseconds: 500),
                                                backgroundColor: Colors.orange,
                                                content: Text(
                                                    'This product is already in your cart!'),
                                              ),
                                            );
                                          }
                                        },
                                            const ButtonStyle(
                                                foregroundColor:
                                                    MaterialStatePropertyAll(
                                                        Colors.black),
                                                textStyle:
                                                    MaterialStatePropertyAll(
                                                        TextStyle(
                                                  fontSize: 25,
                                                )),
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Colors.blue)))),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox(),
                    );
                  })),
    );
  }
}
