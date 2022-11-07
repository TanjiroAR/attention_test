import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/levels_data.dart';
import 'level_7.dart';
import 'levels_list.dart';
import 'widget/custom_button.dart';
import 'widget/level_details.dart';

class Change extends StatefulWidget {
  const Change({Key? key}) : super(key: key);

  @override
  State<Change> createState() => _ChangeState();
}

class _ChangeState extends State<Change> {
  late Timer _timer;
  late double height = MediaQuery.of(context).size.height;
  late double width = MediaQuery.of(context).size.width;
  late int sec = 30;
  late double fontSize = 50;
  late int a1 = 1;
  late int a2 = 1;
  late int a3 = 1;
  late bool firstAns = true;
  late int cans = 0;
  late int ans = 0;
  late int time=0;
  late int error = 0;
  SqlDb sqlDb = SqlDb();
  timer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (sec > 0) {
          sec--;
        } else {
          a1 =3;
          a2 =3;
          a3 =3;
          _timer.cancel();
          stop();
          final player = AudioPlayer();
          player.play(AssetSource('11.wav'));
        }
      });
    });
  }
  stop() {
    _timer.cancel();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
              child: Text("😥لقد فشلت"),
            ),
            actions: [
              CustomButton(
                function: () {
                  error = 0;
                  sec = 30;
                  firstAns = true;
                  timer();
                  Get.back();
                },
                buttonText: "حاول مجددا",
                width: double.infinity,
              )
            ],
          );
        });
  }
  updateData(int tofa, int toca, int time, int nerrors, String answer , String note) async{
    await sqlDb.updateData("UPDATE 'data' SET tofa = $tofa,toca = $toca,time = $time, nerrors = $nerrors, answer = '$answer', note = '$note'  WHERE level = 6");

  }
  correct() {
    final player = AudioPlayer();
    player.play(AssetSource('13.wav'));
    _timer.cancel();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
              child: Text("أحسنت"),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    function: ()  {
                      Get.offAll(() => const Levels());
                    },
                    buttonText: "القائمة",

                  ),
                  CustomButton(
                    function: ()  {
                      Get.to(() => Details(
                        function: () {
                          Get.to(() => const Level7());
                        },
                        assets: "assets/level7/2.jpg",
                        text:
                        // "إكمال الشكل بوضع الدائرة الملونة مع الكوب الملون بنفس اللون "
                        "إكمال الجزء الثانى من الولد",
                        title: "المستوى السابع",
                      ));
                    },
                    buttonText: "المستوى التالي",
                  ),
                ],
              )
            ],
          );
        });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Text(sec.toString(), style: TextStyle(fontSize: fontSize)),
          Ink.image(
            image: const AssetImage("assets/level6/661.png"),
            height: height / 2.3,
            width: width,
            fit: BoxFit.fill,
            child: Column(
              children: [
                SizedBox(
                  height: height / 9,
                  child: Row(
                    children: [
                      SizedBox(
                        height: height / 9,
                        width: width * (1 / 3),
                      ),
                      if(a1 == 1)
                        InkWell(
                          onTap: () {
                            final player = AudioPlayer();
                            player.play(AssetSource('12.wav'));
                            if (firstAns == true) {
                              firstAns = false;
                              ans = 30 - sec;
                            }
                            setState(() {
                              a1 = 2;
                            });
                            if(a1 == 2 && a2 == 2 && a3 == 2){
                              correct();
                              cans = 30 - sec;
                              time = cans - ans;
                              updateData(ans, cans, time, 0, "نعم", "");
                            }
                          },
                          child: SizedBox(
                            height: height / 9,
                            width: width * (2 / 3),
                          ),
                        ),
                      if(a1 == 2)
                        Ink.image(image: const AssetImage("assets/77.png"),height: height / 9,width:width * (2 / 3),),
                      if(a1 == 3)
                        Ink.image(image: const AssetImage("assets/78.png"),height: height / 9,width:width * (2 / 3),),
                    ],
                  ),
                ),
                SizedBox(
                  height: height / 7,
                  child: Row(
                    children: [
                      if(a2 == 1)
                        InkWell(
                          onTap: () {
                            final player = AudioPlayer();
                            player.play(AssetSource('12.wav'));
                            if (firstAns == true) {
                              firstAns = false;
                              ans = 30 - sec;
                            }
                            setState(() {
                              a2 = 2;
                            });
                            if(a1 == 2 && a2 == 2 && a3 == 2){
                              correct();
                              cans = 30 - sec;
                              time = cans - ans;
                              updateData(ans, cans, time, 0, "نعم", "");
                            }
                          },
                          child: SizedBox(
                            height: height / 7,
                            width: width * (1 / 3),
                          ),
                        ),
                      if(a2 == 2)
                        Ink.image(image: const AssetImage("assets/77.png"),height: height / 7,width:width * (1 / 3),),
                      if(a2 == 3)
                        Ink.image(image: const AssetImage("assets/78.png"),height: height / 7,width:width * (1 / 3),),
                      SizedBox(
                        height: height / 7,
                        width: width * (2 / 3),
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: height / 6,
                  child: Row(
                    children: [
                      SizedBox(
                        height: height / 6,
                        width: width * (2/7),
                      ),
                      if(a3 == 1)
                        InkWell(
                          onTap: () {
                            final player = AudioPlayer();
                            player.play(AssetSource('12.wav'));
                            if (firstAns == true) {
                              firstAns = false;
                              ans = 30 - sec;
                            }
                            setState(() {
                              a3 = 2;
                            });
                            if(a1 == 2 && a2 == 2 && a3 == 2){
                              correct();
                              cans = 30 - sec;
                              time = cans - ans;
                              updateData(ans, cans, time, 0, "نعم", "");
                            }
                          },
                          child: SizedBox(
                            height: height / 6,
                            width: width * (4/7),
                          ),
                        ),
                      if(a3 == 2)
                        Ink.image(image: const AssetImage("assets/77.png"),height: height / 6,width:width * (4/7),),
                      if(a3 == 3)
                        Ink.image(image: const AssetImage("assets/78.png"),height: height / 6,width:width * (4/7),),
                      SizedBox(
                        height: height / 6,
                        width: width * (1 / 7),
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),
          Ink.image(
            image: const AssetImage("assets/level6/662.png"),
            height: height / 2.3,
            width: width,
            fit: BoxFit.fill,
            child: Column(
              children: [
                SizedBox(
                  height: height / 9,
                  child: Row(
                    children: [
                      SizedBox(
                        height: height / 9,
                        width: width * (1 / 3),
                      ),
                      if(a1 == 1)
                        InkWell(
                          onTap: () {
                            final player = AudioPlayer();
                            player.play(AssetSource('12.wav'));
                            if (firstAns == true) {
                              firstAns = false;
                              ans = 30 - sec;
                            }
                            setState(() {
                              a1 = 2;
                            });
                            if(a1 == 2 && a2 == 2 && a3 == 2){
                              correct();
                              cans = 30 - sec;
                              time = cans - ans;
                              updateData(ans, cans, time, 0, "نعم", "");
                            }
                          },
                          child: SizedBox(
                            height: height / 9,
                            width: width * (2 / 3),
                          ),
                        ),
                      if(a1 == 2)
                        Ink.image(image: const AssetImage("assets/77.png"),height: height / 9,width:width * (2 / 3),),
                      if(a1 == 3)
                        Ink.image(image: const AssetImage("assets/78.png"),height: height / 9,width:width * (2 / 3),),
                    ],
                  ),
                ),
                SizedBox(
                  height: height / 7,
                  child: Row(
                    children: [
                      if(a2 == 1)
                        InkWell(
                          onTap: () {
                            final player = AudioPlayer();
                            player.play(AssetSource('12.wav'));
                            if (firstAns == true) {
                              firstAns = false;
                              ans = 30 - sec;
                            }
                            setState(() {
                              a2 = 2;
                            });
                            if(a1 == 2 && a2 == 2 && a3 == 2){
                              correct();
                              cans = 30 - sec;
                              time = cans - ans;
                              updateData(ans, cans, time, 0, "نعم", "");
                            }
                          },
                          child: SizedBox(
                            height: height / 7,
                            width: width * (1 / 3),
                          ),
                        ),
                      if(a2 == 2)
                        Ink.image(image: const AssetImage("assets/77.png"),height: height / 7,width:width * (1 / 3),),
                      if(a2 == 3)
                        Ink.image(image: const AssetImage("assets/78.png"),height: height / 7,width:width * (1 / 3),),
                      SizedBox(
                        height: height / 7,
                        width: width * (2 / 3),
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: height / 6,
                  child: Row(
                    children: [
                      SizedBox(
                        height: height / 6,
                        width: width * (2/7),
                      ),
                      if(a3 == 1)
                        InkWell(
                          onTap: () {
                            final player = AudioPlayer();
                            player.play(AssetSource('12.wav'));
                            if (firstAns == true) {
                              firstAns = false;
                              ans = 30 - sec;
                            }
                            setState(() {
                              a3 = 2;
                            });
                            if(a1 == 2 && a2 == 2 && a3 == 2){
                              correct();
                              cans = 30 - sec;
                              time = cans - ans;
                              updateData(ans, cans, time, 0, "نعم", "");
                            }
                          },
                          child: SizedBox(
                            height: height / 6,
                            width: width * (4/7),
                          ),
                        ),
                      if(a3 == 2)
                        Ink.image(image: const AssetImage("assets/77.png"),height: height / 6,width:width * (4/7),),
                      if(a3 == 3)
                        Ink.image(image: const AssetImage("assets/78.png"),height: height / 6,width:width * (4/7),),
                      SizedBox(
                        height: height / 6,
                        width: width * (1 / 7),
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),
        ],
      )),
    );
  }
}
