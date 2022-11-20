import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/levels_data.dart';
import 'level_5.dart';
import 'levels_list.dart';
import 'widget/custom_button.dart';
import 'widget/level_details.dart';

class Balloon extends StatefulWidget {
  const Balloon({Key? key}) : super(key: key);

  @override
  State<Balloon> createState() => _BalloonState();
}

class _BalloonState extends State<Balloon> {
  late Timer _timer;
  late int sec = 30;
  late double fontSize = 50;
  bool a = false;
  late double top;
  late double r;
  bool isVisible = false;
  late String text1 = "ابدء";
  late int cans = 0;
  late int ans = 0;
  late int time = 0;
  late int error = 0;
  SqlDb sqlDb = SqlDb();
  updateData(int tofa, int toca, int time, int nerrors, String answer,
      String note) async {
    await sqlDb.updateData(
        "UPDATE 'data' SET tofa = $tofa,toca = $toca,time = $time, nerrors = $nerrors, answer = '$answer', note = '$note'  WHERE level = 4");
  }

  timer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if(sec == 30 && isVisible == false){
          top = 0;
          r = 0;
        }else if(sec == 25 && isVisible == false){
          top = MediaQuery.of(context).size.height * (4/7);
          r = 0;
        }else if(sec == 20 && isVisible == false){
          top = 0;
          r = MediaQuery.of(context).size.width* (3/4);
        }else if(sec == 15 && isVisible == false){
          top = MediaQuery.of(context).size.height * (4/7);
          r = MediaQuery.of(context).size.width* (3/4);
        }else if(sec == 10 && isVisible == false){
          top = 0;
          r = 0;
        }else if(sec == 5 && isVisible == false){
          top = MediaQuery.of(context).size.height * (4/7);
          r = 0;
        }
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
                              Get.to(const Circle());
                            },
                            text: "مطابقة دائرة ملونة لأخرى بنفس اللون",
                            assets: "assets/level5/xa.jpg",
                            title: "المستوى الخامس",
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
    if(sec == 30){
      top = MediaQuery.of(context).size.height * (4/7);
      r = MediaQuery.of(context).size.width* (3/4);
    }
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            sec.toString(),
            style: TextStyle(fontSize: fontSize),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * (3/4),
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                AnimatedPositioned(
                  duration: const Duration(seconds: 5),
                  top: top,
                  right: r,
                  child: TextButton(
                    onPressed: () {
                      final player = AudioPlayer();
                      player.play(AssetSource('13.wav'));
                      _timer.cancel();
                      setState(() {
                        isVisible = !isVisible;
                      });
                      cans = 30 - sec;
                      ans = 30 - sec;
                      int time = cans - ans;
                      updateData(ans, cans, time, error, "نعم", "");
                      correct();
                    },
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Ink.image(
                        image: const AssetImage('assets/level4/balloon.png'),
                        child: Visibility(
                          visible: isVisible,
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          child: Image.asset("assets/level4/balloonp.jpg"),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          // CustomButton(
          //   function: () {
          //     if (a == false) {
          //       a = true;
          //       timer();
          //       setState(() {
          //         top = 0;
          //         r = 0;
          //         text1 = "توقف";
          //       });
          //     }
          //   },
          //   buttonText: text1,
          //   width: double.infinity,
          // ),
        ],
      )),
    );
  }
}
