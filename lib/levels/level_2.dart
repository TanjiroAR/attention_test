import 'dart:async';

import 'package:attention_test/levels/level_3.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../data/levels_data.dart';
import 'levels_list.dart';
import 'widget/custom_button.dart';
import 'widget/level_details.dart';

class Star extends StatefulWidget {
  const Star({Key? key}) : super(key: key);

  @override
  State<Star> createState() => _StarState();
}

class _StarState extends State<Star> {
  late Timer _timer;
  late int sec = 30;
  late double fontSize = 50;
  late bool a = false;
  late String text1="ابدء";
  late int cans = 0;
  late int ans = 0;
  late int time=0;
  late int error = 0;
  SqlDb sqlDb = SqlDb();
  updateData(int tofa, int toca, int time, int nerrors, String answer , String note) async{
    await sqlDb.updateData("UPDATE 'data' SET tofa = $tofa,toca = $toca,time = $time, nerrors = $nerrors, answer = '$answer', note = '$note'  WHERE level = 2");

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
                  Get.back();
                  Get.back();
                },
                buttonText: "حاول مجددا",
                width: double.infinity,
              )
            ],
          );
        });
  }

  timer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if(sec == 30){
          a = true;
        }
        if (sec > 0) {
          sec--;
        } else {
          a = false;
          _timer.cancel();
          stop();
          final player = AudioPlayer();
          player.play(AssetSource('11.wav'));
        }
      });
    });
  }
  correct() {
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
                      Get.offAll(() => Details(
                        function: () {
                          Get.to(const Car());
                        },
                        text:
                        "استمرار الانتباه البصري لسيارة تسير بسرعة و محاولة اقافها لمدة 30 ثانية .",
                        assets: "assets/level3/26.png",
                        title: "المستوى الثالث",
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
      backgroundColor: Colors.black,
      body: SafeArea(child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              sec.toString(),
              style: TextStyle(color: Colors.white, fontSize: fontSize),
            ),
            Container(
              height: 400,
              color: Colors.black,
              child: TextButton(
                onPressed: () {
                  if(a == true){
                    final player = AudioPlayer();
                    player.play(AssetSource('13.wav'));
                    setState(() {
                      a = false;
                    });
                    _timer.cancel();
                    cans = 30 - sec;
                    ans = 30 - sec;
                    int time = cans - ans;
                    updateData(ans, cans, time, error, "نعم", "");
                    correct();
                  }
                },
                child: Lottie.asset(
                  "assets/level2/star.json",
                  animate: a,
                ),
              ),
            ),
            // CustomButton(function: (){
            //   if(a == false){
            //     timer();
            //     setState(() {
            //       a = true;
            //       text1 = "توقف";
            //     });
            //
            //   }else{
            //     setState(() {
            //       a = false;
            //     });
            //     _timer.cancel();
            //     cans = 30 - sec;
            //     ans = 30 - sec;
            //     int time = cans - ans;
            //     updateData(ans, cans, time, error, "نعم", "");
            //     correct();
            //   }
            // },buttonText: text1,width: double.infinity,),
          ],
        ),
      )),
    );
  }
}
