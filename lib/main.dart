import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:trace/controllers/auth_controller.dart';
import 'package:trace/controllers/basic_controller.dart';
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
        ChangeNotifierProvider(
          create: (context) => BasicController(),
        )
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
<<<<<<< HEAD
  bool token = false;
  bool loading = true;

  authentication() async {
    AuthController ac = Provider.of<AuthController>(context, listen: false);
    token = await ac.checkLogin();
    loading = false;
    setState(() {});
=======
  authentication() async {
    AuthController ac = Provider.of(context, listen: false);
    await ac.checkLogin();
>>>>>>> building
  }

  @override
  void initState() {
    super.initState();
    authentication();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trace',
      theme: ThemeData(
<<<<<<< HEAD
        primarySwatch: Colors.purple,
=======
        fontFamily: "Proxima",
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          titleMedium: TextStyle(
            fontSize: 22,
            color: Colors.white70,
          ),
          displayLarge: TextStyle(
            fontSize: 18,
            color: Colors.white54,
          ),
          labelMedium: TextStyle(
            fontSize: 16,
            color: Colors.white24,
          ),
          labelLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.white54,
          ),
        ),
>>>>>>> building
      ),
      debugShowCheckedModeBanner: false,
      home: Consumer<AuthController>(
        builder: (context, data, child) {
          return data.isAuthenticated ? Dashboard() : LoginView();
        },
      ),
    );
  }
}
