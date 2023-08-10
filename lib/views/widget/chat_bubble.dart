import 'package:flutter/material.dart';

import 'package:ecommerce_app/core/utils/colors_style.dart';
import 'package:ecommerce_app/models/product_model.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSender;
  final ProductModel product;

  const ChatBubble({
    Key? key,
    required this.text,
    this.isSender = false,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: defaultMargin),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (product is! UninitializedProductModel) _productPreview(),
          Row(
            mainAxisAlignment:
                isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6,
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: isSender ? backgroundColor5 : backgroundColor4,
                    borderRadius: BorderRadius.only(
                      topLeft:
                          isSender ? const Radius.circular(12) : Radius.zero,
                      topRight:
                          isSender ? Radius.zero : const Radius.circular(12),
                      bottomLeft: const Radius.circular(12),
                      bottomRight: const Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    text,
                    style: primaryTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _productPreview() {
    return Container(
      width: 230,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSender ? backgroundColor5 : backgroundColor4,
        borderRadius: BorderRadius.only(
          topLeft: isSender ? const Radius.circular(12) : Radius.zero,
          topRight: isSender ? Radius.zero : const Radius.circular(12),
          bottomLeft: const Radius.circular(12),
          bottomRight: const Radius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(product.galleries.first.url),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      style: primaryTextStyle.copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${product.price}',
                      style: priceTextStyle.copyWith(
                        fontWeight: medium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              OutlinedButton(
                onPressed: () {},
                style: ButtonStyle(
                  padding: const MaterialStatePropertyAll(
                    EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                  ),
                  fixedSize: const MaterialStatePropertyAll(
                    Size(double.infinity, 40),
                  ),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                child: Text(
                  'Add to Cart',
                  style: purpleTextStyle,
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  padding: const MaterialStatePropertyAll(
                    EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                  ),
                  fixedSize: const MaterialStatePropertyAll(
                    Size(double.infinity, 40),
                  ),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                child: Text(
                  'Buy Now',
                  style: purpleTextStyle.copyWith(
                    color: backgroundColor5,
                    fontWeight: medium,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
