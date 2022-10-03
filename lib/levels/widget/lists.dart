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

            child: Ink.image(
              image: AssetImage(assets),
              height: height,
              width: double.infinity,
              fit: BoxFit.cover,
                child: Column(
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
            ),
          ),

        ],
      ),
    );
  }
}
// Padding(
//   padding: const EdgeInsets.all(16).copyWith(bottom: 0),
//   child:  Text(
//     '',
//     style: TextStyle(fontSize: sizeText),
//     textAlign: TextAlign.right,
//   ),
// ),
// Ink.image(
//   image: AssetImage(assets),
//   height: height,
//   fit: BoxFit.cover,
//
//   child: InkWell(
//     onTap: () => function,
//   ),
// ),
// Positioned(
//     child: Column(
//   children: [
//     Text(
//       text1,
//       style: TextStyle(
//         fontWeight: fontWeight,
//         color: colorText,
//         fontSize: sizeText,
//       ),
//       textAlign: TextAlign.center,
//     ),
//     Text(
//       text2,
//       style: TextStyle(
//         fontWeight: fontWeight,
//         color: colorText,
//         fontSize: sizeText * 1.7,
//       ),
//       textAlign: TextAlign.center,
//     ),
//   ],
// )),