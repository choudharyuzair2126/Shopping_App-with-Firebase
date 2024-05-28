import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BuyNow extends StatefulWidget {
  const BuyNow({Key? key}) : super(key: key);

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
              // Your CSCPicker code here

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
            'https://your-vercel-app-url.vercel.app/api/sendEmail'), // Replace with your serverless function URL
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
