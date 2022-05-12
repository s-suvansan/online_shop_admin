import 'main_index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Firebase.initializeApp();
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
        ImageUploadView.routeName: (context) => ImageUploadView(),
        ChatView.routeName: (context) => ChatView(),
        ChatListView.routeName: (context) => ChatListView(),
      },
      home: SplashView(),
    );
  }
}
