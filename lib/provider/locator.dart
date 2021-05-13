import '../main_index.dart';

GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<ThemeChange>(ThemeChange());
  getIt.registerSingleton<LanguageChange>(LanguageChange());
  getIt.registerSingleton<ScrollChange>(ScrollChange());
}
