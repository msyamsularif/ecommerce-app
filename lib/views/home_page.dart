import 'package:ecommerce_app/core/utils/colors_style.dart';
import 'package:ecommerce_app/models/user_model.dart';
import 'package:ecommerce_app/view_models/auth/auth_cubit.dart';
import 'package:ecommerce_app/view_models/product/product_cubit.dart';
import 'package:ecommerce_app/views/widget/product_card.dart';
import 'package:ecommerce_app/views/widget/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AuthCubit _authCubit;
  late final UserModel? _userModel;

  @override
  void initState() {
    _authCubit = context.read<AuthCubit>();

    _userModel = _authCubit.state.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.all(defaultMargin),
        children: [
          _header(),
          _categori(),
          _popularProduct(),
          _newArrivals(),
        ],
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hallo, ${_userModel?.name ?? 'No Name'}',
                style: primaryTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: semiBold,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 2,
              ),
              Text(
                '@${_userModel?.username ?? '-'}',
                style: subtitleTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: regular,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: _userModel?.profilePhotoUrl == null
                  ? const AssetImage('assets/image_profile.png')
                  : NetworkImage(_userModel!.profilePhotoUrl!) as ImageProvider,
            ),
          ),
        )
      ],
    );
  }

  Widget _categori() {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: defaultMargin),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              color: index != 0 ? null : primaryColor,
              borderRadius: BorderRadius.circular(12),
              border: index != 0 ? Border.all(color: borderColor) : null,
            ),
            child: Text(
              'All Shoes',
              style: index != 0
                  ? subtitleTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: medium,
                    )
                  : primaryTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: medium,
                    ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 16),
      ),
    );
  }

  Widget _popularProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Popular Products',
          style: primaryTextStyle.copyWith(
            fontSize: 22,
            fontWeight: semiBold,
          ),
        ),
        BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state.productStatus == ProductStatus.success &&
                    state.products != null ||
                state.products!.isNotEmpty) {
              return SizedBox(
                height: 278,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 14),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.products!.length,
                  itemBuilder: (context, index) {
                    final product = state.products![index];

                    return ProductCard(
                      productModel: product,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(width: defaultMargin),
                ),
              );
            }

            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(primaryColor),
                strokeWidth: 5,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _newArrivals() {
    return Padding(
      padding: EdgeInsets.only(top: defaultMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'New Arrivals',
            style: primaryTextStyle.copyWith(
              fontSize: 22,
              fontWeight: semiBold,
            ),
          ),
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state.productStatus == ProductStatus.success &&
                      state.products != null ||
                  state.products!.isNotEmpty) {
                return ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 14),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.products!.length,
                  itemBuilder: (context, index) {
                    final product = state.products![index];

                    return ProductTile(
                      productModel: product,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(height: defaultMargin),
                );
              }

              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(primaryColor),
                  strokeWidth: 5,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
