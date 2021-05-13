import '../main_index.dart';

class Global {
  static const String APP_NAME = "SNS Beatz Admin";

  // firestore collection and feild name
  static const String PRODUCTS = "products";
  static const String POST_AT = "postAt";
  static const String FAVOURITE_USER_IDS = "favouriteUserIds";

  //user details
  // static FirebaseUser userInfo;

  // language firestroe collecton and document name
  static const String LANGUAGE = "languages";
  static const String TAMIL = "tamil";
  static const String ENGLISH = "english";
  static const String OUR_TAMIL = "our_tamil";

  //phone number related
  static const String PHONE_NUMBER = "phoneNumbers";
  static const String NUMBERS = "numbers";

  // phone numbers
  static PhoneNumberModel phoneNumberModel = PhoneNumberModel();
}
