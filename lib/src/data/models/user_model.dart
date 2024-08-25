// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  dynamic id;
  String name;
  String email;
  String phone;
  String password;
  String address;
  String profileImage;
  String userType;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.address,
    required this.profileImage,
    required this.userType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: (json["_id"]),
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    password: json["password"],
    address: json["address"],
    profileImage: json["profileImage"],
    userType: json["userType"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "password": password,
    "address": address,
    "profileImage": profileImage,
    "userType": userType,
  };
}
