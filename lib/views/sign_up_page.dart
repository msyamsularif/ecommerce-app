import 'package:ecommerce_app/view_models/auth/auth_cubit.dart';
import 'package:ecommerce_app/views/main_page.dart';
import 'package:ecommerce_app/views/sign_in_page.dart';
import 'package:ecommerce_app/views/widget/ct_text_field.dart';
import 'package:ecommerce_app/core/utils/colors_style.dart';
import 'package:ecommerce_app/views/widget/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  static const String routName = '/sign-up';

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final AuthCubit _authCubit;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _authCubit = context.read<AuthCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.register) {
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
            context,
            MainPage.routName,
            (route) => false,
          );
        } else if (state.authStatus == AuthStatus.loading) {
          LoadingIndicator.show(context: context);
        } else if (state.authStatus == AuthStatus.failed) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: alertColor,
              duration: const Duration(seconds: 2),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
              ),
              content: Text(
                'Failed to Register!',
                style: primaryTextStyle.copyWith(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.all(defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(),
                const SizedBox(height: 50),
                _formBody(),
                const SizedBox(height: 50),
                _footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sign Up',
          style: primaryTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'Register and Happy Shoping',
          style: subtitleTextStyle,
        ),
      ],
    );
  }

  Widget _formBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CTTextField(
          controller: _fullNameController,
          title: 'Full Name',
          hintText: 'Your Full Name',
          prefixIcon: Image.asset('assets/icon_name.png'),
        ),
        const SizedBox(height: 20),
        CTTextField(
          controller: _usernameController,
          title: 'Username',
          hintText: 'Your Username',
          prefixIcon: Image.asset('assets/icon_username.png'),
        ),
        const SizedBox(height: 20),
        CTTextField(
          controller: _emailController,
          title: 'Email Address',
          hintText: 'Your Email Address',
          prefixIcon: Image.asset('assets/icon_email.png'),
        ),
        const SizedBox(height: 20),
        CTTextField(
          controller: _passwordController,
          title: 'Password',
          hintText: 'Your Password',
          prefixIcon: Image.asset('assets/icon_password.png'),
          obscureText: true,
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              _authCubit.register(
                name: _fullNameController.text,
                username: _usernameController.text,
                email: _emailController.text,
                password: _passwordController.text,
              );
            },
            child: Text(
              'Sign Up',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _footer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: subtitleTextStyle.copyWith(
            fontSize: 12,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamedAndRemoveUntil(
            context,
            SignInPage.routName,
            (route) => false,
          ),
          child: Text(
            'Sign in',
            style: purpleTextStyle.copyWith(
              fontSize: 12,
              fontWeight: medium,
            ),
          ),
        ),
      ],
    );
  }
}
