import '../../main_index.dart';

class SplashViewModel extends BaseViewModel {
  // variables
  bool _isNoConnection = false;

  //getter
  bool get isNoInternet => _isNoConnection;

  // on init function
  void onInit(BuildContext context) {
    print("check");
    checkConnection(context);
  }

  // check internet available
  void checkConnection(BuildContext context) {
    /* Connectivity().checkConnectivity().then((result) {
      if (result != ConnectivityResult.none) {
        getPhoneNumbers();
        checkUserLogin(context);
      } else {
        print("no internet connection here");
        _isNoConnection = true;
        notifyListeners();
      }
    }); */
  }

  /* // check user login or  not
  void checkUserLogin(BuildContext context) {
    FireAuthService.checkUser().then((value) {
      if (value.isLogin) {
        print("user available");
        Global.userInfo = value.user;
        navigateToBaseLayoutView(context);
      } else {
        FireAuthService.createUser().then((user) {
          Global.userInfo = user;
          navigateToBaseLayoutView(context);
        });
      }
    });
  } */

  /*  //get phone numbers
  void getPhoneNumbers() {
    FireStoreService.getPhoneNumbers().then((value) {
      if (value != null) {
        Global.phoneNumberModel = value;
      }
    });
  } */

  /* // navigate to base layout view
  void navigateToBaseLayoutView(BuildContext context) {
    Future.delayed(Duration(milliseconds: 2000)).then((value) {
      Navigator.popAndPushNamed(context, BaseLayoutView.routeName);
    });
  } */
}
