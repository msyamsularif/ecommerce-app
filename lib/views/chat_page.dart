import 'package:ecommerce_app/core/utils/colors_style.dart';
import 'package:ecommerce_app/models/message_model.dart';
import 'package:ecommerce_app/services/message_service.dart';
import 'package:ecommerce_app/view_models/auth/auth_cubit.dart';
import 'package:ecommerce_app/view_models/page/page_cubit.dart';
import 'package:ecommerce_app/views/widget/chat_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final AuthCubit _authCubit;
  late final PageCubit _pageCubit;
  final MessageService _messageService = MessageService();

  @override
  void initState() {
    _authCubit = context.read<AuthCubit>();
    _pageCubit = context.read<PageCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _header(),
        _content(),
      ],
    );
  }

  Widget _header() {
    return AppBar(
      title: const Text('Message Support'),
      centerTitle: true,
      automaticallyImplyLeading: false,
    );
  }

  Widget _emptyStateContent() {
    return Expanded(
      child: Container(
        width: double.infinity,
        color: backgroundColor3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon_headset.png',
              width: 80,
              height: 80,
            ),
            const SizedBox(height: 20),
            Text(
              'Opss no message yet?',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'You have never done a transaction',
              style: secondaryTextStyle,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 44,
              child: ElevatedButton(
                onPressed: () {
                  _pageCubit.changeIndexPage(0);
                },
                child: const Text('Explore Store'),
              ),
            ),
          ],
        ),
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
          if (snapshot.data!.isEmpty) {
            return _emptyStateContent();
          }

          return Expanded(
            child: Container(
              width: double.infinity,
              color: backgroundColor3,
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: ListView(
                padding: const EdgeInsets.only(top: 33),
                children: [
                  ChatTile(messageModel: snapshot.data!.last),
                ],
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Expanded(
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(primaryColor),
                strokeWidth: 5,
              ),
            ),
          );
        }

        return _emptyStateContent();
      },
    );
  }
}
