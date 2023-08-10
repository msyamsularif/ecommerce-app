part of 'transaction_cubit.dart';

class TransactionState extends Equatable {
  final TransactionStatus transactionStatus;
  const TransactionState({this.transactionStatus = TransactionStatus.initial});

  @override
  List<Object> get props => [transactionStatus];

  TransactionState copyWith({
    TransactionStatus? transactionStatus,
  }) {
    return TransactionState(
      transactionStatus: transactionStatus ?? this.transactionStatus,
    );
  }
}

enum TransactionStatus {
  initial,
  loading,
  failed,
  success,
}
