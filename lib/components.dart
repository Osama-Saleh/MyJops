// ignore_for_file: invalid_required_named_param

import 'package:flutter/material.dart';

String? uidUser;

Widget defaultTextFormField({
  @required controller,
  @required String? Function(String?)? validator,
  @required Function(dynamic value)? onFieldSubmitted,
  Widget? label,
  @required String? hintText,
  prefixIcon,
  suffixIcon,
  @required TextInputType? keyboardType,
  bool obscureText = false,
  Color? fillColor,
  bool filled = false,
  double radius = 0.0,
  // int? maxLines,
}) =>
    TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onFieldSubmitted: onFieldSubmitted,
      // maxLines: maxLines,
      decoration: InputDecoration(
        fillColor: fillColor,
        filled: filled,
        label: label,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),

          // borderSide: BorderSide(color: Colors.orange),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          // borderSide: BorderSide.none,
        ),
      ),
    );

Widget defaultMaterialButton({
  @required String? Function()? onPressed,
  @required double? borderRadius = 0.0,
  @required Color? color = Colors.blue,
  @required Widget? widget,
  double? minWidth = 100,
  double? height = 50,
}) {
  return MaterialButton(
    onPressed: onPressed,
    elevation: 0,
    
    shape: RoundedRectangleBorder(
        
        borderRadius: BorderRadius.circular(borderRadius!)),
    color: color,
    minWidth: minWidth,
    height: height,
    child: widget,
  );
}
