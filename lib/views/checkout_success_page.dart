import 'package:ecommerce_app/views/main_page.dart';
import 'package:ecommerce_app/core/utils/colors_style.dart';
import 'package:flutter/material.dart';

class CheckoutSuccessPage extends StatelessWidget {
  static const String routName = '/checkout-success';
  const CheckoutSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: AppBar(
        title: const Text('Checkout Success'),
        centerTitle: true,
      ),
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
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
            'You made a transaction',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Stay at home while we\nprepare your dream shoes',
            style: secondaryTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: defaultMargin),
          SizedBox(
            width: 195,
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                MainPage.routName,
                (route) => false,
              ),
              style: const ButtonStyle(
                padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                ),
              ),
              child: Text(
                'Order Other Shoes',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: 196,
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                ),
                backgroundColor: MaterialStatePropertyAll(backgroundColor8),
              ),
              child: Text(
                'View My Order',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                  color: greyTextColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
