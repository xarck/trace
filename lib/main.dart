import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trace/views/auth/login_view.dart';
import 'package:trace/views/dashboard.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('auth');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var token = '';
  @override
  void initState() {
    super.initState();
    Box authBox = Hive.box('auth');
    token = authBox.get('access_token', defaultValue: '');
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trace',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: token.length == 0 ? LoginView() : Dashboard(),
    );
  }
}
