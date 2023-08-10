part of 'product_cubit.dart';

class ProductState extends Equatable {
  final List<ProductModel>? products;
  final ProductStatus productStatus;

  const ProductState({
    this.products,
    this.productStatus = ProductStatus.initial,
  });

  @override
  List<Object?> get props => [products, productStatus];

  ProductState copyWith({
    List<ProductModel>? products,
    ProductStatus? productStatus,
  }) {
    return ProductState(
      products: products ?? this.products,
      productStatus: productStatus ?? this.productStatus,
    );
  }
}

enum ProductStatus {
  initial,
  loading,
  failed,
  success,
}
