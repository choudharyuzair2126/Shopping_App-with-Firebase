import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:csc_picker/csc_picker.dart';

class BuyNow extends StatefulWidget {
  const BuyNow({super.key});

  @override
  _BuyNowState createState() => _BuyNowState();
}

class _BuyNowState extends State<BuyNow> {
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";

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
                onPressed: () async {
                  String address = "$cityValue, $stateValue, $countryValue";
                  await sendEmail(address);
                },
                child: const Text("Send Email"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendEmail(String address) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://app-q8eg2btkd-uzairs-projects-8123cd52.vercel.app/api/sendEmail'), // Replace with your serverless function URL
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'address': address,
        }),
      );

      if (response.statusCode == 200) {
        print('Email sent successfully');
        // Handle success, e.g., show a success message
      } else {
        print('Failed to send email. Status code: ${response.statusCode}');
        // Handle error, e.g., show an error message
      }
    } catch (e) {
      print('Error sending email: $e');
      // Handle error, e.g., show an error message
    }
  }
}
