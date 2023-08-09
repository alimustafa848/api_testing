import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'news.dart';

void main() {

  
  runApp(
    
    const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white
        ),
        primaryColor: Colors.white),
      home: Scaffold(
        body: News(),
      ),
    );
  }
}