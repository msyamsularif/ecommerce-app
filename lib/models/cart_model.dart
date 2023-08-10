import 'package:equatable/equatable.dart';

import 'package:ecommerce_app/models/product_model.dart';

class CartModel extends Equatable {
  final int id;
  final ProductModel product;
  final int qty;

  const CartModel({
    required this.id,
    required this.product,
    required this.qty,
  });

  @override
  List<Object?> get props => [id, product, qty];

  CartModel copyWith({
    int? id,
    ProductModel? product,
    int? qty,
  }) {
    return CartModel(
      id: id ?? this.id,
      product: product ?? this.product,
      qty: qty ?? this.qty,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.toJson(),
      'quantity': qty,
    };
  }

  factory CartModel.fromJson(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'],
      product: ProductModel.fromJson(map['product']),
      qty: map['quantity'],
    );
  }

  double get totalPrice {
    return product.price * qty;
  }
}
