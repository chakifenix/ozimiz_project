// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  String message;
  String token;
  Data data;

  UserInfo({
    required this.message,
    required this.token,
    required this.data,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        message: json["message"],
        token: json["token"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "data": data.toJson(),
      };
}

class Data {
  int id;
  String fullName;
  String phoneNumber;
  DateTime createdAt;
  DateTime updatedAt;
  int isAdmin;

  Data({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.isAdmin,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        fullName: json["full_name"],
        phoneNumber: json["phone_number"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isAdmin: json["is_admin"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "phone_number": phoneNumber,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "is_admin": isAdmin,
      };
}
