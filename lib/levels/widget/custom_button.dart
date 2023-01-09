import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function function;
  final double width, height, borderRadius, sizeTextButton;
  final FontWeight fontWeight;
  final Color colorButton, colorTextButton;
  const CustomButton({
    super.key,
    this.buttonText = 'ابدء',
    required this.function,
    this.width = 80,
    this.height = 50,
    this.borderRadius = 10,
    this.sizeTextButton = 15,
    this.fontWeight = FontWeight.bold,
    this.colorButton = Colors.purple,
    this.colorTextButton = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> function(),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: colorButton,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: CustomText(
            text: buttonText,
            color: colorTextButton,
            fontSize: sizeTextButton,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
