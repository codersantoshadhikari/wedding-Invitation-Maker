import 'package:flutter/material.dart';
import 'package:weading/screens/carousel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CarouselDemo(),
      debugShowCheckedModeBanner: false,
    );
  }
}