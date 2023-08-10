import 'package:flutter/material.dart';

import 'package:ecommerce_app/core/utils/colors_style.dart';
import 'package:ecommerce_app/models/message_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/views/detail_chat_page.dart';

class ChatTile extends StatelessWidget {
  final MessageModel messageModel;

  const ChatTile({
    Key? key,
    required this.messageModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailChatPage(
                  product: UninitializedProductModel(),
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/image_shop_logo.png',
                      ),
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
                        'Shoe Store',
                        style: primaryTextStyle.copyWith(
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        messageModel.message,
                        style: secondaryTextStyle.copyWith(
                          fontWeight: light,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 38),
                Text(
                  'Now',
                  style: secondaryTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Divider(
          thickness: 1,
          color: dividerColor1,
        )
      ],
    );
  }
}
