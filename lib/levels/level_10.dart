import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/levels_data.dart';
import 'levels_list.dart';
import 'widget/custom_button.dart';

class Move extends StatefulWidget {
  const Move({Key? key}) : super(key: key);

  @override
  State<Move> createState() => _MoveState();
}

class _MoveState extends State<Move> {
  double t = 0;
  double r = 0;
  late Timer _timer;
  int sec = 30;
  late bool firstAns = true;
  late int cans = 0;
  late int ans = 0;
  late int time = 0;
  late int error = 0;
  late bool top = false;
  late bool right = false;
  SqlDb sqlDb = SqlDb();
  late double fontSize = 50;
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
              CustomButton(
                function: () {
                  Get.offAll(() => const Levels());
                  cans = 30 - sec;
                },
                buttonText: "القائمة",
                width: double.infinity,
              )
            ],
          );
        });
  }

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
        "UPDATE 'data' SET tofa = $tofa,toca = $toca,time = $time, nerrors = $nerrors, answer = '$answer', note = '$note'  WHERE level = 10");
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
                },
                buttonText: "حاول مجددا",
                width: double.infinity,
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
          child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// timer
          Text(
            sec.toString(),
            style: TextStyle(fontSize: fontSize),
          ),

          /// game
          Container(
            height: MediaQuery.of(context).size.width / 0.9,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/level10/par.jpg"),
              fit: BoxFit.fill,
            )),
            child: Stack(
              children: [
                AnimatedPositioned(
                  top: (MediaQuery.of(context).size.width / 2) - t,
                  right: (MediaQuery.of(context).size.width -
                          (MediaQuery.of(context).size.width / 6)) -
                      r,
                  duration: const Duration(milliseconds: 40),
                  child: Image(
                    image: const AssetImage("assets/level10/car.png"),
                    height: MediaQuery.of(context).size.width / 10,
                  ),
                )
              ],
            ),
          ),

          /// controller
          Row(
            children: [
              /// left
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: IconButton(
                  onPressed: () {
                    if (firstAns == true) {
                      firstAns = false;
                      ans = 30 - sec;
                    }
                    setState(() {
                      if (r > 0) {
                        r = r - 10;
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_circle_left_outlined,
                  ),
                  iconSize: MediaQuery.of(context).size.width / 5,
                ),
              ),

              /// up & down
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          /// up
                          IconButton(
                            onPressed: () {
                              if (firstAns == true) {
                                firstAns = false;
                                ans = 30 - sec;
                              }
                              setState(() {
                                if (t <
                                    (MediaQuery.of(context).size.width / 3.8)) {
                                  t = t + 10;
                                }
                              });
                              if(t == 0){
                                top = true;
                              }
                              if (top == true && right == true) {
                                final player = AudioPlayer();
                                player.play(AssetSource('13.wav'));
                                cans = 30 - sec;
                                time = cans - ans;
                                updateData(ans, cans, time, 0, "نعم", "");
                                correct();
                              }
                            },
                            icon: const Icon(
                              Icons.arrow_circle_up_sharp,
                            ),
                            iconSize: MediaQuery.of(context).size.width / 5,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 10,
                          ),

                          /// down
                          IconButton(
                            onPressed: () {
                              if (firstAns == true) {
                                firstAns = false;
                                ans = 30 - sec;
                              }
                              setState(() {
                                if ((-1 * t) <
                                    (MediaQuery.of(context).size.width / 3.8)) {
                                  t = t - 10;
                                }
                              });
                              if(t == 0){
                                top = true;
                              }
                              if (top == true && right == true) {
                                final player = AudioPlayer();
                                player.play(AssetSource('13.wav'));
                                cans = 30 - sec;
                                time = cans - ans;
                                updateData(ans, cans, time, 0, "نعم", "");
                                correct();
                              }
                            },
                            icon: const Icon(
                              Icons.arrow_circle_down_sharp,
                            ),
                            iconSize: MediaQuery.of(context).size.width / 5,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// right
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: IconButton(
                  onPressed: () {
                    if (firstAns == true) {
                      firstAns = false;
                      ans = 30 - sec;
                    }
                    setState(() {
                      if (r <
                          (MediaQuery.of(context).size.width -
                              (MediaQuery.of(context).size.width / 4.7))) {
                        r = r + 10;
                      }
                    });
                    if(r >= (MediaQuery.of(context).size.width -
                        (MediaQuery.of(context).size.width / 4.7))){
                      right = true;
                    }
                    if (t==0 && right == true) {
                      final player = AudioPlayer();
                      player.play(AssetSource('13.wav'));
                      cans = 30 - sec;
                      time = cans - ans;
                      updateData(ans, cans, time, 0, "نعم", "");
                      correct();
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_circle_right_outlined,
                  ),
                  iconSize: MediaQuery.of(context).size.width / 5,
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
