import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String initalValue;
  final String label;
  final bool isPassword;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final Function validator;
  final Function onTextChangeListener;
  const CustomTextFormField({
    super.key,
    this.initalValue = "",
    required this.label,
    this.isPassword = false,
    required this.textInputType,
    required this.textInputAction,
    required this.validator,
    required this.onTextChangeListener,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: isPassword,
      autocorrect: !isPassword,
      enableSuggestions: !isPassword,
      initialValue: initalValue,
      keyboardType: textInputType,
      decoration: InputDecoration(
        labelText: label,
      ),
      textInputAction: textInputAction,
      validator: (value) => validator(value),
      onChanged: (value) {
        onTextChangeListener(value);
      },
    );
  }
}
