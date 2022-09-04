import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:trace/controllers/auth_controller.dart';
import 'package:trace/controllers/basic_controller.dart';
import 'package:trace/controllers/media_controller.dart';
import 'package:trace/routes/route_generator.dart';
import 'package:trace/views/dashboard.dart';
import 'package:trace/views/login_view.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
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
  authentication() async {
    AuthController ac = Provider.of(context, listen: false);
    await ac.checkLogin();
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
        fontFamily: "Proxima",
        brightness: Brightness.dark,
        bottomAppBarColor: Colors.black,
        primarySwatch: Colors.green,
        focusColor: Colors.green,
        splashColor: Colors.green,
        tabBarTheme: TabBarTheme(
          // indicatorSize: ,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          titleMedium: TextStyle(
            fontSize: 22,
            color: Colors.white70,
          ),
          displayMedium: TextStyle(
            fontSize: 18,
            color: Colors.white,
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
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      home: Consumer<AuthController>(
        builder: (context, data, child) {
          return data.isAuthenticated ? Dashboard() : LoginView();
        },
      ),
    );
  }
}
