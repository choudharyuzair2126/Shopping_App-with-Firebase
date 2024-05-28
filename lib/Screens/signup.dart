// ignore_for_file: use_build_context_synchronously, unused_local_variable
import 'package:app_ui/Screens/bottomnavigation.dart';
import 'package:app_ui/Screens/help.dart';
import 'package:app_ui/Screens/login.dart';
import 'package:app_ui/Screens/privacy_policy.dart';
import 'package:app_ui/Services/uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  signUp(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      var name = user?.updateDisplayName(nameController.text.toString());

      if (user != null) {
        await user.sendEmailVerification();
        FirebaseAuth.instance.authStateChanges().listen((user) async {
          if (user != null) {
            if (user.emailVerified) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottomNAvigation(
                            index1: 0,
                          )));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Please verify your email address"),
                  duration: Duration(seconds: 2),
                ),
              );
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Login()));
            }
          }
        });
      }
    } on FirebaseAuthException catch (er) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(er.message.toString()),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  bool val = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        children: [
          UiHelper.customContainer(
            double.infinity,
            300,
            BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.red.shade600,
              Colors.orange,
            ])),
            Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Account details',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: PopupMenuButton(
                          iconColor: Colors.white,
                          itemBuilder: (context) => [
                                PopupMenuItem(
                                    value: 'Account',
                                    child: const Text('Account'),
                                    onTap: () {
                                      Navigator.pop(context);
                                    }),
                                PopupMenuItem(
                                  value: 'Sign In',
                                  child: const Text('Sign In'),
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Login()));
                                  },
                                ),
                                PopupMenuItem(
                                    value: 'Help',
                                    child: const Text('Help'),
                                    onTap: () {
                                      UiHelper.push1(
                                          context, const HelpScreen());
                                    }),
                                PopupMenuItem(
                                  child: const Text('Privacy Policy'),
                                  onTap: () => UiHelper.push1(
                                      context, const PrivacyPolicy()),
                                ),
                              ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              width: 300,
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 15, right: 15),
                      child: UiHelper.customTextField(
                          nameController,
                          false,
                          TextInputType.name,
                          "Name",
                          const Icon(Icons.person))),
                  Padding(
                      padding: const EdgeInsets.all(15),
                      child: UiHelper.customTextField(
                          emailController,
                          false,
                          TextInputType.emailAddress,
                          "Email",
                          const Icon(Icons.email_outlined))),
                  Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: UiHelper.customTextField(
                        passwordController,
                        !val,
                        TextInputType.visiblePassword,
                        "Password",
                        const Icon(Icons.password_outlined),
                      )),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Checkbox(
                            value: val,
                            onChanged: (bool? x) {
                              setState(() {
                                val = x!;
                              });
                            }),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        'Show password',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromARGB(255, 211, 81, 189))),
                      onPressed: () {
                        signUp(
                          emailController.text.toString(),
                          passwordController.text.toString(),
                        );
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
