// To parse this JSON data, do
//
//     final modelUser = modelUserFromJson(jsonString);

import 'dart:convert';

ModelUser modelUserFromJson(String str) => ModelUser.fromJson(json.decode(str));

String modelUserToJson(ModelUser data) => json.encode(data.toJson());

class ModelUser {
  ModelUser({
    this.message,
    this.status,
    this.data,
  });

  String message;
  int status;
  List<Datum> data;

  factory ModelUser.fromJson(Map<String, dynamic> json) => ModelUser(
    message: json["message"],
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.idUser,
    this.fullnameUser,
    this.emailUser,
    this.phoneUser,
    this.photoUser,
    this.usernameUser,
    this.passwordUser,
    this.idRole,
  });

  String idUser;
  String fullnameUser;
  String emailUser;
  String phoneUser;
  String photoUser;
  String usernameUser;
  String passwordUser;
  String idRole;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idUser: json["id_user"],
    fullnameUser: json["fullname_user"],
    emailUser: json["email_user"],
    phoneUser: json["phone_user"],
    photoUser: json["photo_user"],
    usernameUser: json["username_user"],
    passwordUser: json["password_user"],
    idRole: json["id_role"],
  );

  Map<String, dynamic> toJson() => {
    "id_user": idUser,
    "fullname_user": fullnameUser,
    "email_user": emailUser,
    "phone_user": phoneUser,
    "photo_user": photoUser,
    "username_user": usernameUser,
    "password_user": passwordUser,
    "id_role": idRole,
  };
}
