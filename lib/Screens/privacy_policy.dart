import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
        child: SingleChildScrollView(
          child: Text(
            '''
  Privacy Policy for Shopping App
              This Privacy Policy describes how [Shopping App Name] collects, uses, and shares your personal information when you use our shopping application. Your privacy is important to us, and we are committed to protecting the information you share with us. Please read this Privacy Policy carefully to understand our practices regarding your personal data and how we will treat it.
              
  1. Information We Collect:
        - Personal Information: When you use Shopping App, we may collect personal information such as your name, email address, phone number, shipping address, and payment details (including credit card information) when you make a purchase.
        - Usage Information: We collect information about how you interact with our app, including your browsing activity, items you view or search for, and your preferences.
        - Device Information: We automatically collect certain information about your device, including the device type, operating system, unique device identifiers, and IP address.
              
  2. How We Use Your Information:
              We use the information we collect for the following purposes:
            - Providing Services: To process your orders, communicate with you about your purchases, and provide customer support.
            - Personalization: To personalize your shopping experience, recommend products, and show you relevant content.
            - Analytics and Improvement: To analyze trends, improve our app, and understand how users interact with our services.
            - Marketing: With your consent, to send you promotional emails, newsletters, and offers about our products and services.
              
  3. Information Sharing:
              We may share your personal information in the following circumstances:
              - Service Providers: We may share information with third-party service providers who help us operate our app, process payments, or provide other services on our behalf.
              - Legal Compliance: We may disclose information in response to a subpoena, court order, or other governmental request.
              - Business Transfers: If we are involved in a merger, acquisition, or sale of all or a portion of our assets, your information may be transferred as part of that transaction.
              
  4. Data Security:
              We take reasonable measures to protect your information from unauthorized access, alteration, disclosure, or destruction. However, no method of transmission over the internet or electronic storage is 100% secure.
              
  5. Your Choices:
              - Account Information: You can update or delete your account information at any time by logging into your account settings.
              - Marketing Communications: You can opt out of receiving marketing emails by following the instructions in the emails or contacting us directly.
              
  6. Children’s Privacy:
              Our app is not intended for use by children under the age of 13. We do not knowingly collect personal information from children under 13.
              
  7. Changes to This Policy:
              We may update this Privacy Policy from time to time. Any changes will be posted on this page, and we will notify you by email or through the app.
              
  8. Contact Us:
              If you have any questions or concerns about our Privacy Policy or practices, please contact us at uzair2126@proton.me.
              By using Shopping App , you agree to the collection and use of your information as described in this Privacy Policy.
              ''',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
