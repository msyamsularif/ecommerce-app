import 'package:equatable/equatable.dart';

import 'package:ecommerce_app/models/product_model.dart';

class MessageModel extends Equatable {
  final String message;
  final int userId;
  final String username;
  final String userImage;
  final bool isFromUser;
  final ProductModel product;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MessageModel({
    required this.message,
    required this.userId,
    required this.username,
    required this.userImage,
    required this.isFromUser,
    required this.product,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        message,
        userId,
        username,
        userImage,
        isFromUser,
        product,
        createdAt,
        updatedAt
      ];

  MessageModel copyWith({
    String? message,
    int? userId,
    String? username,
    String? userImage,
    bool? isFromUser,
    ProductModel? product,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MessageModel(
      message: message ?? this.message,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      userImage: userImage ?? this.userImage,
      isFromUser: isFromUser ?? this.isFromUser,
      product: product ?? this.product,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'userId': userId,
      'username': username,
      'userImage': userImage,
      'isFromUser': isFromUser,
      'product': product is UninitializedProductModel ? {} : product.toJson(),
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'],
      userId: map['userId'],
      username: map['username'],
      userImage: map['userImage'],
      isFromUser: map['isFromUser'],
      product: map['product'].isEmpty
          ? UninitializedProductModel()
          : ProductModel.fromJson(map['product']),
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }
}
