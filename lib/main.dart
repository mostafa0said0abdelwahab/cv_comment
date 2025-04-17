import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WhiteScreen(),
    );
  }
}

class WhiteScreen extends StatelessWidget {
  const WhiteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // الخلفية الافتراضية لـ Scaffold بيضاء،
      // لكن يمكنك تحديد اللون صراحةً:
      backgroundColor: Colors.white,
      body: SizedBox.expand(), // يغطي كامل الشاشة
    );
  }
}
