// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:quizu/util/dimensions.dart';

import '../../util/styles.dart';

void showCustomSnackBar(String message, BuildContext context,
    {bool isError = true}) {
  if (message.isNotEmpty) {
    showSimpleNotification(
      Text(
        message,
        style:
            poppinsMedium.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
      ),
      position: NotificationPosition.top,
      background: isError ? Colors.red : Theme.of(context).secondaryHeaderColor,
      duration: const Duration(seconds: 3),
      slideDismiss: true,
    );
  }
}
