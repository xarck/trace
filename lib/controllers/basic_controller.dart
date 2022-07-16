import 'package:flutter/cupertino.dart';
import 'package:trace/enums/top_target.dart';

class BasicController extends ChangeNotifier {
  TopTarget topTarget = TopTarget.GRID;

  void setTopTarget() {
    if (topTarget == TopTarget.LIST) {
      topTarget = TopTarget.GRID;
    } else {
      topTarget = TopTarget.LIST;
    }
    notifyListeners();
  }
}
