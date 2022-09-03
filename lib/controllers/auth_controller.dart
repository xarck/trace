import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trace/constants/api_constant.dart';
import 'package:trace/views/dashboard.dart';
import 'package:trace/views/login_view.dart';

class AuthController extends ChangeNotifier {
  late bool isAuthenticated = false;

  Future<bool> checkLogin(BuildContext context) async {
    Box authBox = Hive.box('auth');
    var token = authBox.get('access_token');
    if (token == null) {
      isAuthenticated = false;
      return false;
    } else if (token.length != 0) {
      await fetchToken(context);
      return true;
    }
    logout(context);
    return false;
  }

  bool authorize(String html) {
    Map valMap = json.decode(json.decode(html));
    Box authBox = Hive.box('auth');
    authBox.put('access_token', valMap['access_token']);
    authBox.put('refresh_token', valMap['refresh_token']);
    authBox.put('authenticated', true);
    isAuthenticated = true;
    notifyListeners();
    return true;
  }

  fetchToken(BuildContext context) async {
    try {
      Box authBox = Hive.box('auth');
      String refreshToken = authBox.get('refresh_token');
      Response response = await Dio()
          .get('$api_domain/refresh_token?refresh_token=$refreshToken');
      authBox.put('access_token', response.data);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(),
        ),
      );
      isAuthenticated = true;
    } catch (err) {
      logout(context);
    }
  }

  void logout(BuildContext context) {
    Box authBox = Hive.box('auth');
    authBox.clear();
    isAuthenticated = false;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginView(),
      ),
    );
    notifyListeners();
  }
}
