import 'package:ecommerce_app/core/utils/colors_style.dart';
import 'package:ecommerce_app/view_models/page/page_cubit.dart';
import 'package:ecommerce_app/view_models/wishlist/wishlist_cubit.dart';
import 'package:ecommerce_app/views/widget/wishlist_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late final PageCubit _pageCubit;

  @override
  void initState() {
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
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: const Text('Favorite Shoes'),
    );
  }

  Widget _content() {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        if (state.wishlist.isNotEmpty) {
          return Expanded(
            child: Container(
              color: backgroundColor3,
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.all(defaultMargin),
                itemCount: state.wishlist.length,
                itemBuilder: (context, index) {
                  final product = state.wishlist[index];

                  return WishlistCard(
                    productModel: product,
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
              ),
            ),
          );
        }
        return _emptWishlist();
      },
    );
  }

  Widget _emptWishlist() {
    return Expanded(
      child: Container(
        width: double.infinity,
        color: backgroundColor3,
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image_wishlist.png',
              width: 74,
              height: 62,
            ),
            const SizedBox(height: 23),
            Text(
              'You don\'t have dream shoes?',
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
}
