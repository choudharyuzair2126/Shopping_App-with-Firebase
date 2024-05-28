import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Badge1 extends StatefulWidget {
  const Badge1({super.key});

  @override
  State<Badge1> createState() => _Badge1State();
}

class _Badge1State extends State<Badge1> {
  int _count = 0;

  Future<void> _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _count++;
      prefs.setInt('count', _count);
    });
  }

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
        badgeStyle: const badges.BadgeStyle(
            padding: EdgeInsets.all(6), badgeColor: Colors.white24),
        badgeContent: Text(
          _count.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        child: IconButton(
          onPressed: _incrementCounter,
          icon: const Icon(Icons.shopping_cart),
          style: const ButtonStyle(iconSize: MaterialStatePropertyAll(30)),
        ));
  }
}
