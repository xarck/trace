import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:trace/controllers/auth_controller.dart';
import 'package:trace/controllers/media_controller.dart';
import 'package:trace/views/login_view.dart';
import 'package:trace/views/dashboard.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('auth');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MediaController(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthController(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool token = true;

  authentication() async {
    AuthController ac = Provider.of(context, listen: false);
    token = await ac.checkLogin();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    authentication();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trace',
      theme: ThemeData(
        fontFamily: "Proxima",
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: token ? Dashboard() : LoginView(),
    );
  }
}
