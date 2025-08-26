import 'package:flutter/material.dart';
import 'package:recap/constans.dart';

class CustomButton extends StatelessWidget {
  CustomButton({required this.text, this.ontap});

  String text;
  VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ontap, 
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Constans.thirdColor),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
      ),
      child: Center(
        child: Text(
          "$text",
          style: TextStyle(color: Constans.primiryColor, fontSize: 16),
        ),
      ),
    );
  }
}
