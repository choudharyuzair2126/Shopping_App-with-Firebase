import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BuyNow extends StatefulWidget {
  final name;
  final price;
  final description;
  const BuyNow(
      {super.key,
      required this.name,
      required this.price,
      required this.description});

  @override
  BuyNowState createState() => BuyNowState();
}

class BuyNowState extends State<BuyNow> {
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  // Product details

  double productPrice = 0;
  String productDescription = '';
  String productName = '';
  @override
  void initState() {
    super.initState();
    productPrice = widget.price;
    productDescription = widget.description;
    productName = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buy Now"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 600,
          child: Column(
            children: [
              CSCPicker(
                showStates: true,
                showCities: true,
                flagState: CountryFlag.ENABLE,
                dropdownDecoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                disabledDropdownDecoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey.shade300,
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                countrySearchPlaceholder: "Country",
                stateSearchPlaceholder: "State",
                citySearchPlaceholder: "City",
                countryDropdownLabel: "*Country",
                stateDropdownLabel: "*State",
                cityDropdownLabel: "*City",
                disableCountry: true,
                defaultCountry: CscCountry.Pakistan,
                selectedItemStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                dropdownHeadingStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                dropdownItemStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                dropdownDialogRadius: 10.0,
                searchBarRadius: 10.0,
                onCountryChanged: (value) {
                  setState(() {
                    countryValue = value;
                  });
                },
                onStateChanged: (value) {
                  setState(() {
                    stateValue = value.toString();
                  });
                },
                onCityChanged: (value) {
                  setState(() {
                    cityValue = value.toString();
                  });
                },
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    address = "$cityValue, $stateValue, $countryValue";
                  });
                },
                child: const Text("Print Data"),
              ),
              Text(address),
              ElevatedButton(
                onPressed: () {
                  _placeOrder();
                },
                child: const Text("Buy Now"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _placeOrder() async {
    // Save order to Firestore
    await FirebaseFirestore.instance.collection('orders').add({
      'address': address,
      'productName': productName,
      'productPrice': productPrice,
      'productDescription': productDescription,
      'timestamp': FieldValue.serverTimestamp(),
      // Add other order details here
    }).then((value) {
      // Handle successful order placement
      print('Order placed successfully');
      sendEmail();
    }).catchError((error) {
      // Handle error
      print('Failed to place order: $error');
    });
  }

  void sendEmail() async {
    var url =
        Uri.parse('https://earnest-pavlova-83413c.netlify.app/api/sendEmail');
    var response = await http.post(
      url,
      body: {
        'address': address,
        'productName': productName,
        'productPrice': productPrice.toString(),
        'productDescription': productDescription,
      },
    );

    if (response.statusCode == 200) {
      print('Email sent successfully');
    } else {
      print('Failed to send email. Error: ${response.statusCode}');
    }
  }
}
