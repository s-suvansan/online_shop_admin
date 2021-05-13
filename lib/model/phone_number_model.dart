class PhoneNumberModel {
  PhoneNumberModel({
    this.normal,
    this.whatsApp,
  });

  List<String> normal;
  List<String> whatsApp;

  factory PhoneNumberModel.fromJson(Map<String, dynamic> json) => PhoneNumberModel(
        normal: List<String>.from(json["normal"].map((x) => x)),
        whatsApp: List<String>.from(json["whatsApp"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "normal": List<dynamic>.from(normal.map((x) => x)),
        "whatsApp": List<dynamic>.from(whatsApp.map((x) => x)),
      };
}
