part of 'wishlist_cubit.dart';

class WishlistState extends Equatable {
  final List<ProductModel> wishlist;
  final bool isWishlist;

  const WishlistState({
    this.wishlist = const [],
    this.isWishlist = false,
  });

  @override
  List<Object?> get props => [wishlist, isWishlist];

  WishlistState copyWith({
    List<ProductModel>? wishlist,
    bool? isWishlist,
  }) {
    return WishlistState(
      wishlist: wishlist ?? this.wishlist,
      isWishlist: isWishlist ?? this.isWishlist,
    );
  }
}
