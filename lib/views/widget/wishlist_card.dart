import 'package:ecommerce_app/view_models/wishlist/wishlist_cubit.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_app/core/utils/colors_style.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCard extends StatelessWidget {
  final ProductModel productModel;

  const WishlistCard({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 14,
      ),
      decoration: BoxDecoration(
        color: backgroundColor4,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(productModel.galleries.first.url),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productModel.name,
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '\$${productModel.price}',
                  style: priceTextStyle.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
          Material(
            color: secondaryColor,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: IconButton(
              onPressed: () {
                context.read<WishlistCubit>().setWishlist(productModel);
              },
              visualDensity: const VisualDensity(
                vertical: VisualDensity.minimumDensity,
                horizontal: VisualDensity.minimumDensity,
              ),
              splashRadius: 22,
              iconSize: 16,
              icon: Icon(
                Icons.favorite,
                color: whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
