// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizu/util/dimensions.dart';
import 'package:quizu/util/styles.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  final Function? onChanged;
  final Function? onSubmit;
  final bool isEnabled;
  final int maxLines;
  final TextCapitalization capitalization;
  final String? prefixIcon;
  final bool divider;
  final int? maxLength;
  final EdgeInsets? contentPadding;
  final bool isNote;
  final bool autofocus;

  const CustomTextField(
      {this.hintText = 'Write something...',
      this.controller,
      this.focusNode,
      this.nextFocus,
      this.isEnabled = true,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.next,
      this.maxLines = 1,
      this.onSubmit,
      this.onChanged,
      this.prefixIcon,
      this.capitalization = TextCapitalization.none,
      this.isPassword = false,
      this.divider = false,
      this.maxLength,
      this.contentPadding,
      this.isNote = false,
      this.autofocus = false});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          controller: widget.controller,
          focusNode: widget.focusNode,
          style: poppinsRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
          textInputAction: widget.inputAction,
          keyboardType: widget.inputType,
          cursorColor: Theme.of(context).primaryColor,
          textCapitalization: widget.capitalization,
          enabled: widget.isEnabled,
          autofocus: widget.autofocus,
          obscureText: widget.isPassword ? _obscureText : false,
          inputFormatters: widget.inputType == TextInputType.phone
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                ]
              : null,
          decoration: InputDecoration(
            counterText: '',
            contentPadding: widget.contentPadding,
            border: OutlineInputBorder(
              borderRadius: widget.isNote == true
                  ? const BorderRadius.all(Radius.circular(5))
                  : const BorderRadius.only(
                      bottomRight: Radius.circular(8),
                      topRight: Radius.circular(8)),
              borderSide: const BorderSide(style: BorderStyle.none, width: 0),
            ),
            isDense: true,
            hintText: widget.hintText,
            fillColor: Theme.of(context).cardColor,
            hintTextDirection: TextDirection.ltr,
            hintStyle: poppinsRegular.copyWith(
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: Theme.of(context).hintColor),
            filled: true,
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_SMALL),
                    child: Image.asset(widget.prefixIcon.toString(),
                        height: 20, width: 20),
                  )
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Theme.of(context).hintColor.withOpacity(0.3)),
                    onPressed: _toggle,
                  )
                : null,
          ),
          onSubmitted: (text) => widget.nextFocus != null
              ? FocusScope.of(context).requestFocus(widget.nextFocus)
              : widget.onSubmit != null
                  ? widget.onSubmit!(text)
                  : null,
          onChanged: (i) => widget.onChanged,
        ),
        widget.divider
            ? const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_LARGE),
                child: Divider())
            : const SizedBox(),
      ],
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
