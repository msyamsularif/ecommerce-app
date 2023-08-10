import 'package:ecommerce_app/view_models/cart/cart_cubit.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_app/core/utils/colors_style.dart';
import 'package:ecommerce_app/models/cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCard extends StatelessWidget {
  final CartModel cart;

  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartCubit cartCubit = context.read<CartCubit>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: backgroundColor4,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(cart.product.galleries.first.url),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cart.product.name,
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '\$${cart.product.price}',
                      style: priceTextStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: IconButton(
                      onPressed: () {
                        cartCubit.addQuantity(id: cart.id);
                      },
                      splashRadius: 15,
                      padding: EdgeInsets.zero,
                      visualDensity: const VisualDensity(
                        horizontal: VisualDensity.minimumDensity,
                        vertical: VisualDensity.minimumDensity,
                      ),
                      icon: Image.asset(
                        'assets/button_add.png',
                        width: 16,
                        height: 16,
                      ),
                    ),
                  ),
                  Text(
                    cart.qty.toString(),
                    style: primaryTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: IconButton(
                      onPressed: () {
                        cartCubit.reduceQuantity(id: cart.id);
                      },
                      splashRadius: 15,
                      padding: EdgeInsets.zero,
                      visualDensity: const VisualDensity(
                        horizontal: VisualDensity.minimumDensity,
                        vertical: VisualDensity.minimumDensity,
                      ),
                      icon: Image.asset(
                        'assets/button_min.png',
                        width: 16,
                        height: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              cartCubit.removeCart(id: cart.id);
            },
            child: Row(
              children: [
                Image.asset(
                  'assets/icon_remove.png',
                  width: 10,
                  height: 12,
                ),
                const SizedBox(width: 4),
                Text(
                  'Remove',
                  style: alertTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: light,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
