import 'package:flutter/cupertino.dart';
import 'package:trace/enums/top_target.dart';

class BasicController extends ChangeNotifier {
  TopTarget topTarget = TopTarget.LIST;

  set setTopTarget(TopTarget newTopTarget) {
    topTarget = newTopTarget;
    notifyListeners();
  }
}
