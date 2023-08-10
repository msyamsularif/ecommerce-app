import 'package:ecommerce_app/view_models/page/page_cubit.dart';
import 'package:ecommerce_app/views/cart_page.dart';
import 'package:ecommerce_app/views/chat_page.dart';
import 'package:ecommerce_app/views/home_page.dart';
import 'package:ecommerce_app/views/profile_page.dart';
import 'package:ecommerce_app/views/wishlist_page.dart';
import 'package:ecommerce_app/core/utils/colors_style.dart';
import 'package:ecommerce_app/views/widget/ct_bottom_navigation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  static const String routName = '/home';

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final PageCubit _pageCubit;

  final List<Widget> _widgetOptions = [
    const HomePage(),
    const ChatPage(),
    const WishlistPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    _pageCubit = context.read<PageCubit>();
    _pageCubit.changeIndexPage(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageCubit, PageState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor:
              state.currentIndexPage == 0 ? backgroundColor1 : backgroundColor3,
          body: Center(
            child: _widgetOptions[state.currentIndexPage],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, CartPage.routName),
            backgroundColor: secondaryColor,
            child: Image.asset(
              'assets/icon_cart.png',
              width: 20,
            ),
          ),
          bottomNavigationBar: _customBottomNavigation(),
        );
      },
    );
  }

  Widget _customBottomNavigation() {
    return BlocBuilder<PageCubit, PageState>(
      builder: (context, state) {
        return CTBottomNavigation(
          onTap: (value) {
            _pageCubit.changeIndexPage(value);
          },
          items: [
            CTBottomNavigationItem(
              icon: Image.asset(
                'assets/icon_home.png',
                color: state.currentIndexPage == 0
                    ? primaryColor
                    : secondaryIconColor,
                width: 24,
                height: 24,
              ),
            ),
            CTBottomNavigationItem(
              icon: Image.asset(
                'assets/icon_chat.png',
                color: state.currentIndexPage == 1
                    ? primaryColor
                    : secondaryIconColor,
                width: 24,
                height: 24,
              ),
            ),
            CTBottomNavigationItem(
              icon: Image.asset(
                'assets/icon_wishlist.png',
                color: state.currentIndexPage == 2
                    ? primaryColor
                    : secondaryIconColor,
                width: 24,
                height: 24,
              ),
            ),
            CTBottomNavigationItem(
              icon: Image.asset(
                'assets/icon_profile.png',
                color: state.currentIndexPage == 3
                    ? primaryColor
                    : secondaryIconColor,
                width: 24,
                height: 24,
              ),
            ),
          ],
        );
      },
    );
  }
}
