// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizu/util/dimensions.dart';
import 'package:quizu/util/styles.dart';
import 'package:quizu/view/base/custom_button.dart';

class ConfirmationDialog extends StatelessWidget {
  final Widget icon;
  final String? title;
  final String description;
  final Function onYesPressed;
  final bool isLogOut;
  final Function? onNoPressed;
  final bool isAddress;
  final bool isProduct;
  const ConfirmationDialog(
      {required this.icon,
      this.title,
      required this.description,
      required this.onYesPressed,
      this.isLogOut = false,
      this.onNoPressed,
      this.isAddress = false,
      this.isProduct = false});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(
          // width: 500,
          child: Padding(
        padding: const EdgeInsets.all(Dimensions.RADIUS_EXTRA_LARGE),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            child: icon,
          ),
          title != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_LARGE),
                  child: Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: poppinsMedium.copyWith(
                        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                        color: Colors.red),
                  ),
                )
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            child: Text(description,
                style: poppinsMedium.copyWith(
                    fontSize: Dimensions.FONT_SIZE_LARGE),
                textAlign: TextAlign.center),
          ),
          const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

          Row(children: [
            Expanded(
                child: TextButton(
              onPressed: () => isLogOut
                  ? onYesPressed()
                  : onNoPressed != null
                      ? onNoPressed!()
                      : Get.back(),
              style: TextButton.styleFrom(
                backgroundColor:
                    Theme.of(context).disabledColor.withOpacity(0.3),
                minimumSize: const Size(Dimensions.WEB_MAX_WIDTH, 40),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.RADIUS_SMALL)),
              ),
              child: Text(
                isLogOut ? 'Yes' : 'No',
                textAlign: TextAlign.center,
                style: poppinsBold.copyWith(
                    color: Theme.of(context).textTheme.bodyText1!.color),
              ),
            )),
            const SizedBox(width: Dimensions.PADDING_SIZE_LARGE),
            Expanded(
                child: CustomButton(
              textColor: Colors.white,
              buttonText: isLogOut ? 'No' : 'Yes',
              onPressed: () => isLogOut ? Get.back() : onYesPressed(),
              radius: Dimensions.RADIUS_SMALL,
              height: 40,
            )),
          ])
          // : Center(child: LoadingLottie());
        ]),
      )),
    );
  }
}
