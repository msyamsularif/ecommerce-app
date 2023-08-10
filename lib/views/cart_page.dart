import 'package:ecommerce_app/view_models/cart/cart_cubit.dart';
import 'package:ecommerce_app/views/checkout_page.dart';
import 'package:ecommerce_app/views/main_page.dart';
import 'package:ecommerce_app/core/utils/colors_style.dart';
import 'package:ecommerce_app/views/widget/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  static const String routName = '/cart';
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late final CartCubit _cartCubit;

  @override
  void initState() {
    _cartCubit = context.read<CartCubit>();
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
        title: const Text('Your Cart'),
        centerTitle: true,
      ),
      body: _content(),
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.cart.isNotEmpty) {
            return _customBottomNav(context);
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _emptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icon_empty_cart.png',
            width: 80,
            height: 80,
          ),
          const SizedBox(height: 20),
          Text(
            'Opss! Your Cart is Empty',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Let\'s find your favorite shoes',
            style: secondaryTextStyle,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              MainPage.routName,
              (route) => false,
            ),
            child: Text(
              'Explore Store',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _content() {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state.cart.isNotEmpty) {
          return ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(defaultMargin),
            itemCount: state.cart.length,
            itemBuilder: (context, index) => CartCard(
              cart: state.cart[index],
            ),
          );
        }

        return _emptyCart();
      },
    );
  }

  Widget _customBottomNav(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 30,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Detail Price
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal',
                  style: primaryTextStyle,
                ),
                Text(
                  '\$${_cartCubit.totalPrice}',
                  style: priceTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: defaultMargin),
            child: Divider(
              color: dividerColor2,
              thickness: 2,
            ),
          ),

          // Button Checkout
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, CheckoutPage.routName),
              style: const ButtonStyle(
                padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(
                    vertical: 13,
                    horizontal: 20,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Continue to Checkout',
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  const Icon(Icons.arrow_forward_outlined)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
