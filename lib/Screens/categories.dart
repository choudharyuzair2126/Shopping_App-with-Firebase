import 'package:app_ui/Screens/cart.dart';
import 'package:app_ui/Screens/show_category.dart';
import 'package:app_ui/Services/ingection.dart';
import 'package:app_ui/Services/product_model.dart';
import 'package:app_ui/Services/uihelper.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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
    setState(() {});
    products();
  }

  // var count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Categories'),
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
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            InkWell(
              onTap: () => UiHelper.push1(
                  context, const ShowCategory(category: "jewelery")),
              child: Card(
                elevation: 3,
                color: Colors.blue.shade300,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.purple.shade200,
                        child: const Text('0'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Jewelery',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => UiHelper.push1(
                  context, const ShowCategory(category: "electronics")),
              child: Card(
                elevation: 3,
                color: Colors.blue.shade300,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.purple.shade200,
                        child: const Text('1'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Electronics',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => UiHelper.push1(
                  context, const ShowCategory(category: "women's clothing")),
              child: Card(
                elevation: 3,
                color: Colors.blue.shade300,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.purple.shade200,
                        child: const Text('2'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Women's clothing",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => UiHelper.push1(
                  context, const ShowCategory(category: "men's clothing")),
              child: Card(
                elevation: 3,
                color: Colors.blue.shade300,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.purple.shade200,
                        child: const Text('3'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Men's clothing",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
