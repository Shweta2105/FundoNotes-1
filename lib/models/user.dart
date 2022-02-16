import 'dart:convert';
import 'dart:core';

class User {
  String? uid;
  String? username;
  String? email;
  String? photoUrl;

  User({
    this.uid,
    this.username,
    this.email,
    this.photoUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        uid: json['uid'],
        username: json['username'],
        email: json['email'],
        photoUrl: json['photoUrl']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['uid'] = this.uid;
    data['username'] = this.username;
    data['email'] = this.email;
    data['photoUrl'] = this.photoUrl;

    return data;
  }
}
