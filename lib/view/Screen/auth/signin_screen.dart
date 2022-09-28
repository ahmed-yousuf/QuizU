// ignore_for_file: use_key_in_widget_constructors

import 'dart:developer';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizu/controller/auth_controller.dart';
import 'package:quizu/helper/route_helper.dart';
import 'package:quizu/util/dimensions.dart';
import 'package:quizu/util/images.dart';
import 'package:quizu/util/styles.dart';
import 'package:quizu/view/Screen/auth/code_picker_widget.dart';
import 'package:quizu/view/base/custom_button.dart';
import 'package:quizu/view/base/custom_snackbar.dart';
import 'package:quizu/view/base/custom_text_field.dart';
import 'package:phone_number/phone_number.dart';

class SignInScreen extends StatefulWidget {
  final bool exitFromApp;

  const SignInScreen({required this.exitFromApp});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final TextEditingController _phoneController = TextEditingController();
  String _countryDialCode = '+966';
  bool isDeleteActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(Images.logoName, width: 250),
              const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
              Text('sign in'.toUpperCase(),
                  style: poppinsMedium.copyWith(fontSize: 30)),
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                        color: Get.isDarkMode
                            ? Colors.grey.shade700
                            : Colors.grey.shade300,
                        spreadRadius: 1,
                        blurRadius: Dimensions.RADIUS_SMALL)
                  ],
                ),
                child: Column(children: [
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(children: [
                      CodePickerWidget(
                        onChanged: (CountryCode countryCode) {
                          _countryDialCode = countryCode.dialCode!;
                          // print(_countryDialCode);
                        },
                        initialSelection: 'SA',
                        favorite: [_countryDialCode],
                        enabled: true,
                        showDropDownButton: false,
                        padding: EdgeInsets.zero,
                        showFlagMain: true,
                        flagWidth: 30,
                        dialogBackgroundColor: Theme.of(context).cardColor,
                        textStyle: poppinsRegular.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      ),
                      Container(
                        height: 20,
                        color: Colors.grey[300],
                        width: 2,
                      ),
                      Expanded(
                          flex: 1,
                          child: CustomTextField(
                            // maxLength: 9,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            hintText: 'phone',
                            controller: _phoneController,
                            focusNode: _phoneFocus,
                            nextFocus: _passwordFocus,
                            inputType: TextInputType.phone,
                            divider: false,
                          )),
                    ]),
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_LARGE),
                      child: Divider(height: 1)),
                ]),
              ),
              const SizedBox(height: 10),
              Row(children: [
                Expanded(
                    child: CustomButton(
                  textColor: Colors.white,
                  buttonText: 'verify phone',
                  onPressed: () {
                    _login(Get.find<AuthController>(), _countryDialCode);
                  },
                )),
              ])
              // : const Center(child: Text('Loading ..')),
            ])),
      )),
    );
  }

  void _login(AuthController authController, String countryDialCode) async {
    String _phone = _phoneController.text.trim();

    String _numberWithCountryCode = countryDialCode + _phone;
    bool _isValid = GetPlatform.isWeb ? true : false;
    if (!GetPlatform.isWeb) {
      try {
        PhoneNumber phoneNumber =
            await PhoneNumberUtil().parse(_numberWithCountryCode);
        _numberWithCountryCode =
            '+' + phoneNumber.countryCode + phoneNumber.nationalNumber;
        _isValid = true;
      } catch (e) {
        log(e.toString());
      }
    }
    if (_phone.isEmpty) {
      showCustomSnackBar(
        'Enter Phone Number',
        context,
      );
    } else if (!_isValid) {
      showCustomSnackBar(
        'Invalid Phone Number',
        context,
      );
    } else {
      print("User TextField -------->" + _numberWithCountryCode);
      Get.toNamed(RouteHelper.getVerificationRoute(
          false, _numberWithCountryCode, RouteHelper.signIn));
    }
    // print(_numberWithCountryCode);
  }
}
