import '../main_index.dart';

class FireAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user anoymously for favorites
  static Future<User> createUser() async {
    User _user;
    UserCredential value = await _auth.signInAnonymously();
    if (value != null) {
      _user = value.user;
    }
    return _user;
  }

  // check user login
  static UserLogin checkUser() {
    User _user = _auth.currentUser;
    if (_user != null) {
      return UserLogin(isLogin: true, user: _user);
    } else {
      return UserLogin(isLogin: false, user: null);
    }
  }
}

class UserLogin {
  final bool isLogin;
  final User user;

  UserLogin({this.isLogin, this.user});
}
