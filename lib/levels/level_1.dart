import 'dart:async';

import 'package:attention_test/levels/level_2.dart';
import 'package:attention_test/levels/widget/custom_button.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/levels_data.dart';
import 'levels_list.dart';
import 'widget/level_details.dart';

class Light extends StatefulWidget {
  const Light({Key? key}) : super(key: key);

  @override
  State<Light> createState() => _LightState();
}

class _LightState extends State<Light> {
  late Timer _timer;
  late int sec = 30;
  late double fontSize = 50;
  // late bool mm = false;
  late String text1 = "ابدء";
  double op = 1;
  double he = 100;
  double wi = 100;
  late int cans = 0;
  late int ans = 0;
  late int time = 0;
  late int error = 0;
  SqlDb sqlDb = SqlDb();
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
                      Get.offAll(() => Details(
                            function: () {
                              Get.to(const Star());
                            },
                            text:
                                "الانتباه البصري الأول لنجم مضئ متحرك يظهر ثم تختفى فى اماكن مختلفة من الشاشة على خلفية مظلمة لمدة 30 ثانية",
                            assets: "assets/level2/18.png",
                            title: "المستوى الثاني",
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

  updateData(int tofa, int toca, int time, int nerrors, String answer,
      String note) async {
    await sqlDb.updateData(
        "UPDATE 'data' SET tofa = $tofa,toca = $toca,time = $time, nerrors = $nerrors, answer = '$answer', note = '$note'  WHERE level = 1");
  }

  timer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (sec == 30) {
          op = 1;
          he = MediaQuery.of(context).size.width * 1.5;
          wi = MediaQuery.of(context).size.width;
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
      appBar: null,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(sec.toString(),
                  style: TextStyle(fontSize: fontSize, color: Colors.white)),
              TextButton(
                onPressed: () {
                  final player = AudioPlayer();
                  player.play(AssetSource('13.wav'));
                  _timer.cancel();
                  cans = 30 - sec;
                  ans = 30 - sec;
                  int time = cans - ans;
                  updateData(ans, cans, time, error, "نعم", "");
                  correct();
                },
                child: AnimatedOpacity(
                    duration: const Duration(seconds: 30),
                    opacity: op,
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 30),
                      height: he,
                      width: wi,
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        "assets/level1/22b.png",
                        fit: BoxFit.fill,
                      ),
                    )),
              ),
              // CustomButton(function: (){
              //   if(mm == false){
              //     timer();
              //     setState(() {
              //       op = 1;
              //       he = 400;
              //       wi = 300;
              //       mm = true;
              //       text1 = "توقف";
              //     });
              //
              //   }else{
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
        ),
      ),
    );
  }
}
