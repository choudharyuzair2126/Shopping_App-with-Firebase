import 'package:app_ui/Screens/categories.dart';
import 'package:app_ui/Screens/home.dart';
import 'package:app_ui/Screens/profile.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BottomNAvigation extends StatefulWidget {
  int index1;
  BottomNAvigation({super.key, required this.index1});

  @override
  State<BottomNAvigation> createState() => _BottomNAvigationState();
}

class _BottomNAvigationState extends State<BottomNAvigation> {
  static final List<Widget> widgetList = [
    const Home(),
    const Categories(),
    const Profile(),
  ];
  ontaped(int index) {
    setState(() {
      widget.index1 = index;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  //int selectedindex = widget.index1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetList[widget.index1],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.index1,
          onTap: ontaped,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined), label: 'Categories'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined), label: 'Profile'),
          ]),
    );
  }
}
