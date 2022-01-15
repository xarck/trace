import 'package:flutter/material.dart';
import 'package:trace/views/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trace',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
    );
  }
}
