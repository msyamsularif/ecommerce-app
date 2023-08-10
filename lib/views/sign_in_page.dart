import 'package:ecommerce_app/view_models/auth/auth_cubit.dart';
import 'package:ecommerce_app/views/main_page.dart';
import 'package:ecommerce_app/views/sign_up_page.dart';
import 'package:ecommerce_app/views/widget/ct_text_field.dart';
import 'package:ecommerce_app/core/utils/colors_style.dart';
import 'package:ecommerce_app/views/widget/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  static const String routName = '/sign-in';

  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final AuthCubit _authCubit;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _authCubit = context.read<AuthCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.login) {
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
                'Failed to Login!',
                style: primaryTextStyle.copyWith(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: EdgeInsets.all(defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(),
                const SizedBox(height: 70),
                _formBody(),
                const Spacer(),
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
          'Login',
          style: primaryTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'Sign In to Countinue',
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
              _authCubit.login(
                email: _emailController.text,
                password: _passwordController.text,
              );
            },
            child: Text(
              'Sign In',
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
          'Don\'t have an account? ',
          style: subtitleTextStyle.copyWith(
            fontSize: 12,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            SignUpPage.routName,
          ),
          child: Text(
            'Sign up',
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
