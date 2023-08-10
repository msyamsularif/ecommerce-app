import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:equatable/equatable.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(const WishlistState());

  void setWishlist(ProductModel productModel) {
    List<ProductModel> products = [];

    isWishlist(productModel);

    if (!state.isWishlist) {
      products = List.of(state.wishlist)..add(productModel);
      emit(state.copyWith(wishlist: List.from(products), isWishlist: true));
    } else {
      products = List.of(state.wishlist)
        ..removeWhere((element) => element.id == productModel.id);
      emit(state.copyWith(wishlist: List.from(products), isWishlist: false));
    }
  }

  void isWishlist(ProductModel productModel) {
    bool isAdded = state.wishlist.contains(productModel);

    emit(state.copyWith(isWishlist: isAdded));
  }
}
