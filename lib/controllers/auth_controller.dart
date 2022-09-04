import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trace/constants/api_constant.dart';
import 'package:trace/main.dart';

class AuthController extends ChangeNotifier {
  late bool isAuthenticated = false;

  Future<bool> checkLogin() async {
    Box authBox = Hive.box('auth');
    var token = authBox.get('access_token');
    if (token == null) {
      isAuthenticated = false;
      return false;
    } else if (token.length != 0) {
      await fetchToken();
      return true;
    }
    logout();
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

  fetchToken() async {
    try {
      Box authBox = Hive.box('auth');
      String refreshToken = authBox.get('refresh_token');
      Response response = await Dio()
          .get('$api_domain/refresh_token?refresh_token=$refreshToken');
      authBox.put('access_token', response.data);
      navigatorKey.currentState?.pushNamed("/dashbaord");
      isAuthenticated = true;
    } catch (err) {
      logout();
    }
  }

  void logout() {
    Box authBox = Hive.box('auth');
    authBox.clear();
    isAuthenticated = false;
    navigatorKey.currentState?.pushNamed('/login');
    notifyListeners();
  }
}
