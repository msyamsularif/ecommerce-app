import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/models/cart_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:equatable/equatable.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  final List<CartModel> _cartProduct = [];

  void addCart({required ProductModel product}) {
    productExist(product: product);

    emit(state.copyWith(cartStatus: CartStatus.loading));

    if (!state.isExist) {
      int index = _cartProduct
          .indexWhere((element) => element.product.id == product.id);

      int quantity = _cartProduct[index].qty + 1;

      _cartProduct[index] = CartModel(
        id: _cartProduct[index].id,
        product: _cartProduct[index].product,
        qty: quantity,
      );
    } else {
      _cartProduct.add(
        CartModel(
          id: DateTime.now().microsecondsSinceEpoch,
          product: product,
          qty: 1,
        ),
      );
    }

    emit(state.copyWith(
      cart: List.from(_cartProduct),
      cartStatus: CartStatus.success,
    ));
  }

  void removeCart({required int id}) {
    _cartProduct.removeWhere((element) => element.id == id);

    emit(state.copyWith(
      cart: List.from(_cartProduct),
      cartStatus: CartStatus.success,
    ));
  }

  void addQuantity({required int id}) {
    int index = _cartProduct.indexWhere((element) => element.id == id);

    int quantity = _cartProduct[index].qty + 1;

    _cartProduct[index] = CartModel(
      id: _cartProduct[index].id,
      product: _cartProduct[index].product,
      qty: quantity,
    );

    emit(state.copyWith(
      cart: List.from(_cartProduct),
      cartStatus: CartStatus.success,
    ));
  }

  void reduceQuantity({required int id}) {
    int index = _cartProduct.indexWhere((element) => element.id == id);

    int quantity = _cartProduct[index].qty - 1;

    _cartProduct[index] = CartModel(
      id: _cartProduct[index].id,
      product: _cartProduct[index].product,
      qty: quantity,
    );

    if (_cartProduct[index].qty == 0) {
      _cartProduct.removeAt(index);
    }

    emit(state.copyWith(
      cart: List.from(_cartProduct),
      cartStatus: CartStatus.success,
    ));
  }

  void productExist({required ProductModel product}) {
    bool isExist =
        (state.cart.indexWhere((element) => element.product.id == product.id) ==
            -1);

    emit(state.copyWith(isExist: isExist));
  }

  void clearCart() {
    _cartProduct.clear();
    emit(const CartState(
      cart: [],
      cartStatus: CartStatus.initial,
      isExist: false,
    ));
  }

  double get totalPrice {
    double total = 0;
    for (var cartItem in _cartProduct) {
      total += cartItem.totalPrice;
    }
    return total;
  }

  int get totalQuantity {
    int total = 0;
    for (var cartItem in _cartProduct) {
      total += cartItem.qty;
    }
    return total;
  }
}
