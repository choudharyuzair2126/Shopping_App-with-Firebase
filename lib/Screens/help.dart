import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
        child: SingleChildScrollView(child: Text('''
Welcome to Our Shopping App Help

 Frequently Asked Questions (FAQ)

1.  How do I create an account?
   - To create an account, tap on the "Sign Up" or "Register" button on the home screen. Follow the prompts to enter your details and set up your account.

2.  How do I place an order?
   - Browse for items you want to purchase, select the item, choose quantity, and add to cart. Proceed to checkout, review your order, select a payment method, and confirm your purchase.

3.  How can I track my order?
   - You can track your order in the "Orders" section of the app. Once your order is shipped, you will receive a tracking number via email or SMS. Enter this tracking number in the app to view the status of your delivery.

4.  How do I update my account information? 
   - Go to "My Account" or "Profile" settings within the app. Here you can update your personal information, shipping address, and payment methods.

5.  What payment methods are accepted? 
   - We accept credit/debit cards, PayPal, and other digital payment methods. You can manage your payment options in the "Payment Methods" section of your account.

 Contact Us 

If you have any further questions or need assistance, please reach out to our customer support team:

-  Email:  uzair2126@proton.me

 App Features 

-  Search:  Use the search bar to find specific products quickly.
-  Wishlist:  Save items you want to buy later in your wishlist.
-  Promotions:  Stay updated with our latest promotions and discounts.

 Troubleshooting 

-  App Crashing:  Try closing and reopening the app. If the issue persists, restart your device or reinstall the app.
-  Payment Issues:  Ensure your payment method is valid and has sufficient funds. Contact your bank if you encounter payment failures.

 Privacy & Security 

- Shopping App prioritizes the privacy and security of your data. We use industry-standard encryption to protect your personal information.

''')),
      ),
    );
  }
}
