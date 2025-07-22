import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({required this.text, this.ontap});
  String text;
  VoidCallback? ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
        ),
        child: Center(
          child: Text(
            "$text",
            style: TextStyle(color: Color(0xff314F6A), fontSize: 16),
          ),
        ),
      ),
    );
  }
}
