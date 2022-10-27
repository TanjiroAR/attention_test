import 'package:flutter/material.dart';

class Level extends StatelessWidget {
  final String assets, text1, text2;
  final Function function;
  final double width, height, borderRadius, sizeText;
  final FontWeight fontWeight;
  final Color colorText;
  const Level({
    super.key,
    this.width = double.infinity,
    this.height = 120,
    this.borderRadius = 10,
    this.sizeText = 15,
    this.text1 = "",
    this.text2 = "",
    this.assets = "assets/12.png",
    required this.function,
    this.fontWeight = FontWeight.bold,
    this.colorText = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          InkWell(
            splashColor: Colors.black26,
            onTap: ()=>function(),

            child: Container(
              color: Colors.black12,
              child: Column(
                children: [
                  Ink.image(
                    image: AssetImage(assets),
                    height: height,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        text1,
                        style: TextStyle(
                          fontWeight: fontWeight,
                          color: colorText,
                          fontSize: sizeText,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        text2,
                        style: TextStyle(
                          fontWeight: fontWeight,
                          color: colorText,
                          fontSize: sizeText * 1.7,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
