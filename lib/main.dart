import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:trace/controllers/auth_controller.dart';
import 'package:trace/controllers/basic_controller.dart';
import 'package:trace/controllers/media_controller.dart';
import 'package:trace/routes/route_generator.dart';
import 'package:trace/utils/util.dart';
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
        bottomAppBarColor: hexToColor("2C3639"),
        primarySwatch: Colors.green,
        focusColor: Colors.green,
        splashColor: Colors.green,
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: hexToColor("2C3639"),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: hexToColor("2C3639"),
        ),
        scaffoldBackgroundColor: hexToColor("2C3639"),
        textTheme: TextTheme(
          titleMedium: TextStyle(
            fontSize: 22,
            color: hexToColor("DCD7C9"),
          ),
          displayMedium: TextStyle(
            fontSize: 18,
            color: hexToColor("DCD7C9"),
          ),
          displayLarge: TextStyle(
            fontSize: 16,
            color: hexToColor("DCD7C9"),
          ),
          labelMedium: TextStyle(
            fontSize: 14,
            color: hexToColor("DCD7C9"),
          ),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: hexToColor("DCD7C9"),
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
