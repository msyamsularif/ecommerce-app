import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/view_models/cart/cart_cubit.dart';
import 'package:ecommerce_app/view_models/wishlist/wishlist_cubit.dart';
import 'package:ecommerce_app/views/cart_page.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_app/core/utils/colors_style.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/views/detail_chat_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPage extends StatefulWidget {
  static const String routName = '/product';

  const ProductPage({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final ProductModel productModel;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late final WishlistCubit _wishlistCubit;
  late final CartCubit _cartCubit;
  int _currentIndex = 0;

  final List<String> _imagesFamiliarShoes = [
    'assets/image_shoes.png',
    'assets/image_shoes2.png',
    'assets/image_shoes3.png',
    'assets/image_shoes4.png',
    'assets/image_shoes5.png',
    'assets/image_shoes6.png',
    'assets/image_shoes7.png',
    'assets/image_shoes8.png',
  ];

  @override
  void initState() {
    _wishlistCubit = context.read<WishlistCubit>();
    _cartCubit = context.read<CartCubit>();

    _wishlistCubit.isWishlist(widget.productModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor6,
      body: ListView(
        children: [
          _header(),
          _content(),
        ],
      ),
    );
  }

  Future<void> _showSuccessDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.all(defaultMargin),
            constraints: BoxConstraints.loose(
              Size.fromWidth(
                MediaQuery.of(context).size.width - 2 * defaultMargin,
              ),
            ),
            decoration: BoxDecoration(
              color: backgroundColor3,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Material(
              color: Colors.transparent,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        splashRadius: 22,
                        padding: EdgeInsets.zero,
                        onPressed: () => Navigator.maybePop(context),
                        icon: Icon(
                          Icons.close,
                          color: whiteColor,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/icon_success.png',
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Hurray :)',
                          style: primaryTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: semiBold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Item added successfully',
                          style: secondaryTextStyle,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, CartPage.routName);
                          },
                          child: Text(
                            'View My Cart',
                            style: primaryTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: medium,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _indicatorCarousel(int index) {
    return Container(
      width: _currentIndex == index ? 16 : 4,
      height: 4,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: _currentIndex == index
            ? primaryColor
            : secondaryIconColor.withOpacity(0.5),
      ),
    );
  }

  Widget _header() {
    int index = -1;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: defaultMargin,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                splashRadius: 20,
                onPressed: () => Navigator.maybePop(context),
                icon: const Icon(Icons.chevron_left),
              ),
              Icon(
                Icons.shopping_bag,
                color: backgroundColor1,
              ),
            ],
          ),
        ),
        CarouselSlider(
          items: widget.productModel.galleries
              .map((e) => Image.network(
                    e.url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 310,
                  ))
              .toList(),
          options: CarouselOptions(
            initialPage: 0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.productModel.galleries.map((e) {
            index++;
            return _indicatorCarousel(index);
          }).toList(),
        )
      ],
    );
  }

  Widget _content() {
    return Container(
      margin: const EdgeInsets.only(top: 17),
      padding: const EdgeInsets.all(30),
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor1,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.productModel.name,
                      style: primaryTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: semiBold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      widget.productModel.category.name,
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              BlocConsumer<WishlistCubit, WishlistState>(
                buildWhen: (previous, current) =>
                    previous.isWishlist != current.isWishlist,
                listenWhen: (previous, current) =>
                    previous.isWishlist != current.isWishlist,
                listener: (context, state) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor:
                          state.isWishlist ? secondaryColor : alertColor,
                      duration: const Duration(seconds: 2),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(8),
                        ),
                      ),
                      content: Center(
                        child: Text(
                          state.isWishlist
                              ? 'Has been added to the Wishlist'
                              : 'Has been removed from the Wishlist',
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                builder: (context, state) {
                  return Material(
                    color: state.isWishlist ? secondaryColor : backgroundColor7,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: IconButton(
                      onPressed: () {
                        _wishlistCubit.setWishlist(widget.productModel);
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: state.isWishlist ? whiteColor : backgroundColor1,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),

          // price
          Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor2,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price starts from',
                  style: primaryTextStyle,
                ),
                Text(
                  '\$${widget.productModel.price}',
                  style: priceTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
              ],
            ),
          ),

          // description
          SizedBox(height: defaultMargin),
          Text(
            'Description',
            style: primaryTextStyle.copyWith(
              fontWeight: medium,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.productModel.description,
            style: subtitleTextStyle.copyWith(
              fontWeight: light,
            ),
            textAlign: TextAlign.justify,
          ),

          // familiar shoes
          SizedBox(height: defaultMargin),
          Text(
            'Fimiliar Shoes',
            style: primaryTextStyle.copyWith(
              fontWeight: medium,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 54,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: _imagesFamiliarShoes.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: whiteColor,
                    image: DecorationImage(
                      image: AssetImage(
                        _imagesFamiliarShoes[index],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 16),
            ),
          ),

          // button
          SizedBox(height: defaultMargin),
          Row(
            children: [
              OutlinedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailChatPage(
                      product: widget.productModel,
                    ),
                  ),
                ),
                style: const ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(
                    Size(54, 54),
                  ),
                  visualDensity: VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                  ),
                ),
                child: Image.asset(
                  'assets/icon_chat.png',
                  color: primaryColor,
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _cartCubit.addCart(product: widget.productModel);
                    _showSuccessDialog();
                  },
                  child: Text(
                    'Add to Cart',
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
