import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:trace/constants/api_constant.dart';

class AuthController extends ChangeNotifier {
<<<<<<< HEAD
  Future<bool> checkLogin() async {
    Box authBox = Hive.box('auth');
    var isAuthorized = authBox.get('authorized', defaultValue: false);
    if (isAuthorized) {
      return await fetchToken();
=======
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
>>>>>>> building
    }
    isAuthenticated = false;
    return false;
  }

  void authorize(String html) {
    Map valMap = json.decode(json.decode(html));
    Box authBox = Hive.box('auth');
    authBox.put('access_token', valMap['access_token']);
    authBox.put('refresh_token', valMap['refresh_token']);
    authBox.put('authenticated', true);
    isAuthenticated = true;
    notifyListeners();
  }

  fetchToken() async {
    Box authBox = Hive.box('auth');
    try {
      String refreshToken = authBox.get('refresh_token');
      Response response = await Dio()
          .get('$api_domain/refresh_token?refresh_token=$refreshToken');
      authBox.put('access_token', response.data);
<<<<<<< HEAD
      return true;
=======
      isAuthenticated = true;
>>>>>>> building
    } catch (err) {
      authBox.put("access_token", null);
      authBox.put('refresh_token', null);
      authBox.put('authorized', false);
      return false;
    }
  }

  void logout() {
    Box authBox = Hive.box('auth');
    authBox.put('access_token', null);
    notifyListeners();
  }
}
