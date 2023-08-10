import 'package:ecommerce_app/core/utils/colors_style.dart';
import 'package:flutter/material.dart';

ThemeData get themeData {
  return ThemeData(
    scaffoldBackgroundColor: backgroundColor1,
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundColor1,
      toolbarHeight: 87,
      titleTextStyle: primaryTextStyle.copyWith(
        fontSize: 18,
        fontWeight: medium,
      ),
      elevation: 0,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(primaryTextStyle),
        overlayColor: MaterialStatePropertyAll(
          primaryColor.withOpacity(0.1),
        ),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.grey.shade300.withOpacity(0.3);
          }

          return Colors.transparent;
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.grey;
          }

          return primaryTextColor;
        }),
        side: MaterialStatePropertyAll(
          BorderSide(color: primaryColor),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: primaryColor),
          ),
        ),
        fixedSize: const MaterialStatePropertyAll(
          Size(double.infinity, 50),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(primaryTextStyle),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.grey.shade500;
          }

          return primaryColor;
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.grey.shade200;
          }

          return primaryTextColor;
        }),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        fixedSize: const MaterialStatePropertyAll(
          Size(double.infinity, 50),
        ),
      ),
    ),
  );
}
