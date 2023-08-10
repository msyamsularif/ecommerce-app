import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ecommerce_app/models/cart_model.dart';
import 'package:ecommerce_app/services/transaction_service.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit(
    this._transactionService,
  ) : super(const TransactionState());

  final TransactionService _transactionService;

  void checkout({
    required String token,
    required List<CartModel> cart,
    required double totalPrice,
  }) async {
    try {
      emit(state.copyWith(transactionStatus: TransactionStatus.loading));

      final responseResult = await _transactionService.checkout(
        token: token,
        cart: cart,
        totalPrice: totalPrice,
      );

      if (responseResult) {
        emit(state.copyWith(transactionStatus: TransactionStatus.success));
      } else {
        emit(state.copyWith(transactionStatus: TransactionStatus.failed));
      }
    } catch (e) {
      emit(state.copyWith(transactionStatus: TransactionStatus.failed));
    }
  }
}
