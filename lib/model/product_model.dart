import '../main_index.dart';

class ProductModel {
  ProductModel({
    this.id,
    this.title,
    this.desc,
    this.price,
    this.imageUrl,
    this.postAt,
    this.postBy,
    this.postFrom,
    this.keywords,
    this.isNegotiable,
  });

  String id;
  String title;
  String desc;
  String price;
  List<String> imageUrl;
  Timestamp postAt;
  String postBy;
  String postFrom;
  List<String> keywords;
  bool isNegotiable;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"] ?? "",
        title: json["title"] ?? "",
        desc: json["desc"] ?? "",
        price: json["price"] ?? "",
        imageUrl: json["imageUrl"] != null ? List<String>.from(json["imageUrl"].map((x) => x)) : [],
        postAt: json["postAt"] ?? Timestamp.now(),
        postBy: json["postBy"] ?? "",
        postFrom: json["postFrom"] ?? "",
        keywords: json["keywords"] != null ? List<String>.from(json["keywords"].map((x) => x)) : [],
        isNegotiable: json["isNegotiable"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "desc": desc,
        "price": price,
        "imageUrl": List<String>.from(imageUrl.map((x) => x)),
        "postAt": FieldValue.serverTimestamp(),
        "postBy": postBy,
        "postFrom": postFrom,
        "keywords": List<String>.from(keywords.map((x) => x)),
        "isNegotiable": isNegotiable,
      };
}
