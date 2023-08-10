import 'package:ecommerce_app/models/message_model.dart';
import 'package:ecommerce_app/services/message_service.dart';
import 'package:ecommerce_app/view_models/auth/auth_cubit.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_app/core/utils/colors_style.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/views/widget/chat_bubble.dart';
import 'package:ecommerce_app/views/widget/ct_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailChatPage extends StatefulWidget {
  static const String routName = '/detail-chat-page';

  const DetailChatPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  State<DetailChatPage> createState() => _DetailChatPageState();
}

class _DetailChatPageState extends State<DetailChatPage> {
  late final AuthCubit _authCubit;
  final MessageService _messageService = MessageService();
  final TextEditingController _chatController = TextEditingController(text: '');
  bool _isCloseModalProduct = false;

  @override
  void initState() {
    _authCubit = context.read<AuthCubit>();
    _isCloseModalProduct = widget.product is UninitializedProductModel;
    super.initState();
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: _header(context),
      body: _content(),
      bottomNavigationBar: _inputChat(),
    );
  }

  PreferredSizeWidget _header(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.maybePop(context),
        icon: const Icon(
          Icons.chevron_left,
        ),
      ),
      title: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 50,
                height: 50,
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
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: greenColor,
                    border: Border.all(
                      width: 2,
                      color: backgroundColor1,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shoe Store',
                  style: primaryTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  'Online',
                  style: secondaryTextStyle.copyWith(
                    fontWeight: light,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _content() {
    return StreamBuilder<List<MessageModel>>(
      stream: _messageService.getMessagesByUserId(
        userid: _authCubit.state.user!.id,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final data = snapshot.data![index];

              return ChatBubble(
                isSender: data.isFromUser,
                text: data.message,
                product: data.product,
              );
            },
          );
        }

        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(primaryColor),
            strokeWidth: 5,
          ),
        );
      },
    );
  }

  Widget _productPreview() {
    return Container(
      width: 225,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor5,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(widget.product.galleries.first.url),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: primaryTextStyle.copyWith(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '\$${widget.product.price}',
                        style: priceTextStyle.copyWith(
                          fontWeight: medium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: Colors.transparent,
            child: IconButton(
              onPressed: () {
                setState(() {
                  _isCloseModalProduct = true;
                });
              },
              splashRadius: 15,
              padding: EdgeInsets.zero,
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              icon: Image.asset(
                'assets/button_close.png',
                width: 22,
                height: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputChat() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.product is! UninitializedProductModel &&
              !_isCloseModalProduct)
            _productPreview(),
          Row(
            children: [
              Expanded(
                child: CTTextField(
                  controller: _chatController,
                  hintText: 'Type Message...',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  _messageService.addMessage(
                    user: _authCubit.state.user!,
                    message: _chatController.text,
                    product: widget.product,
                    isFormUser: true,
                  );

                  setState(() {
                    _chatController.clear();
                    _isCloseModalProduct = true;
                  });
                },
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: AssetImage('assets/button_send.png'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
