import '../main_index.dart';

class ThemeChange with ChangeNotifier {
  //variable
  bool _isDark = false;

  //getter
  bool get isDark => _isDark;

  //setter
  set setIsDark(bool val) => _isDark = val;

  //change dark
  void changedark() {
    _isDark = !_isDark;
    App.setIsDark(value: _isDark);
    notifyListeners();
  }
}
