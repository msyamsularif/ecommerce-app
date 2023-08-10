import 'package:ecommerce_app/core/utils/colors_style.dart';
import 'package:flutter/material.dart';

class CTTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? title;
  final String? hintText;
  final Widget? prefixIcon;
  final bool obscureText;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;
  final EdgeInsets? contentPadding;
  final bool isUnderLineBorder;
  final bool filled;

  const CTTextField._({
    super.key,
    this.controller,
    this.focusNode,
    this.title,
    this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.autovalidateMode,
    this.validator,
    this.contentPadding,
    this.isUnderLineBorder = false,
    this.filled = true,
  });

  const CTTextField({
    Key? key,
    TextEditingController? controller,
    FocusNode? focusNode,
    String? title,
    String? hintText,
    Widget? prefixIcon,
    bool obscureText = false,
    AutovalidateMode? autovalidateMode,
    String? Function(String?)? validator,
    EdgeInsets? contentPadding,
  }) : this._(
          key: key,
          controller: controller,
          focusNode: focusNode,
          title: title,
          hintText: hintText,
          prefixIcon: prefixIcon,
          obscureText: obscureText,
          autovalidateMode: autovalidateMode,
          validator: validator,
          contentPadding: contentPadding,
        );

  const CTTextField.underLineBorder({
    Key? key,
    TextEditingController? controller,
    FocusNode? focusNode,
    String? title,
    String? hintText,
    Widget? prefixIcon,
    bool obscureText = false,
    AutovalidateMode? autovalidateMode,
    String? Function(String?)? validator,
    EdgeInsets? contentPadding,
  }) : this._(
          key: key,
          controller: controller,
          focusNode: focusNode,
          title: title,
          hintText: hintText,
          prefixIcon: prefixIcon,
          obscureText: obscureText,
          autovalidateMode: autovalidateMode,
          validator: validator,
          contentPadding: contentPadding,
          isUnderLineBorder: true,
          filled: false,
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: isUnderLineBorder
                ? secondaryTextStyle.copyWith(
                    fontSize: 13,
                  )
                : primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
          ),
          if (!isUnderLineBorder) const SizedBox(height: 12),
        ],
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          style: primaryTextStyle,
          obscureText: obscureText,
          decoration: InputDecoration(
            isDense: true,
            filled: filled,
            fillColor: backgroundColor2,
            hintText: hintText,
            hintStyle: subtitleTextStyle,
            prefixIcon: prefixIcon,
            prefixIconConstraints: BoxConstraints.tight(const Size(49, 17)),
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
            errorBorder: isUnderLineBorder
                ? UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: alertColor,
                      width: 1,
                    ),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: alertColor),
                  ),
            enabledBorder: isUnderLineBorder
                ? UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: subtitleTextColor,
                      width: 1,
                    ),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: backgroundColor2),
                  ),
            focusedBorder: isUnderLineBorder
                ? UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: primaryColor,
                      width: 1,
                    ),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor),
                  ),
            border: isUnderLineBorder
                ? UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: subtitleTextColor,
                      width: 1,
                    ),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: backgroundColor2),
                  ),
          ),
          autovalidateMode: autovalidateMode,
          validator: validator,
        ),
      ],
    );
  }
}
