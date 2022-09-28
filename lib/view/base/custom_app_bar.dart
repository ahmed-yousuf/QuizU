// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:quizu/util/dimensions.dart';
import 'package:quizu/util/styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButtonExist;
  final Function? onBackPressed;
  final bool showCart;
  const CustomAppBar(
      {required this.title,
      this.isBackButtonExist = true,
      this.onBackPressed,
      this.showCart = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title,
          style: poppinsRegular.copyWith(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              color: Theme.of(context).textTheme.bodyText1!.color)),
      centerTitle: true,
      leading: isBackButtonExist
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Theme.of(context).textTheme.bodyText1!.color,
              onPressed: () => onBackPressed != null
                  ? onBackPressed!()
                  : Navigator.pop(context),
            )
          : const SizedBox(),
      backgroundColor: Theme.of(context).cardColor,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size(1170, 50);
}
