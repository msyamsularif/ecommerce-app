import 'package:ecommerce_app/view_models/auth/auth_cubit.dart';
import 'package:ecommerce_app/view_models/cart/cart_cubit.dart';
import 'package:ecommerce_app/view_models/transaction/transaction_cubit.dart';
import 'package:ecommerce_app/views/checkout_success_page.dart';
import 'package:ecommerce_app/core/utils/colors_style.dart';
import 'package:ecommerce_app/views/widget/checkout_card.dart';
import 'package:ecommerce_app/views/widget/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatefulWidget {
  static const String routName = '/checkout';
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late final CartCubit _cartCubit;
  late final TransactionCubit _transactionCubit;
  late final AuthCubit _authCubit;

  @override
  void initState() {
    _cartCubit = context.read<CartCubit>();
    _transactionCubit = context.read<TransactionCubit>();
    _authCubit = context.read<AuthCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text('Checkout Details'),
        centerTitle: true,
      ),
      body: _content(context),
    );
  }

  Widget _itemPaymentSummary({
    required String title,
    required String value,
    bool ishighlight = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: ishighlight
                ? priceTextStyle.copyWith(fontWeight: semiBold)
                : secondaryTextStyle.copyWith(
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
          ),
          Text(
            value,
            style: ishighlight
                ? priceTextStyle.copyWith(fontWeight: semiBold)
                : primaryTextStyle.copyWith(
                    fontWeight: medium,
                    overflow: TextOverflow.ellipsis,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _content(BuildContext context) {
    return BlocListener<TransactionCubit, TransactionState>(
      listener: (context, state) {
        if (state.transactionStatus == TransactionStatus.loading) {
          LoadingIndicator.show(context: context);
        } else if (state.transactionStatus == TransactionStatus.success) {
          Navigator.pop(context);
          _cartCubit.clearCart();
          Navigator.pushNamedAndRemoveUntil(
            context,
            CheckoutSuccessPage.routName,
            (route) => false,
          );
        } else if (state.transactionStatus == TransactionStatus.failed) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: alertColor,
              duration: const Duration(seconds: 2),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
              ),
              content: Center(
                child: Text(
                  'Failed to Checkout',
                  style: primaryTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          );
        }
      },
      child: ListView(
        padding: EdgeInsets.all(defaultMargin),
        children: [
          // List Items
          Text(
            'List Items',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          const SizedBox(height: 12),
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state.cart.isNotEmpty) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.cart.length,
                  itemBuilder: (context, index) => CheckoutCard(
                    cart: state.cart[index],
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                );
              }

              return Center(
                child: Text(
                  'No Items',
                  style: secondaryTextStyle,
                ),
              );
            },
          ),
          SizedBox(height: defaultMargin),

          // Address Details
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundColor4,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Address Details',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/icon_store_location.png',
                          width: 40,
                          height: 40,
                        ),
                        Image.asset(
                          'assets/icon_line.png',
                          height: 30,
                        ),
                        Image.asset(
                          'assets/icon_your_address.png',
                          width: 40,
                          height: 40,
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Store Location',
                          style: secondaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: light,
                          ),
                        ),
                        Text(
                          'Adidas Core',
                          style: primaryTextStyle.copyWith(
                            fontWeight: medium,
                          ),
                        ),
                        SizedBox(height: defaultMargin),
                        Text(
                          'Your Address',
                          style: secondaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: light,
                          ),
                        ),
                        Text(
                          'Marsemoon',
                          style: primaryTextStyle.copyWith(
                            fontWeight: medium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: defaultMargin),

          // Payment Summary
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundColor4,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Summary',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                _itemPaymentSummary(
                  title: 'Product Quantity',
                  value: '${_cartCubit.totalQuantity} Items',
                ),
                _itemPaymentSummary(
                  title: 'Product Price',
                  value: '\$${_cartCubit.totalPrice}',
                ),
                _itemPaymentSummary(
                  title: 'Shipping',
                  value: 'Free',
                ),
                Divider(
                  color: dividerColor3,
                  thickness: 2,
                ),
                _itemPaymentSummary(
                  title: 'Total',
                  value: '\$${_cartCubit.totalPrice}',
                  ishighlight: true,
                ),
              ],
            ),
          ),

          SizedBox(height: defaultMargin),
          Divider(
            color: dividerColor2,
            thickness: 2,
          ),

          // Button checkout
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: defaultMargin),
            child: ElevatedButton(
              onPressed: () {
                _transactionCubit.checkout(
                  token: _authCubit.state.user!.token!,
                  cart: _cartCubit.state.cart,
                  totalPrice: _cartCubit.totalPrice,
                );
              },
              child: Text(
                'Checkout Now',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
