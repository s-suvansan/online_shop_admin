class LanguageModel {
  LanguageModel({
    //base layout view
    this.home = "Home",
    this.favorites = "Favorites",
    this.settings = "Settings",
    // home and favourite view
    this.min = "min",
    this.mins = "mins",
    this.hr = "hr",
    this.hrs = "hrs",
    this.day = "day",
    this.days = "days",
    this.month = "month",
    this.months = "months",
    this.year = "year",
    this.years = "years",
    this.ago = "ago",
    this.rs = "Rs",
    this.justNow = "Just now",
    // product info view
    this.productInfo = "Product Info",
    this.postedAt = "Posted at {}",
    this.postedBy = "Posted by {}",
    this.negotiable = "Negotiable",
    this.desc = "Description",
    this.showMore = "Show more",
    this.showLess = "Show less",
    this.call = "Call",
    this.whatsapp = "WhatsApp",
    this.sorryCouldnotOpen = "Sorry, could not open.",
    this.emptyProductList = "Empty products.",
    this.emptyFavList = "Empty favorite products.",
    //splash view
    this.noNetConnection = "No Internet Connection.",
    this.retry = "Retry",
    //setting view
    this.changeTheme = "Change Theme",
    this.selectLang = "Select Language",
    this.contactUs = "Contact Us",
    this.contactUsDesc = "Sell your products with this app and contact us for more information.",
    //common
    this.selectNumber = "Select a number",
  });
  //base layout view
  String home;
  String favorites;
  String settings;
  // home and favourite view
  String min;
  String mins;
  String hr;
  String hrs;
  String day;
  String days;
  String months;
  String month;
  String year;
  String years;
  String ago;
  String rs;
  String justNow;
  String emptyProductList;
  String emptyFavList;
  // product info view
  String productInfo;
  String postedAt;
  String postedBy;
  String negotiable;
  String desc;
  String showMore;
  String showLess;
  String call;
  String whatsapp;
  String sorryCouldnotOpen;

  //splash view
  String noNetConnection;
  String retry;
  //setting view
  String changeTheme;
  String selectLang;
  String contactUs;
  String contactUsDesc;
  //common
  String selectNumber;

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        //base layout view
        home: json["home"] ?? "Home",
        favorites: json["favorites"] ?? "Favorites",
        settings: json["settings"] ?? "Settings",
        // home and favourite view
        min: json["min"] ?? "min",
        mins: json["mins"] ?? "mins",
        hr: json["hr"] ?? "hr",
        hrs: json["hrs"] ?? "hrs",
        day: json["day"] ?? "day",
        days: json["days"] ?? "days",
        month: json["month"] ?? "month",
        months: json["months"] ?? "months",
        year: json["year"] ?? "year",
        years: json["years"] ?? "years",
        ago: json["ago"] ?? "ago",
        rs: json["rs"] ?? "Rs",
        justNow: json["justNow"] ?? "Just now",
        emptyProductList: json["emptyProductList"] ?? "Empty products.",
        emptyFavList: json["emptyFavList"] ?? "Empty favorite products.",
        // product info view
        productInfo: json["productInfo"] ?? "Product Info",
        postedAt: json["postedAt"] ?? "Posted at {}",
        postedBy: json["postedBy"] ?? "Posted by {}",
        negotiable: json["negotiable"] ?? "Negotiable",
        desc: json["desc"] ?? "Description",
        showMore: json["showMore"] ?? "Show more",
        showLess: json["showLess"] ?? "Show less",
        call: json["call"] ?? "Call",
        whatsapp: json["whatsapp"] ?? "WhatsApp",
        sorryCouldnotOpen: json["sorryCouldnotOpen"] ?? "Sorry, could not open.",
        //splash view
        noNetConnection: json["noNetConnection"] ?? "No Internet Connection.",
        retry: json["retry"] ?? "Retry",
        //setting view
        changeTheme: json["changeTheme"] ?? "Change Theme",
        selectLang: json["selectLang"] ?? "Select Language",
        contactUs: json["contactUs"] ?? "Contact Us",
        contactUsDesc: json["contactUsDesc"] ?? "Sell your products with this app and contact us for more information.",
        //common
        selectNumber: json["selectNumber"] ?? "Select a number",
      );

  Map<String, dynamic> toJson() => {
        "home": home,
        "favorites": favorites,
        "settings": settings,
        "min": min,
        "mins": mins,
        "hr": hr,
        "hrs": hrs,
        "day": day,
        "days": days,
        "month": month,
        "months": months,
        "year": year,
        "years": years,
        "ago": ago,
        "rs": rs,
        "justNow": justNow,
        "emptyProductList": emptyProductList,
        "emptyFavList": emptyFavList,
        "productInfo": productInfo,
        "postedAt": postedAt,
        "postedBy": postedBy,
        "negotiable": negotiable,
        "desc": desc,
        "showMore": showMore,
        "showLess": showLess,
        "call": call,
        "whatsapp": whatsapp,
        "sorryCouldnotOpen": sorryCouldnotOpen,
        "noNetConnection": noNetConnection,
        "retry": retry,
        "changeTheme": changeTheme,
        "selectLang": selectLang,
        "contactUs": contactUs,
        "selectNumber": selectNumber,
      };
}
