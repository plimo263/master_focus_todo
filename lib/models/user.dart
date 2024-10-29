import 'dart:convert';

class User {
  String? id;
  String? name;

  static User internal = User._internal();

  User._internal();

  factory User() {
    return internal;
  }

  factory User.login(String id, String name) {
    internal.id = id;
    internal.name = name;
    return internal;
  }

  factory User.fromMap(Map<String, dynamic> json) {
    internal.id = json['id'];
    internal.name = json['name'];
    return internal;
  }

  factory User.fromJson(String json) {
    final map = jsonDecode(json);
    return User.fromMap(map);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
