import 'package:ecommerce_app/core/utils/colors_style.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator._();

  static Future show({required BuildContext context}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingIndicator._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 74,
          height: 74,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(primaryColor),
            strokeWidth: 5,
          ),
        ),
      ),
    );
  }
}
