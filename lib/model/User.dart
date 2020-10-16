// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.error,
    this.academicyear,
    this.startyear,
    this.endyear,
    this.twostepverification,
    this.twostep,
    this.studentstatus,
    this.issignuprequired,
    this.user,
  });

  bool error;
  String academicyear;
  String startyear;
  String endyear;
  bool twostepverification;
  String twostep;
  List<dynamic> studentstatus;
  String issignuprequired;
  List<Map<String, String>> user;

  factory User.fromJson(Map<String, dynamic> json) => User(
    error: json["error"],
    academicyear: json["academicyear"],
    startyear: json["startyear"],
    endyear: json["endyear"],
    twostepverification: json["twostepverification"],
    twostep: json["twostep"],
    studentstatus: List<dynamic>.from(json["studentstatus"].map((x) => x)),
    issignuprequired: json["issignuprequired"],
    user: List<Map<String, String>>.from(json["user"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String>(k, v == null ? null : v)))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "academicyear": academicyear,
    "startyear": startyear,
    "endyear": endyear,
    "twostepverification": twostepverification,
    "twostep": twostep,
    "studentstatus": List<dynamic>.from(studentstatus.map((x) => x)),
    "issignuprequired": issignuprequired,
    "user": List<dynamic>.from(user.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)))),
  };
}
