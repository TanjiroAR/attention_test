import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../data/levels_data.dart';
import 'level_4.dart';
import 'levels_list.dart';
import 'widget/custom_button.dart';
import 'widget/level_details.dart';

class Car extends StatefulWidget {
  const Car({Key? key}) : super(key: key);

  @override
  State<Car> createState() => _CarState();
}

class _CarState extends State<Car> {
  late Timer _timer;
  late int sec = 30;
  late double fontSize = 50;
  bool a = false;
  late String text1 = "ابدء";
  late int cans = 0;
  late int ans = 0;
  late int time = 0;
  late int error = 0;
  SqlDb sqlDb = SqlDb();
  updateData(int tofa, int toca, int time, int nerrors, String answer,
      String note) async {
    await sqlDb.updateData(
        "UPDATE 'data' SET tofa = $tofa,toca = $toca,time = $time, nerrors = $nerrors, answer = '$answer', note = '$note'  WHERE level = 3");
  }

  timer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (sec > 0) {
          sec--;
        } else {
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
                    function: () {
                      Get.offAll(() => const Levels());
                    },
                    buttonText: "القائمة",
                  ),
                  CustomButton(
                    function: () {
                      Get.to(() => Details(
                        function: () {
                          Get.to(const Balloon());
                        },
                        text:
                        "استمرار الإدراك البصري لمتابعة ظهور بلونة صغيرة لونها احمر ثم تبدأ يزيد حجمها بالتدريج ومحاولة تفجيرها لمدة30 ثانية. ",
                        assets: "assets/level4/13.png",
                        title: "المستوى الرابع",
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sec.toString(),
              style: TextStyle(fontSize: fontSize),
            ),
            TextButton(
              onPressed: () {
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
              },
              child: Lottie.asset(
                "assets/level3/car1.json",
                animate: a,
              ),
            ),
            CustomButton(
              function: () {
                if (a == false) {
                  timer();
                  setState(() {
                    a = true;
                    text1 = "توقف";
                  });
                } else {
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
              buttonText: text1,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
