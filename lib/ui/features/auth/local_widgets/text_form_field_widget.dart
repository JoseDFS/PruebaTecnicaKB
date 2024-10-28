import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget(
      {super.key,
      this.enabled,
      this.maxLength = 20,
      this.maxLines = 1,
      this.controller,
      this.keyboardType = TextInputType.number,
      this.autovalidateMode,
      this.style,
      this.labelStyle,
      this.labelText,
      this.inputFormatters,
      this.validator,
      this.onChanged,
      this.counterText,
      this.obscureText});

  final bool? enabled;
  final int? maxLength;
  final int maxLines;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final AutovalidateMode? autovalidateMode;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final String? labelText;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final String? counterText;
  final bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      enabled: enabled,
      controller: controller,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: keyboardType,
      maxLines: maxLines,
      textAlign: TextAlign.start,
      textCapitalization: TextCapitalization.sentences,
      style: style,
      autovalidateMode: autovalidateMode,
      onChanged: onChanged,
      validator: validator,
      inputFormatters: inputFormatters,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          isDense: true,
          labelText: labelText,
          labelStyle: labelStyle,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
            borderSide: BorderSide(
              color: Colors.blue,
              style: BorderStyle.solid,
              width: 1.0,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
            borderSide: BorderSide(
              color: Color.fromRGBO(216, 224, 240, 1),
              style: BorderStyle.solid,
              width: 1.0,
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
            borderSide: BorderSide(
              color: Color.fromRGBO(216, 224, 240, 1),
              style: BorderStyle.solid,
              width: 1.0,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
            borderSide: BorderSide(
              width: 1.0,
              color: Color.fromRGBO(216, 224, 240, 1),
            ),
          ),
          counterText: counterText),
    );
  }
}
