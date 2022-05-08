import '../main_index.dart';

class ScrollChange with ChangeNotifier {
  //variable
  bool _isNotify = true;
  int _count = 10;

  //getter
  bool get isNotify => _isNotify;
  int get count => _count;

  //setter
  set setIsNotify(bool val) => _isNotify = val;

  void increseCount() {
    _count += 10;
    if (isNotify) {
      notifyListeners();
    }
  }

  //get phone status bar height
  double _statusBarHeight = 40.0;
  double get statusBarHeight => _statusBarHeight;
  set setStatusBarHeight(double value) => _statusBarHeight = value;
}
