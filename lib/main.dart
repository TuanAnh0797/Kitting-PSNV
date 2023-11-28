//import 'dart:async';
//import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'View/LoginPage/LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foss EID system',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginPage() ,
    );
  }


}