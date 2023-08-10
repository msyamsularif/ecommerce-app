import 'package:ecommerce_app/models/user_model.dart';
import 'package:ecommerce_app/view_models/auth/auth_cubit.dart';
import 'package:ecommerce_app/views/edit_profile_page.dart';
import 'package:ecommerce_app/views/sign_in_page.dart';
import 'package:ecommerce_app/core/utils/colors_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final AuthCubit _authCubit;
  late UserModel? _userModel;

  @override
  void initState() {
    _authCubit = context.read<AuthCubit>();
    _userModel = _authCubit.state.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _header(context),
        _content(context),
      ],
    );
  }

  Widget _header(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(defaultMargin),
          child: Row(
            children: [
              ClipOval(
                child: _userModel?.profilePhotoUrl == null
                    ? Image.asset(
                        'assets/image_profile.png',
                        width: 64,
                        height: 64,
                      )
                    : Image.network(
                        _userModel!.profilePhotoUrl!,
                        width: 64,
                        height: 64,
                      ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hallo, ${_userModel?.name ?? 'No Name'}',
                      style: primaryTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      '@${_userModel?.username ?? '-'}',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, SignInPage.routName, (route) => false),
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                splashRadius: 25,
                icon: Image.asset(
                  'assets/button_exit.png',
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuItem(String text, {VoidCallback? onTap}) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: SizedBox(
          height: 40,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: secondaryTextStyle.copyWith(
                    fontSize: 13,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: secondaryTextColor,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        color: backgroundColor3,
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            _menuItem(
              'Edit Profile',
              onTap: () =>
                  Navigator.pushNamed(context, EditProfilePage.routName),
            ),
            _menuItem('Your Orders'),
            _menuItem('Help'),
            const SizedBox(height: 30),
            Text(
              'General',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            _menuItem('Privacy & Policy'),
            _menuItem('Term of Service'),
            _menuItem('Rate App'),
          ],
        ),
      ),
    );
  }
}
