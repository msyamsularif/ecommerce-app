part of 'cart_cubit.dart';

class CartState extends Equatable {
  final List<CartModel> cart;
  final CartStatus cartStatus;
  final bool isExist;

  const CartState({
    this.cart = const [],
    this.cartStatus = CartStatus.initial,
    this.isExist = false,
  });

  @override
  List<Object> get props => [cart, cartStatus, isExist];

  CartState copyWith({
    List<CartModel>? cart,
    CartStatus? cartStatus,
    bool? isExist,
  }) {
    return CartState(
      cart: cart ?? this.cart,
      cartStatus: cartStatus ?? this.cartStatus,
      isExist: isExist ?? this.isExist,
    );
  }
}

enum CartStatus {
  initial,
  loading,
  failed,
  success,
}
