import 'package:intl/intl.dart';

import '../main_index.dart';

class App {
  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static Random _rnd = Random();
  static NumberFormat currencyFormat = new NumberFormat("#,##0.00", "en_US");

  // shareprefrence key const
  static const IS_DARK = 'is_dark';
  static const USER_ID = 'user_id';
  static const LANG = 'language';
  static const LANG_CODE = 'language_code';

  //Get the devie Hight
  static double getDeviceHight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  //Get the device width
  static double getDeviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // pop screen once
  static void popOnce(BuildContext context) {
    Navigator.of(context).pop();
  }

  // get random string for message id
  static String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  // get price with currency code
  static String getPrice(var price, {bool needSpace = true}) {
    String _value = "";
    double _price = 0.00;

    try {
      if (price != null && price != "") {
        _price = double.parse(price.toString());
      }
      _value = needSpace
          ? "${getIt<LanguageChange>().lang.rs}. ${currencyFormat.format(_price).toString()}"
          : "${getIt<LanguageChange>().lang.rs}.${currencyFormat.format(_price).toString()}";
    } catch (e) {
      _value = needSpace ? "${getIt<LanguageChange>().lang.rs}. 0.00" : "${getIt<LanguageChange>().lang.rs}.0.00";
    }
    return _value;
  }

  // svg image view
  static SvgPicture svgImage({
    @required String svg,
    Color color,
    double width = 50.0,
    double height = 50.0,
  }) {
    return SvgPicture.asset(
      svg,
      color: color,
      width: width,
      height: height,
    );
  }

  // get time
  static String getTime(Timestamp postAt) {
    String _value = "";
    Timestamp _now = Timestamp.now();
    try {
      Timestamp _postAt = postAt;
      int _time = _now.seconds - _postAt.seconds;
      if (_time < 60) {
        //1min - 60 sec
        _value = "${getIt<LanguageChange>().lang.justNow}";
      } else if (_time < 3600) {
        //1hr - 3600 sec
        _value =
            "${_time ~/ 60} ${(_time ~/ 60) > 1 ? "${getIt<LanguageChange>().lang.mins}" : "${getIt<LanguageChange>().lang.min}"} ${getIt<LanguageChange>().lang.ago}";
      } else if (_time < 86400) {
        //1day - 86400 sec
        _value =
            "${_time ~/ 3600} ${(_time ~/ 3600) > 1 ? "${getIt<LanguageChange>().lang.hrs}" : "${getIt<LanguageChange>().lang.hr}"} ${getIt<LanguageChange>().lang.ago}";
      } else if (_time < 2592000) {
        //1 month - 2592000 sec
        _value =
            "${_time ~/ 86400} ${(_time ~/ 86400) > 1 ? "${getIt<LanguageChange>().lang.days}" : "${getIt<LanguageChange>().lang.day}"} ${getIt<LanguageChange>().lang.ago}";
      } else if (_time < 31536000) {
        //1year - 31536000 sec
        _value =
            "${_time ~/ 2592000} ${(_time ~/ 2592000) > 1 ? "${getIt<LanguageChange>().lang.months}" : "${getIt<LanguageChange>().lang.month}"} ${getIt<LanguageChange>().lang.ago}";
      } else {
        _value =
            "${_time ~/ 31536000} ${(_time ~/ 31536000) > 1 ? "${getIt<LanguageChange>().lang.years}" : "${getIt<LanguageChange>().lang.year}"} ${getIt<LanguageChange>().lang.ago}";
      }
    } catch (e) {
      _value = "";
    }
    return _value;
  }

  // get date and time as in formats like 23/10/2020 , 23th Oct 2020
  static String showDateTimeInFormat(
    Timestamp postAt, {
    DateTimeFormat format = DateTimeFormat.Date,
    DateFormat date = DateFormat.TextDate,
    TimeFormat time = TimeFormat.LocalTime,
    bool needReverse = false,
  }) {
    String _value = "";
    try {
      DateTime _postAt = postAt.toDate();
      if (format == DateTimeFormat.Date) {
        if (date == DateFormat.NormalDate) {
          _value = !needReverse
              ? "${_makeTwoDigit(_postAt.day)}/${_makeTwoDigit(_postAt.month)}/${_postAt.year}"
              : "${_postAt.year}/${_makeTwoDigit(_postAt.month)}/${_makeTwoDigit(_postAt.day)}";
        } else if (date == DateFormat.TextDate) {
          _value = "${_makeTwoDigit(_postAt.day, needSupText: true)} ${_getMonthText(_postAt.month)} ${_postAt.year}";
        }
      } else if (format == DateTimeFormat.Time) {
        if (time == TimeFormat.LocalTime) {
          _value =
              "${_makeTwoDigit(_postAt.hour > 12 ? (_postAt.hour - 12) : _postAt.hour)}:${_makeTwoDigit(_postAt.minute)} ${_postAt.hour > 12 ? "PM" : "AM"}";
        } else if (time == TimeFormat.StandardTime) {
          _value = "${_makeTwoDigit(_postAt.hour)}:${_makeTwoDigit(_postAt.minute)}:${_makeTwoDigit(_postAt.second)}";
        }
      } else if (format == DateTimeFormat.DateAndTime) {
        _value =
            "${_makeTwoDigit(_postAt.day, needSupText: true)} ${_getMonthText(_postAt.month)} ${_postAt.year} ${_makeTwoDigit(_postAt.hour > 12 ? (_postAt.hour - 12) : _postAt.hour)}:${_makeTwoDigit(_postAt.minute)} ${_postAt.hour > 12 ? "PM" : "AM"}";
      }
    } catch (e) {
      _value = "";
    }
    return _value;
  }

  // make a digit digit as two digit text Ex:- 1 => 01
  // and make text with supertext and related with above function
  static String _makeTwoDigit(int digit, {bool needSupText = false}) {
    String _value = "";
    try {
      _value = digit.toString().length == 1 ? "0$digit" : digit.toString();
      if (needSupText) {
        if (digit == 1) {
          _value = "$_value\u02e2\u1d57"; //1st
        } else if (digit == 2) {
          _value = "$_value\u207f\u1d48"; //2nd
        } else if (digit == 3) {
          _value = "$_value\u02b3\u1d48"; //3rd
        } else {
          _value = "$_value\u1d57\u02b0"; //nth
        }
      }
    } catch (e) {}
    return _value;
  }

  // get month in text format like Jan,Feb,Oct
  static String _getMonthText(int month) {
    String _value = "";
    try {
      switch (month) {
        case 1:
          _value = "Jan";
          break;
        case 2:
          _value = "Feb";
          break;
        case 3:
          _value = "Mar";
          break;
        case 4:
          _value = "Apr";
          break;
        case 5:
          _value = "May";
          break;
        case 6:
          _value = "Jun";
          break;
        case 7:
          _value = "Jul";
          break;
        case 8:
          _value = "Aug";
          break;
        case 9:
          _value = "Sep";
          break;
        case 10:
          _value = "Oct";
          break;
        case 11:
          _value = "Nov";
          break;
        case 12:
          _value = "Dec";
          break;
        default:
          return "";
      }
    } catch (e) {
      _value = "";
    }
    return _value;
  }

  // show bottom sheet
  static Future<bool> showBottomPopup(BuildContext context, Widget widget, {double reduceHeightBy = 0.0}) async {
    bool _value = false;
    _value = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return Container(height: getDeviceHight(context) - reduceHeightBy, child: widget);
        });
    return _value;
  }

  // url lancher
  static Future<bool> urlLaunch({@required String url}) async {
    bool value = await canLaunch(url);
    if (value) {
      launch(url);
    } else {
      print("Could not launch $url");
    }
    return value;
  }

  // flush bar for info like snack bar
  static void showInfoBar(BuildContext context, {@required String msg, String title, Color textColor, Color bgColor}) {
    Flushbar(
      titleText: title != null
          ? BrandTexts.titleBold(text: title, color: textColor ?? BrandColors.light, maxLines: 2)
          : SizedBox.shrink(),
      messageText: BrandTexts.titleBold(text: msg, color: textColor ?? BrandColors.light, maxLines: 2),
      backgroundColor: bgColor ?? BrandColors.shadow,
      flushbarPosition: FlushbarPosition.TOP,
      boxShadows: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      mainButton: InkWell(
        onTap: () => popOnce(context),
        child: Icon(
          Icons.close_rounded,
          color: BrandColors.light,
        ),
      ),
      animationDuration: Duration(milliseconds: 500),
      flushbarStyle: FlushbarStyle.FLOATING,
      duration: Duration(seconds: 10),
    )..show(context);
  }

  // for save value into the sharedPreferences for set dark thenme or not
  static setIsDark({@required bool value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(IS_DARK, value ?? false);
  }

  // for get value from the sharedPreferences for check dark thenme or not
  static Future<bool> getIsDark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool boolValue = prefs.getBool(IS_DARK);
    return boolValue ?? false;
  }

  //for save value into sharedPreferences for set user id
  static setUserId({@required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_ID, value ?? "");
  }

  // for get value from the sharedPreferences for get user id
  static Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(USER_ID);
    return value ?? "";
  }

  //for save value into sharedPreferences for set language code
  static setLangCode({@required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(LANG_CODE, value ?? Lang.English.code);
  }

  // for get value from the sharedPreferences for get language code
  static Future<String> getLangCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(LANG_CODE);
    return value ?? Lang.English.code;
  }

  //for save value into sharedPreferences for set language
  static setLang({@required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(LANG, value ?? json.encode(getIt<LanguageChange>().lang));
  }

  // for get value from the sharedPreferences for get language
  static Future<String> getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(LANG);
    return value ?? json.encode(getIt<LanguageChange>().lang);
  }

  //cache the network images
  static Widget cacheImage(String url, {BoxFit fit = BoxFit.cover}) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      errorWidget: (context, url, error) => Container(
        color: BrandColors.brandColorLight.withOpacity(0.5),
        child: Center(child: svgImage(svg: BROKEN_IMAGE, height: 50.0, width: 50.0)),
      ),
    );
  }

  // connection check
  static Future<bool> checkConnection(BuildContext context) async {
    bool _value = false;
    ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      showInfoBar(
        context,
        msg: "${getIt<LanguageChange>().lang.noNetConnection}",
        bgColor: BrandColors.dangers,
      );
    } else {
      _value = true;
    }
    return _value;
  }

  // launch call and sms
  static void callAndSmsLauncher(BuildContext context, {@required String phoneNumber, bool isCall = true}) {
    String _url = "";

    if (isCall) {
      _url = "tel:$phoneNumber";
    } else {
      /* _url = "sms:$phoneNumber";  */ // for sms
      _url = "whatsapp://send?phone=+94$phoneNumber";
    }
    App.urlLaunch(url: _url).then((value) {
      if (!value) {
        print("Could not launch $_url");
        App.showInfoBar(
          context,
          msg: "${getIt<LanguageChange>().lang.sorryCouldnotOpen}",
          bgColor: BrandColors.dangers,
        );
      }
    });
  }
}

enum DateTimeFormat {
  Date,
  Time,
  DateAndTime,
}

enum DateFormat {
  NormalDate, // 23/10/2020
  TextDate, // 23th Oct 2020
}

enum TimeFormat {
  LocalTime, // 03:24:00 AM or PM
  StandardTime, // 15:24:00
}

// language code enum
enum Lang { English, Tamil, OurTamil }

extension LangEnumExtenstion on Lang {
  String get code {
    switch (this) {
      case Lang.English:
        return "en";
      case Lang.Tamil:
        return "ta";
      case Lang.OurTamil:
        return "our_ta";
      default:
        return "en";
    }
  }
}
