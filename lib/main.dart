import 'package:flutter/material.dart';

import 'mainSensors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Elso teljes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MainSensors(title: 'Flutter Elso teljes'),
    );
  }
}