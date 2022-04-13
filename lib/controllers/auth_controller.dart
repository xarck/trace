import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:trace/constants/api_constant.dart';

class AuthController extends ChangeNotifier {
  bool isAuthenticated = false;

  Future<bool> checkLogin() async {
    Box authBox = Hive.box('auth');
    var token = authBox.get('access_token');
    if (token.length != 0) {
      await fetchToken();
      return true;
    }
    return false;
  }

  fetchToken() async {
    try {
      Box authBox = Hive.box('auth');
      String refreshToken = authBox.get('refresh_token');
      Response response = await Dio()
          .get('$api_domain/refresh_token?refresh_token=$refreshToken');
      authBox.put('access_token', response.data);
    } catch (err) {
      print(err.toString());
    }
  }

  void logout() {
    Box authBox = Hive.box('auth');
    authBox.put('access_token', null);
    notifyListeners();
  }
}