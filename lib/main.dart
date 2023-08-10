import 'package:ecommerce_app/core/utils/theme_data.dart';
import 'package:ecommerce_app/services/auth_service.dart';
import 'package:ecommerce_app/services/product_service.dart';
import 'package:ecommerce_app/services/transaction_service.dart';
import 'package:ecommerce_app/view_models/auth/auth_cubit.dart';
import 'package:ecommerce_app/view_models/cart/cart_cubit.dart';
import 'package:ecommerce_app/view_models/page/page_cubit.dart';
import 'package:ecommerce_app/view_models/product/product_cubit.dart';
import 'package:ecommerce_app/view_models/transaction/transaction_cubit.dart';
import 'package:ecommerce_app/view_models/wishlist/wishlist_cubit.dart';
import 'package:ecommerce_app/views/cart_page.dart';
import 'package:ecommerce_app/views/checkout_page.dart';
import 'package:ecommerce_app/views/checkout_success_page.dart';
import 'package:ecommerce_app/views/edit_profile_page.dart';
import 'package:ecommerce_app/views/main_page.dart';
import 'package:ecommerce_app/views/sign_in_page.dart';
import 'package:ecommerce_app/views/sign_up_page.dart';
import 'package:ecommerce_app/views/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(AuthService()),
        ),
        BlocProvider<ProductCubit>(
          create: (context) => ProductCubit(ProductService()),
        ),
        BlocProvider<WishlistCubit>(
          create: (context) => WishlistCubit(),
        ),
        BlocProvider<CartCubit>(
          create: (context) => CartCubit(),
        ),
        BlocProvider<TransactionCubit>(
          create: (context) => TransactionCubit(TransactionService()),
        ),
        BlocProvider<PageCubit>(
          create: (context) => PageCubit(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData,
        routes: {
          SplashPage.routName: (context) => const SplashPage(),
          SignInPage.routName: (context) => const SignInPage(),
          SignUpPage.routName: (context) => const SignUpPage(),
          MainPage.routName: (context) => const MainPage(),
          EditProfilePage.routName: (context) => const EditProfilePage(),
          CartPage.routName: (context) => const CartPage(),
          CheckoutPage.routName: (context) => const CheckoutPage(),
          CheckoutSuccessPage.routName: (context) =>
              const CheckoutSuccessPage(),
        },
      ),
    );
  }
}
