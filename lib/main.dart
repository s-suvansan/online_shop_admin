import 'main_index.dart';

void main() {
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Global.APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: BrandColors.brandColor,
      ),
      routes: {
        BookmarkView.routeName: (context) => BookmarkView(),
        AddProductView.routeName: (context) => AddProductView(),
      },
      home: SplashView(),
    );
  }
}
