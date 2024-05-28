// ignore_for_file: non_constant_identifier_names, unused_local_variable, use_build_context_synchronously
import 'package:app_ui/Screens/login.dart';
import 'package:app_ui/Services/uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();

  forgotPassword() async {
    try {
      var Usercredentials = await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.toString())
          .then((value) => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Login())));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UiHelper.customTextField(
                  emailController,
                  false,
                  TextInputType.emailAddress,
                  "Email",
                  const Icon(Icons.email_outlined)),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    forgotPassword();
                    // Navigator.of(context).pop();
                  },
                  child: const Text("Send")),
            ],
          ),
        ),
      ),
    );
  }
}
