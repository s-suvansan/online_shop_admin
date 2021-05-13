import '../main_index.dart';

class LanguageChange with ChangeNotifier {
  //variable
  LanguageModel _lang = LanguageModel();
  String _languageCode = Lang.English.code;

  //getter
  LanguageModel get lang => _lang;
  String get languageCode => _languageCode;

  // setter
  set setLanguageCode(String code) => _languageCode = code;

  // set language function
  void setLanguage(LanguageModel val) {
    _lang = val;
    notifyListeners();
  }

  // set language function from main
  void setLanguageInMain(String val) {
    // print(jsonEncode(val));
    Map _map = jsonDecode(val);
    _lang = LanguageModel.fromJson(_map);
  }
}
