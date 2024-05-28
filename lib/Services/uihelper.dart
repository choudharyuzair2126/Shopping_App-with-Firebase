import 'package:app_ui/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class UiHelper {
  static customTextField(
    controller,
    bool obsecureText,
    TextInputType textInputType,
    String label,
    Icon icon,
  ) {
    return TextField(
      controller: controller,
      obscureText: obsecureText,
      keyboardType: textInputType,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        suffix: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(style: BorderStyle.solid, width: 12),
        ),
        labelText: label,
      ),
    );
  }

  static customElevatedButton(
      String text, Function() onPressed, ButtonStyle buttonStyle) {
    return ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: Text(text),
    );
  }

  static customTextButton(String text, Function() onPressed,
      TextStyle textStyle, ButtonStyle buttonStyle) {
    return TextButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }

  static customContainer(
    double width,
    double height,
    Decoration boxDecoration,
    Widget child,
  ) {
    return Container(
        width: width, height: height, decoration: boxDecoration, child: child);
  }

  static pushReplacement(context, pageRoute) {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => pageRoute));
  }

  static push1(context, pageRoute) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => pageRoute));
  }

  static Future<void> hello() async {
    final count = await FirebaseFirestore.instance
        .collection(token)
        .doc('count')
        .get()
        .then((value) => value.data()?['count']);
    try {
      count1 = int.parse(count.toString());
    } on FormatException {
      count1 = 0;
    }
  }

  static badge(Widget iconButton) {
    return badges.Badge(
        badgeStyle: const badges.BadgeStyle(
            padding: EdgeInsets.all(5), badgeColor: Colors.white24),
        badgeContent: Text(
          count1.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        child: iconButton);
  }
}
