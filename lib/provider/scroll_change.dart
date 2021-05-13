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
}
