import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final String username;
  final String? profilePhotoUrl;
  final String? token;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    this.profilePhotoUrl,
    this.token,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        username,
        profilePhotoUrl,
        token,
      ];

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? username,
    String? profilePhotoUrl,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      username: username ?? this.username,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      token: token ?? this.token,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json, String token) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
      profilePhotoUrl: json['profile_photo_url'],
      token: token,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'profile_photo_url': profilePhotoUrl,
    };
  }
}
