import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/levels_data.dart';
import 'level_10.dart';
import 'levels_list.dart';
import 'widget/custom_button.dart';
import 'widget/level_details.dart';

class Apple extends StatefulWidget {
  const Apple({Key? key}) : super(key: key);

  @override
  State<Apple> createState() => _AppleState();
}

class _AppleState extends State<Apple> {
  late Timer _timer;
  int sec = 30;
  late bool firstAns = true;
  late int cans = 0;
  late int ans = 0;
  late int time = 0;
  late int error = 0;
  late bool gameOver = false;
  late String text1 = "اكبر";
  late double fontSize = 50;
  SqlDb sqlDb = SqlDb();
  timer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (sec > 0) {
          sec--;
        } else {
          final player = AudioPlayer();
          player.play(AssetSource('11.wav'));
          _timer.cancel();
          stop();
        }
      });
    });
  }

  updateData(int tofa, int toca, int time, int nerrors, String answer,
      String note) async {
    await sqlDb.updateData(
        "UPDATE 'data' SET tofa = $tofa,toca = $toca,time = $time, nerrors = $nerrors, answer = '$answer', note = '$note'  WHERE level = 9");
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
  correct1(){
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
              CustomButton(
                function: () {
                  text1 = "اصغر";
                  timer();
                  gameOver = true;
                  Get.back();
                },
                buttonText: "حسنا",
                width: double.infinity,
              ),
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
                          Get.to(() => const Move());
                        },
                        text: "اوصل السيارة الي المستطيل الابيض",
                        assets: "assets/level10/p.jpg",
                        title: "المستوى العاشر",
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
                  gameOver = false;
                  Get.back();
                },
                buttonText: "حاول مجددا",
                width: double.infinity,
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
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              sec.toString(),
              style: TextStyle(fontSize: fontSize),
            ),
            Text(
              " اختر $text1 تفاحة ",
              style: TextStyle(fontSize: fontSize),
            ),
            if (gameOver == false)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                      image: const AssetImage("assets/level9/44.png"),
                      height: MediaQuery.of(context).size.width / 4,
                      width: MediaQuery.of(context).size.width / 3,
                      fit: BoxFit.cover,
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.black26,
                    onTap: () {
                      final player = AudioPlayer();
                      player.play(AssetSource('12.wav'));
                      cans = 30 - sec;
                      correct1();

                    },
                    child: Ink.image(
                      image: const AssetImage("assets/level9/45.png"),
                      height: MediaQuery.of(context).size.width / 3,
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
                      image: const AssetImage("assets/level9/54.png"),
                      height: MediaQuery.of(context).size.width / 4,
                      width: MediaQuery.of(context).size.width / 3,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            if (gameOver == true)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                      image: const AssetImage("assets/level9/45.png"),
                      height: MediaQuery.of(context).size.width / 3,
                      width: MediaQuery.of(context).size.width / 3,
                      fit: BoxFit.cover,
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.black26,
                    onTap: () {
                      final player = AudioPlayer();
                      player.play(AssetSource('13.wav'));
                      cans = 30 - sec;
                      correct();
                      int time = cans - ans;
                      updateData(ans, cans, time, error, "نعم", "");
                    },
                    child: Ink.image(
                      image: const AssetImage("assets/level9/54.png"),
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
                      image: const AssetImage("assets/level9/44.png"),
                      height: MediaQuery.of(context).size.width / 4,
                      width: MediaQuery.of(context).size.width / 3,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
          ],
        ),
      )),
    );
  }
}
