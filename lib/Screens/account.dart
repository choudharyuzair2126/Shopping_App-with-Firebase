import 'package:app_ui/Screens/login.dart';
import 'package:app_ui/Screens/signup.dart';
import 'package:app_ui/Services/uihelper.dart';
import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UiHelper.customContainer(
              double.infinity,
              300,
              const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromARGB(255, 236, 11, 176),
                Color.fromARGB(249, 248, 141, 0),
              ])),
              const Column(children: [
                SizedBox(
                  height: 30,
                ),
                Icon(
                  Icons.shopify,
                  size: 150,
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    )),
                SizedBox(
                  height: 30,
                )
              ]),
            ),
            const SizedBox(
              height: 60,
            ),
            UiHelper.customContainer(
                85,
                45,
                BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 236, 11, 176),
                      Color.fromARGB(249, 248, 141, 0),
                    ]),
                    borderRadius: BorderRadius.circular(20)),
                UiHelper.customTextButton(
                  "Login",
                  () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login())),
                  const TextStyle(color: Colors.black, fontSize: 20),
                  const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.transparent)),
                )),
            const SizedBox(
              height: 30,
            ),
            UiHelper.customContainer(
                90,
                45,
                BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 236, 11, 176),
                        Color.fromARGB(249, 248, 141, 0),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20)),
                UiHelper.customTextButton(
                  "SignUp",
                  () => UiHelper.push1(context, const SignUp()),
                  const TextStyle(color: Colors.black, fontSize: 20),
                  const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.transparent)),
                )),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
