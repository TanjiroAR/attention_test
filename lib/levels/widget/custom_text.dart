import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;

  final double fontSize;

  final Color color;

  final Alignment alignment;
  var textDirection;

//  final int maxLine;
  final double height;
  final FontWeight fontWeight;
  CustomText({
    super.key,
    this.text = '',
    this.fontSize = 16,
    this.color = Colors.black,
    this.alignment = Alignment.center,
    this.textDirection = TextDirection.rtl, //    this.maxLine=0,
    this.height = 1,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text,
        textAlign: TextAlign.center,
        textDirection: textDirection,
        style: TextStyle(
          fontWeight: fontWeight,
          color: color,
          height: height,
          fontSize: fontSize,
        ),
//        maxLines: maxLine,
      ),
    );
  }
}
