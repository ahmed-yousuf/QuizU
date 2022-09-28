// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:quizu/util/dimensions.dart';
import 'package:quizu/util/styles.dart';

class ProfileButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool? isButtonActive;
  final Function? onTap;
  const ProfileButton(
      {required this.icon,
      required this.title,
      this.onTap,
      this.isButtonActive});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_SMALL,
          vertical: isButtonActive != null
              ? Dimensions.PADDING_SIZE_EXTRA_SMALL
              : Dimensions.PADDING_SIZE_DEFAULT,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
          boxShadow: const [
            BoxShadow(
                // color: Colors.grey![Get.isDarkMode ? 800 : 200],
                spreadRadius: 1,
                blurRadius: 5)
          ],
        ),
        child: Row(children: [
          Icon(icon, size: 25),
          const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          Expanded(child: Text(title, style: poppinsRegular)),
          isButtonActive != null
              ? Switch(
                  value: isButtonActive ?? false,
                  onChanged: (bool isActive) => onTap!(),
                  activeColor: Theme.of(context).primaryColor,
                  activeTrackColor:
                      Theme.of(context).primaryColor.withOpacity(0.5),
                )
              : const SizedBox(),
        ]),
      ),
    );
  }
}
