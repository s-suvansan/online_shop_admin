import '../main_index.dart';

class FireStoreService {
  // get product snapshot for stream build
  static Stream<QuerySnapshot> getProducts({int limit = 10}) {
    return FirebaseFirestore.instance
        .collection(Global.PRODUCTS)
        .orderBy(Global.POST_AT, descending: true)
        .limit(limit)
        .snapshots();
  }

  // get language when change language
  static Future<LanguageModel> getLanguage({@required String docName}) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection(Global.LANGUAGE).doc(docName).get();
    if (doc != null && doc.data() != null) {
      return LanguageModel.fromJson(doc.data());
    }
    return null;
  }

  //get phone numbers
  static Future<PhoneNumberModel> getPhoneNumbers() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection(Global.PHONE_NUMBER).doc(Global.NUMBERS).get();
    if (doc != null && doc.data() != null) {
      return PhoneNumberModel.fromJson(doc.data());
    }
    return null;
  }

  //add product
  static Future<bool> addProduct(ProductModel data, {bool isEdit = false}) async {
    // Call the user's CollectionReference to add a new user
    try {
      await FirebaseFirestore.instance.collection(Global.PRODUCTS).doc(data.id).set(data.toJson(isEdit: isEdit));
      return true;
    } catch (e) {
      return false;
    }
  }

  // un favourite product function
  static Future<bool> removeImageUrl({@required String docId, @required String imageUrl}) async {
    bool _value = true;
    try {
      await FirebaseFirestore.instance.collection(Global.PRODUCTS).doc(docId).update(
        {
          "${Global.IMAGE_URLS}": FieldValue.arrayRemove([imageUrl]),
        },
      ).catchError((e) => _value = false);
    } catch (e) {
      print(e.toString());
      _value = false;
    }
    return _value;
  }

  //save data
  static void addLangData() async {
    try {
      await FirebaseFirestore.instance.collection(Global.LANGUAGE).doc(Global.OUR_TAMIL).set(
        {
          "home": "முன்பக்கம்",
          "favorites": "பிடிச்சது",
          "settings": "செட்டிங்",
          "min": "நிமிசம்",
          "mins": "நிமிசங்கள்",
          "hr": "மணி",
          "hrs": "மணி",
          "day": "நாள்",
          "days": "நாட்கள்",
          "month": "மாசம்",
          "months": "மாசங்கள்",
          "year": "வருசம்",
          "years": "வருசங்கள்",
          "ago": "ஆச்சு",
          "rs": "ரூ",
          "justNow": "இப்பதான்",
          "emptyProductList": "இஞ்ச ஒண்டுமில்ல.",
          "emptyFavList": "பிடிச்ச சாமான் ஒண்டுமில்ல .",
          "productInfo": "சாமான்ட விளக்கம் ",
          "postedAt": "{} அப்பதான் போட்டது.",
          "postedBy": "{} தான் போட்டவர்.",
          "negotiable": "கதச்சு எடுக்கலாம்",
          "desc": "விளக்கம்",
          "showMore": "இன்னும் பாக்கலாம்",
          "showLess": "சுருக்கி பாப்பம்",
          "call": "கோல் அடிக்க",
          "whatsapp": "வாட்ஸ்அப்",
          "sorryCouldnotOpen": "ஒண்டும் சரிவரேல்ல.",
          "selectNumber": "ஒரு நம்பர குடு",
          "noNetConnection": "கவரேஜ் இல்ல போல.",
          "retry": "திரும்பவும் குடு",
          "changeTheme": "கலர மாத்து",
          "selectLang": "பாசைய மாத்து",
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
