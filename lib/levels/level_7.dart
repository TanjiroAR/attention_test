import 'dart:async';
import 'package:attention_test/data/levels_data.dart';
import 'package:attention_test/levels/levels_list.dart';
import 'package:attention_test/levels/widget/custom_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'level_8.dart';
import 'widget/level_details.dart';
import 'package:audioplayers/audioplayers.dart';

class Level7 extends StatefulWidget {
  const Level7({Key? key}) : super(key: key);

  @override
  State<Level7> createState() => _Level7State();
}

class _Level7State extends State<Level7> {
  late Timer _timer;
  late int sec = 30;
  late double fontSize = 50;
  late bool firstAns = true;
  late int cans = 0;
  late int ans = 0;
  late int time=0;
  late int error = 0;
  SqlDb sqlDb = SqlDb();

  updateData(int tofa, int toca, int time, int nerrors, String answer , String note) async{
    await sqlDb.updateData("UPDATE 'data' SET tofa = $tofa,toca = $toca,time = $time, nerrors = $nerrors, answer = '$answer', note = '$note'  WHERE level = 7");

  }

  readData() async{
    List<Map> response = await sqlDb.readData("SELECT * FROM 'data'");
    if (kDebugMode) {
      print("$response");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer();
    setState(() {
      if(sec == 0){
        stop();
      }
    });
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
                function: ()  {
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
                    function: ()  {
                      Get.offAll(() => const Levels());
                      readData();
                      cans = 30 - sec;
                    },
                    buttonText: "القائمة",

                  ),
                  CustomButton(
                    function: ()  {
                      Get.to(() => Details(
                        function: () {
                          Get.to(() => const Shape());
                        },
                        text: "تذكر الناقص من الصورة",
                        assets: "assets/level8/123.jpg",
                        title: "المستوى الثامن",
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
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(sec.toString(), style: TextStyle(fontSize: fontSize)),
          Ink.image(
            image: const AssetImage("assets/level7/2.jpg"),
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  image: const AssetImage("assets/level7/22.jpg"),
                  height: 100,
                  width: 100,
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
                  image: const AssetImage("assets/level7/33.jpg"),
                  height: 100,
                  width: 100,
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
                  image: const AssetImage("assets/level7/3.jpg"),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
