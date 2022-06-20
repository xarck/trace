import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:trace/constants/api_constant.dart';

class AuthController extends ChangeNotifier {
  Future<bool> checkLogin() async {
    Box authBox = Hive.box('auth');
    var isAuthorized = authBox.get('authorized', defaultValue: false);
    if (isAuthorized) {
      return await fetchToken();
    }
    return false;
  }

  fetchToken() async {
    Box authBox = Hive.box('auth');
    try {
      String refreshToken = authBox.get('refresh_token');
      Response response = await Dio()
          .get('$api_domain/refresh_token?refresh_token=$refreshToken');
      authBox.put('access_token', response.data);
      return true;
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
