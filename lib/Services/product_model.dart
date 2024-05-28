// ignore_for_file: prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers

class ProductModel {
  int? id;
  String? title;
  var price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  ProductModel(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image,
      this.rating});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    price = json["price"];
    description = json["description"];
    category = json["category"];
    image = json["image"];
    rating = json["rating"] == null ? null : Rating.fromJson(json["rating"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["title"] = title;
    _data["price"] = price;
    _data["description"] = description;
    _data["category"] = category;
    _data["image"] = image;
    if (rating != null) {
      _data["rating"] = rating?.toJson();
    }
    return _data;
  }
}

class Rating {
  var rate;
  int? count;

  Rating({this.rate, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    rate = json["rate"];
    count = json["count"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["rate"] = rate;
    _data["count"] = count;
    return _data;
  }
}
