import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/levels_data.dart';
import 'level_6.dart';
import 'levels_list.dart';
import 'widget/custom_button.dart';
import 'widget/level_details.dart';

class Circle extends StatefulWidget {
  const Circle({Key? key}) : super(key: key);

  @override
  State<Circle> createState() => _CircleState();
}

class _CircleState extends State<Circle> {
  late List<ItemModel> items;
  late List<ItemModel> items2;
  late bool gameOver;
  bool firstAns = false;
  late int ans = 0;
  late int errors = 0;
  int sec = 30;
  late Timer _timer;
  late double fontSize = 50;
  initGame() {
    gameOver = false;
    items = [
      ItemModel(value: 'احمر', name: 'احمر', img: 'assets/level5/r.png'),
      ItemModel(value: 'اخضر', name: 'اخضر', img: 'assets/level5/g.png'),
      ItemModel(value: 'اصفر', name: 'اصفر', img: 'assets/level5/y.png'),
    ];
    items2 = List<ItemModel>.from(items);
    items.shuffle();
    items2.shuffle();
  }

  stop() {
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

  firstA() {
    if (firstAns == false) {
      firstAns = true;
      ans = 30 - sec;
    }
    return ans;
  }

  SqlDb sqlDb = SqlDb();
  updateData(int tofa, int toca, int time, int nerrors, String answer,
      String note) async {
    await sqlDb.updateData(
        "UPDATE 'data' SET tofa = $tofa,toca = $toca,time = $time, nerrors = $nerrors, answer = '$answer', note = '$note'  WHERE level = 5");
  }

  timer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (sec > 0) {
          sec--;
        } else {
          _timer.cancel();
          updateData(ans, 0, 30, errors, "لا", "");
          stop();
          final player = AudioPlayer();
          player.play(AssetSource('11.wav'));
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initGame();
    timer();
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      final player = AudioPlayer();
      player.play(AssetSource('13.wav'));
      int toca = 30 - sec;
      int time = toca - ans;
      updateData(ans, toca, time, errors, "نعم", "");
      _timer.cancel();
      gameOver = true;
    }
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            sec.toString(),
            style: TextStyle(fontSize: fontSize),
          ),
          if (!gameOver)
            Row(
              children: [
                const Spacer(),
                Column(
                  children: items.map((item) {
                    return Container(
                      margin: const EdgeInsets.all(8),
                      child: Draggable<ItemModel>(
                        data: item,
                        childWhenDragging: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(item.img),
                          radius: 50,
                        ),
                        feedback: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(item.img),
                          radius: 30,
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(item.img),
                          radius: 30,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const Spacer(flex: 2),
                Column(
                  children: items2.map((item) {
                    return DragTarget<ItemModel>(
                      onAccept: (receivedItem) {
                        if (item.value == receivedItem.value) {
                          final player = AudioPlayer();
                          player.play(AssetSource('12.wav'));
                          setState(() {
                            firstA();
                            items.remove(receivedItem);
                            items2.remove(item);
                          });
                          item.accepting = false;
                        } else {
                          setState(() {
                            firstA();
                            errors++;
                            if (errors == 5) {
                              final player = AudioPlayer();
                              player.play(AssetSource('11.wav'));
                              updateData(ans, 0, 30, errors, "لا", "");
                              _timer.cancel();
                              stop();
                            }
                            item.accepting = false;
                          });
                        }
                      },
                      onWillAccept: (receivedItem) {
                        setState(() {
                          item.accepting = true;
                        });
                        return true;
                      },
                      onLeave: (receivedItem) {
                        setState(() {
                          item.accepting = false;
                        });
                      },
                      builder: (context, acceptedItems, rejectedItems) =>
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: item.accepting
                                    ? Colors.grey[400]
                                    : Colors.grey[200],
                              ),
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.width / 6.5,
                              width: MediaQuery.of(context).size.width / 3,
                              margin: const EdgeInsets.all(8),
                              child: Image.asset(item.img)),
                    );
                  }).toList(),
                ),
                const Spacer(),
              ],
            ),
          if (gameOver)
            Text(
              "احسنت",
              style: TextStyle(fontSize: fontSize),
            ),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.width / 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                      function: () {
                        Get.offAll(() => const Levels());
                      },
                      buttonText: "القائمة"),
                  CustomButton(
                    function: () {
                      Get.to(() => Details(
                        function: () {
                          Get.to(const Change());
                        },
                        text: "استخراج ( 3) اختلافات",
                        assets: "assets/level6/66.png",
                        title: "المستوى السادس",
                      ));
                    },
                    buttonText: "المستوى التالي",
                  ),

                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class ItemModel {
  final String name;
  final String img;
  final String value;
  bool accepting;
  ItemModel(
      {required this.name,
      required this.value,
      required this.img,
      this.accepting = false});
}
