import 'package:flutter/material.dart';

class CustomTextfiled extends StatelessWidget {
  CustomTextfiled({
    required this.hintText,
    required this.labelText,
    this.isScure,
    this.onChanged,
  });
  String hintText;
  String labelText;
  bool? isScure;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged ?? (value) {},
      style: TextStyle(color: Colors.white, fontSize: 14),
      cursorColor: Colors.white,
      obscureText: isScure ?? false,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        enabled: true,
        labelText: "$labelText",
        labelStyle: TextStyle(color: Colors.white, fontSize: 12),
        hintText: "$hintText",
        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
      ),
    );
  }
}
