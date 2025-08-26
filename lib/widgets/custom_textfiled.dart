import 'package:flutter/material.dart';

import '../constans.dart';

class CustomTextfiled extends StatelessWidget {
  CustomTextfiled({
    required this.hintText,
    required this.labelText,
    required this.isScure,
    this.onChanged,
    this.controller,
    this.enabled,
    this.suffixIcon,
    this.onToggle,
    this.isPasswordVisible = false,
  });
  String hintText;
  String labelText;
  bool isScure;
  IconButton ? suffixIcon;
  TextEditingController? controller;
  Function(String)? onChanged;
  bool? enabled;
  Function()? onToggle;
 bool isPasswordVisible;
  
  @override
  Widget build(BuildContext context) {

    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "You must enter the $labelText";
        }
      },
      enabled: enabled,
      controller: controller,
      onChanged: onChanged ?? (value) {},
      style: TextStyle(color: Colors.white, fontSize: 14),
      cursorColor: Colors.white,
      obscureText: isScure ?? false,
      decoration: InputDecoration(
        suffixIcon:suffixIcon ?? null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Constans.textColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constans.textColor, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Constans.textColor, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        enabled: true,
        labelText: "$labelText",
        labelStyle: TextStyle(color: Constans.textColor, fontSize: 12),
        hintText: "$hintText",
        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
        
      ),
    );
  }
}
