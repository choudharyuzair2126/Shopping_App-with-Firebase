// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, use_build_context_synchronously
import 'package:app_ui/Screens/cart.dart';
import 'package:app_ui/Screens/show_product.dart';
import 'package:app_ui/Services/ingection.dart';
import 'package:app_ui/Services/product_model.dart';
import 'package:app_ui/Services/uihelper.dart';
import 'package:flutter/services.dart';
import 'package:app_ui/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ProductModel> filteredProducts = [];
  bool isLoading = true;
  late TextEditingController searchController;
  List<ProductModel> product = [];
  products() {
    client.getProducts().then((value) {
      setState(() {
        product = value;
        isloading = false;
        filteredProducts = List.of(product);
      });
    }).onError((error, stackTrace) {
      SnackBar(content: Text(error.toString()));
    });
  }

  bool isloading = true;
  @override
  void initState() {
    super.initState();
    uId();
    UiHelper.hello();
    setState(() {});
    products();
    searchController = TextEditingController();
  }

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

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterProducts(String query) {
    setState(() {
      filteredProducts = product.where((product) {
        final title = product.title?.toLowerCase();
        return title!.contains(query.toLowerCase());
      }).toList();
    });
  }

  counter(int count1) {
    FirebaseFirestore.instance
        .collection(token)
        .doc("count")
        .set({'count': count1 + 1});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Home'),
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
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  searchController.clear();
                  filterProducts('');
                });
              },
              icon: const Icon(Icons.clear),
            ),
          ],
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: isloading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 3),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20)),
                      child: TextField(
                        controller: searchController,
                        onChanged: filterProducts,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search products...',
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: filteredProducts.length,
                        itemBuilder: (BuildContext context, int index) {
                          final data = filteredProducts[index];

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
                            child: Card(
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
                                          width: 150,
                                          height: 150,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
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
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            bool isProductAlreadyAdded =
                                                await FirebaseFirestore.instance
                                                    .collection(token)
                                                    .doc(data.title.toString())
                                                    .get()
                                                    .then((docSnapshot) =>
                                                        docSnapshot.exists);

                                            if (!isProductAlreadyAdded) {
                                              counter(count1);
                                              uId();
                                              futureBuilder(
                                                data.image.toString(),
                                                data.title.toString(),
                                                data.price.toString(),
                                              );

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  backgroundColor: Colors.blue,
                                                  content:
                                                      Text('Added to Cart'),
                                                ),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  backgroundColor:
                                                      Colors.orange,
                                                  content: Text(
                                                      'This product is already in your cart!'),
                                                ),
                                              );
                                            }
                                          },
                                          style: const ButtonStyle(
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
                                                      Colors.blue)),
                                          child: const Text('Add to Cart')),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
      ),
    );
  }
}
