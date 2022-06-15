import 'package:flutter/material.dart';

class NavigatorUtils {
  static void navigateTo(BuildContext context, Widget page){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>page));
  }
}