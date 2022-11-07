import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/levels_data.dart';
import 'level_9.dart';
import 'levels_list.dart';
import 'widget/custom_button.dart';
import 'widget/level_details.dart';

class Shape extends StatefulWidget {
  const Shape({Key? key}) : super(key: key);

  @override
  State<Shape> createState() => _ShapeState();
}

class _ShapeState extends State<Shape> {
  late Timer _timer;
  int sec = 40;
  int t1 = 10;
  int t = 30;
  late bool firstAns = true;
  late int cans = 0;
  late int ans = 0;
  late int time = 0;
  late int error = 0;
  late bool gameOver = false;
  late double fontSize = 50;
  SqlDb sqlDb = SqlDb();
  timer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (sec > 31) {
          t1--;
          sec--;
        } else if (sec > 0) {
          sec--;
          t = sec;
          gameOver = true;
        } else {
          final player = AudioPlayer();
          player.play(AssetSource('11.wav'));
          _timer.cancel();
          stop();
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

  updateData(int tofa, int toca, int time, int nerrors, String answer,
      String note) async {
    await sqlDb.updateData(
        "UPDATE 'data' SET tofa = $tofa,toca = $toca,time = $time, nerrors = $nerrors, answer = '$answer', note = '$note'  WHERE level = 8");
  }

  incorrect() {
    _timer.cancel();
    if (firstAns == true) {
      firstAns = false;
      ans = 30 - sec;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
              child: Text("خطأ!"),
            ),
            actions: [
              CustomButton(
                function: () {
                  Get.back();
                  timer();
                  // int response = await sqlDb.deleteData("DELETE FROM 'data' WHERE level = 1");
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

    if (firstAns == true) {
      firstAns = false;
      ans = 30 - sec;
    }
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
                      cans = 30 - sec;
                    },
                    buttonText: "القائمة",
                  ),
                  CustomButton(
                    function: () {
                      Get.to(() => Details(
                            function: () {
                              Get.to(() => const Apple());
                            },
                            text: "اضغط على اكبر تفاحة و اضغط على اصغر تفاحة",
                            assets: "assets/level9/222.png",
                            title: "المستوى التاسع",
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
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (gameOver == false)
              Column(
                children: [
                  Text(
                    t1.toString(),
                    style: TextStyle(fontSize: fontSize),
                  ),
                  Text(
                    "تذكر لون الكرة جيدا",
                    style: TextStyle(fontSize: fontSize),
                  ),
                  Ink.image(
                    image: const AssetImage("assets/level8/123.jpg"),
                    height: MediaQuery.of(context).size.width / 0.95,
                    width: MediaQuery.of(context).size.width / 1,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            if (gameOver == true)
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    t.toString(),
                    style: TextStyle(fontSize: fontSize),
                  ),
                  Ink.image(
                    image: const AssetImage("assets/level8/123123.jpg"),
                    height: MediaQuery.of(context).size.width / 1,
                    width: MediaQuery.of(context).size.width / 1.5,
                    fit: BoxFit.cover,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        splashColor: Colors.black26,
                        onTap: () {
                          cans = 30 - sec;
                          final player = AudioPlayer();
                          player.play(AssetSource('13.wav'));
                          correct();
                          int time = cans - ans;
                          updateData(ans, cans, time, error, "نعم", "");
                        },
                        child: Ink.image(
                          image: const AssetImage("assets/level8/111.jpg"),
                          height: MediaQuery.of(context).size.width / 4,
                          width: MediaQuery.of(context).size.width / 3,
                          fit: BoxFit.cover,
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.black26,
                        onTap: () {
                          error++;
                          if (error == 5) {
                            final player = AudioPlayer();
                            player.play(AssetSource('11.wav'));
                            stop();
                          } else {
                            final player = AudioPlayer();
                            player.play(AssetSource('14.wav'));
                            incorrect();
                          }
                        },
                        child: Ink.image(
                          image: const AssetImage("assets/level8/11.jpg"),
                          height: MediaQuery.of(context).size.width / 4,
                          width: MediaQuery.of(context).size.width / 3,
                          fit: BoxFit.cover,
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.black26,
                        onTap: () {
                          error++;
                          if (error == 5) {
                            final player = AudioPlayer();
                            player.play(AssetSource('11.wav'));
                            stop();
                          } else {
                            final player = AudioPlayer();
                            player.play(AssetSource('14.wav'));
                            incorrect();
                          }
                        },
                        child: Ink.image(
                          image: const AssetImage("assets/level8/1222.jpg"),
                          height: MediaQuery.of(context).size.width / 4,
                          width: MediaQuery.of(context).size.width / 3,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      )),
    );
  }
}
