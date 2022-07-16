import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trace/constants/api_constant.dart';
<<<<<<< HEAD
import 'package:trace/views/dashboard.dart';
=======
import 'package:trace/controllers/auth_controller.dart';
>>>>>>> building
import 'package:webview_flutter/webview_flutter.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _key = UniqueKey();
<<<<<<< HEAD
  var _controller;

  void readJS(BuildContext context) async {
    String html = await _controller.evaluateJavascript(
        "window.document.getElementsByTagName('pre')[0].innerHTML;");
    Map valMap = json.decode(json.decode(html));
    Box authBox = Hive.box('auth');
    authBox.put('access_token', valMap['access_token']);
    authBox.put('refresh_token', valMap['refresh_token']);
    authBox.put('authorized', true);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Dashboard(),
      ),
    );
=======

  late AuthController ac;

  late dynamic _controller;

  @override
  void initState() {
    super.initState();
    ac = Provider.of<AuthController>(context, listen: false);
  }

  void readJS() async {
    String html = await _controller.evaluateJavascript(
        "window.document.getElementsByTagName('pre')[0].innerHTML;");
    ac.authorize(html);
>>>>>>> building
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
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
                  readJS(context);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
