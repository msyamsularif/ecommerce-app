import 'package:flutter/material.dart';

import 'package:ecommerce_app/core/utils/colors_style.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/views/product_page.dart';

class ProductCard extends StatelessWidget {
  final ProductModel productModel;

  const ProductCard({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductPage(productModel: productModel),
        ),
      ),
      child: Container(
        width: 215,
        height: 278,
        padding: EdgeInsets.only(
          top: defaultMargin,
          bottom: 20,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFECEDEF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              productModel.galleries.first.url,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    productModel.category.name,
                    style: secondaryTextStyle.copyWith(
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    productModel.name,
                    style: blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$${productModel.price}',
                    style: priceTextStyle.copyWith(
                      fontWeight: medium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
