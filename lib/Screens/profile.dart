import 'package:app_ui/Screens/bottomnavigation.dart';
import 'package:app_ui/Screens/login.dart';
import 'package:app_ui/Screens/update_profile.dart';
import 'package:app_ui/Services/uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var name = '';
  var email = '';

  userdata() async {
    email = FirebaseAuth.instance.currentUser!.email.toString();
    name = FirebaseAuth.instance.currentUser!.displayName.toString();

    setState(() {});
  }

  String? imageUrl;
  Future<String?> pickAndUploadImage() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return null;
    }

    try {
      setState(() {
        // isLoading = true;
      });
      final image = await pickImage(context);
      if (image != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_pictures/${user.uid}');

        final bytes = !kIsWeb ? await image.readAsBytes() : image;
        final uploadTask = storageRef.putData(bytes);
        await uploadTask.whenComplete(() => {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.blue,
                  content: Text('Updating Profile Image')))
            });

        final url = await getImageUrl(storageRef);
        setState(() {
          imageUrl = url;
          //     isLoading = false;
        });
        return url;
      } else {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.blue,
              content: Text('No image selected')));
        });

        return null;
      }
    } on Exception catch (error) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.blue,
            content: Text('Error picking or uploading image: $error')));
      });
      return null;
    }
  }

  Future<dynamic> pickImage(BuildContext context) async {
    if (kIsWeb) {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      return image;
    } else {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.gallery);
      return image;
    }
  }

  Future<String?> getImageUrl(storageRef) async {
    final url = await storageRef.getDownloadURL();
    return url;
  }

  @override
  void initState() {
    userdata();

    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final storageRef =
          FirebaseStorage.instance.ref().child('profile_pictures/${user.uid}');
      storageRef.getDownloadURL().then((url) {
        setState(() {
          imageUrl = url;
        });
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        UiHelper.pushReplacement(
          context,
          BottomNAvigation(index1: 0),
        );
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("User's Profile"),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blue,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Stack(children: [
                    CircleAvatar(
                        backgroundColor: Colors.grey.shade200,
                        radius: 100,
                        backgroundImage: imageUrl == null
                            ? const NetworkImage(
                                'https://www.jing.fm/clipimg/full/115-1152777_profile-png-man-user-icon.png')
                            : NetworkImage(imageUrl!)),
                    Positioned(
                        //  top: 110,
                        bottom: -4,
                        right: 75,
                        child: IconButton(
                          icon: const Icon(
                            Icons.add_a_photo_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            pickAndUploadImage();
                          },
                        ))
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue.shade100),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.person),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationThickness: 1.3,
                            )),
                        const Expanded(child: SizedBox()),
                        IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const UpdateName()));
                            })
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.shade100,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.email),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(email,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              decoration: TextDecoration.underline,
                              decorationThickness: 1.3,
                              decorationStyle: TextDecorationStyle.solid,
                            )),
                        const Expanded(child: SizedBox()),
                        IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const UpdateEmail()));
                              setState(() {});
                            })
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.shade100,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.lock),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("***Password***",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              decoration: TextDecoration.underline,
                              decorationThickness: 1.3,
                              decorationStyle: TextDecorationStyle.solid,
                            )),
                        const Expanded(child: SizedBox()),
                        IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const UpdatePassword()));
                            })
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                UiHelper.customElevatedButton("Logout", () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("Logout"),
                            content: const Text(
                                "Are you sure you want to Logout from this account"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cencel")),
                              TextButton(
                                child: const Text("Ok"),
                                onPressed: () {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Login()));
                                },
                              )
                            ],
                          ));
                },
                    ButtonStyle(
                      textStyle: const MaterialStatePropertyAll(
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      foregroundColor:
                          const MaterialStatePropertyAll(Colors.black),
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: const BorderSide(
                                color: Colors.black, width: 1.5)),
                      ),
                      elevation: MaterialStateProperty.all(9),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                UiHelper.customElevatedButton("Delete Account", () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("Delete Account"),
                            content: const Text(
                                "Are you sure you want to delete this account "),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cencel")),
                              TextButton(
                                child: const Text("Ok"),
                                onPressed: () {
                                  FirebaseAuth.instance.currentUser!.delete();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Login()));
                                },
                              )
                            ],
                          ));
                },
                    ButtonStyle(
                      textStyle: const MaterialStatePropertyAll(
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      foregroundColor:
                          const MaterialStatePropertyAll(Colors.black),
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: const BorderSide(
                                color: Colors.black, width: 1.5)),
                      ),
                      elevation: MaterialStateProperty.all(9),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                    ))
              ],
            ),
          )),
    );
  }
}
