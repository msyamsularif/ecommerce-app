import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/message_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/models/user_model.dart';
import 'package:flutter/material.dart';

class MessageService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<MessageModel>> getMessagesByUserId({required int userid}) {
    try {
      return firestore
          .collection('messages')
          .where('userId', isEqualTo: userid)
          .snapshots()
          .map((QuerySnapshot list) {
        final result = list.docs.map<MessageModel>((DocumentSnapshot message) {
          debugPrint(message.data().toString());
          return MessageModel.fromJson(message.data() as Map<String, dynamic>);
        }).toList();

        result.sort(
          (a, b) => a.createdAt.compareTo(b.createdAt),
        );

        return result;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addMessage({
    required UserModel user,
    bool isFormUser = true,
    required String message,
    required ProductModel product,
  }) async {
    try {
      firestore.collection('messages').add({
        'userId': user.id,
        'username': user.name,
        'userImage': user.profilePhotoUrl,
        'isFromUser': isFormUser,
        'message': message,
        'product': product is UninitializedProductModel ? {} : product.toJson(),
        'created_at': DateTime.now().toString(),
        'updated_at': DateTime.now().toString(),
      }).then((value) => print('Message Successfully Sent'));
    } catch (e) {
      throw Exception('Message Failed to Send');
    }
  }
}
