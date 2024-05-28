import 'package:app_ui/Screens/login.dart';
import 'package:app_ui/Screens/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateEmail extends StatefulWidget {
  const UpdateEmail({super.key});

  @override
  State<UpdateEmail> createState() => _UpdateEmailState();
}

class _UpdateEmailState extends State<UpdateEmail> {
  TextEditingController emailController = TextEditingController();

  updateemail() {
    if (emailController.text.toString() == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email'),
        ),
      );
    } else {
      FirebaseAuth.instance.currentUser!
          .verifyBeforeUpdateEmail(emailController.text.toString())
          .onError(
            (error, stackTrace) => showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Verification'),
                    content:
                        const Text('Please Login Again to change your email'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        },
                        child: const Text('Ok'),
                      ),
                    ],
                  );
                }),
          )
          .then((value) {
        FirebaseAuth.instance.currentUser!.sendEmailVerification();
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Verification'),
                content: const Text(
                    'Please verify your email and login again using new email address'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    },
                    child: const Text('Ok'),
                  ),
                ],
              );
            });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Email'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  labelText: 'Email',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: const ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(Colors.black),
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 87, 176, 248))),
              child: const Text('Update'),
              onPressed: () {
                updateemail();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UpdateName extends StatefulWidget {
  const UpdateName({super.key});

  @override
  State<UpdateName> createState() => _UpdateNameState();
}

class _UpdateNameState extends State<UpdateName> {
  TextEditingController nameController = TextEditingController();
  updateName() {
    if (nameController.text.toString() == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your name'),
        ),
      );
    } else {
      FirebaseAuth.instance.currentUser!
          .updateDisplayName(nameController.text.toString())
          .onError(
            (error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.toString()),
              ),
            ),
          )
          .then((value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Profile()));
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Name'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Text('Update Name'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  labelText: 'Name',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: const ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(Colors.black),
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 87, 176, 248))),
              child: const Text('Update'),
              onPressed: () {
                updateName();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  bool val = false;
  TextEditingController passwordController = TextEditingController();
  updatePassword() {
    if (passwordController.text.toString() == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your password'),
        ),
      );
    } else {
      FirebaseAuth.instance.currentUser!
          .updatePassword(passwordController.text.toString())
          .onError((error, stackTrace) => showDialog(
              context: context,
              builder: (context) {
                return ScaffoldMessenger(
                    child: SnackBar(content: Text(error.toString())));
              }))
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password changed successfully"),
          ),
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Profile()));
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Password'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Text('Update Name'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: !val,
                obscuringCharacter: "*",
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  labelText: 'New Password',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                    value: val,
                    onChanged: (bool? x) {
                      setState(() {
                        val = x!;
                      });
                    }),
                const Text('Show Password'),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: const ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(Colors.black),
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 87, 176, 248))),
              child: const Text('Update'),
              onPressed: () {
                updatePassword();
              },
            ),
          ],
        ),
      ),
    );
  }
}
