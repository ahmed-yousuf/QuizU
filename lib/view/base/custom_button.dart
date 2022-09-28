// ignore_for_file: use_key_in_widget_constructors, prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizu/util/dimensions.dart';
import 'package:quizu/util/styles.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double radius;
  final IconData? icon;
  final Color? buttonColor;
  final Color? textColor;

  const CustomButton(
      {this.onPressed,
      this.buttonColor,
      this.textColor,
      required this.buttonText,
      this.transparent = false,
      this.margin,
      this.width,
      this.height,
      this.fontSize,
      this.radius = 8,
      this.icon});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButtonStyle = TextButton.styleFrom(
      backgroundColor: onPressed == null
          ? Theme.of(context).disabledColor
          : transparent
              ? buttonColor
              : Theme.of(context).primaryColor,
      minimumSize: Size(width ?? Dimensions.WEB_MAX_WIDTH, height ?? 50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );

    return Center(
        child: SizedBox(
            width: width ?? Dimensions.WEB_MAX_WIDTH,
            child: Padding(
              padding: margin ?? const EdgeInsets.all(0),
              child: TextButton(
                onPressed: onPressed,
                style: _flatButtonStyle,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  icon != null
                      ? Padding(
                          padding: const EdgeInsets.only(
                              right: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          child: Icon(icon,
                              color: transparent
                                  ? Theme.of(context).primaryColor
                                  : Get.isDarkMode
                                      ? Colors.white
                                      : Theme.of(context).cardColor),
                        )
                      : const SizedBox(),
                  Text(buttonText,
                      textAlign: TextAlign.center,
                      style: poppinsBold.copyWith(
                        color: textColor == null
                            ? Theme.of(context).primaryColor
                            : textColor,
                        fontSize: fontSize ?? Dimensions.FONT_SIZE_LARGE,
                      )),
                ]),
              ),
            )));
  }
}
