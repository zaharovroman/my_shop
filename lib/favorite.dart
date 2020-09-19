import 'dart:convert';

class Favorite {
  final int id;
  Favorite(this.id);

  factory Favorite.fromMap(Map<String, dynamic> json) =>
      new Favorite(json['id']);

  Map<String, dynamic> toMap() => {'id': id};
}

Favorite favoriteFromJson(String str) {
  final jsonData = json.decode(str);
  return Favorite.fromMap(jsonData);
}

String favoriteToJson(Favorite data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}
