import 'package:flutter/material.dart';
import 'package:trace/views/dashboard.dart';
import 'package:trace/views/login_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Map args = settings.arguments as Map;
    switch (settings.name) {
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => Dashboard());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginView());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
