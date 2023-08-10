import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/services/product_service.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._productService)
      : super(const ProductState(productStatus: ProductStatus.initial));

  final ProductService _productService;

  void getProducts() async {
    try {
      emit(state.copyWith(productStatus: ProductStatus.loading));

      final List<ProductModel> products = await _productService.getProducts();

      emit(
        state.copyWith(
          productStatus: ProductStatus.success,
          products: products,
        ),
      );
    } catch (e) {
      emit(const ProductState(productStatus: ProductStatus.failed));
    }
  }
}
