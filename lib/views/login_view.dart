import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:trace/constants/api_constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final _key = UniqueKey();
  var _controller;
  void readJS() async {
    String html = await _controller.evaluateJavascript(
        "window.document.getElementsByTagName('pre')[0].innerHTML;");
    Map valMap = json.decode(json.decode(html));
    Box authBox = Hive.box('auth');
    authBox.put('access_token', valMap['access_token']);
    authBox.put('refresh_token', valMap['refresh_token']);
    authBox.put('authenticated', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello World"),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: WebView(
              key: _key,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: api_domain + '/login',
              onWebViewCreated: (controller) {
                _controller = controller;
              },
              onPageStarted: (String url) async {
                if (url.contains('/callback')) {
                  readJS();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
