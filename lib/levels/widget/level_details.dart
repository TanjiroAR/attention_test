import 'package:attention_test/levels/widget/custom_button.dart';
import 'package:attention_test/levels/widget/custom_text.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final String assets, text, buttonText;
  final Function function;
  final double width,
      height,
      imageHeight,
      imageWidth,
      borderRadius,
      sizeText,
      sizeTextButton;
  final FontWeight fontWeight;
  final Color colorText, colorButton;
  const Details({
    super.key,
    this.imageHeight = 200,
    this.imageWidth = 300,
    this.width = double.infinity,
    this.height = 40,
    this.borderRadius = 26,
    this.sizeText = 15,
    this.sizeTextButton = 15,
    this.text = "",
    this.buttonText = "التالي",
    this.assets = "assets/12.png",
    required this.function,
    this.fontWeight = FontWeight.bold,
    this.colorText = Colors.black,
    this.colorButton = Colors.blueAccent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Ink.image(
                  image: AssetImage(assets),
                  height: imageHeight,
                  width: imageWidth,
                  fit: BoxFit.cover,
                )),
            CustomText(
              text: text,
              textDirection: TextDirection.ltr,
              fontWeight: fontWeight,
              fontSize: sizeText,
            ),
            CustomButton(function: ()=> function(),)

          ],
        ),
      ),
    );
  }
}
// InkWell(
// onTap: ()=> function(),
//
// child: Container(
//
// width: width,
// height: height,
// decoration: BoxDecoration(
// image: DecorationImage(
// image: AssetImage(image),
// fit: BoxFit.cover
// ),
// color: colorButton,
// borderRadius: BorderRadius.circular(borderRadius),
// ),
// child: Center(
// child: CustomText(
// text: buttonText,
// color: colorTextButton,
// fontSize: sizeTextButton,
// fontWeight: fontWeight,
// ),
// ),
// ),
// )