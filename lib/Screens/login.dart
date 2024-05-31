// ignore_for_file: use_build_context_synchronously, unused_local_variable
import 'package:app_ui/Screens/bottomnavigation.dart';
import 'package:app_ui/Screens/forgot_password.dart';
import 'package:app_ui/Screens/help.dart';
import 'package:app_ui/Screens/privacy_policy.dart';
import 'package:app_ui/Screens/signup.dart';
import 'package:app_ui/Screens/account.dart';
import 'package:app_ui/Services/uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool val = false;
  login(String email, String password) async {
    if (email == "" || password == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all fields"),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        User? user = userCredential.user;
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
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Login()));
          }
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
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        UiHelper.pushReplacement(context, const Account());
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.red.shade600, Colors.orange],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.elliptical(90, 50),
                      bottomRight: Radius.elliptical(90, 50))),
              child: Column(
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
                                        UiHelper.push1(
                                            context, const Account());
                                      }),
                                  PopupMenuItem(
                                    value: 'Sign Up',
                                    child: const Text('Sign Up'),
                                    onTap: () {
                                      UiHelper.push1(context, const SignUp());
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 30, left: 15, right: 15, bottom: 15),
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
                            const Icon(Icons.password_outlined))),
                    GestureDetector(
                      onTap: () {
                        val = !val;
                        setState(() {});
                      },
                      child: Row(
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
                    ),
                    ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 211, 81, 189))),
                        onPressed: () {
                          login(emailController.text.toString(),
                              passwordController.text.toString());
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.black),
                        )),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text(
                        'Not a User yet? ',
                        style: TextStyle(color: Colors.black),
                      ),
                      UiHelper.customTextButton(
                          'Register',
                          () => UiHelper.push1(context, const SignUp()),
                          const TextStyle(),
                          const ButtonStyle())
                    ]),
                    const SizedBox(
                      height: 4,
                    ),
                    UiHelper.customElevatedButton(
                        "Forgot Password",
                        () => UiHelper.push1(context, const ForgotPassword()),
                        const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 244, 65, 125)),
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.black)))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
