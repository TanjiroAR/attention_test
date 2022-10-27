import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../data/levels_data.dart';
import 'levels_list.dart';
import 'widget/custom_button.dart';

class Star extends StatefulWidget {
  const Star({Key? key}) : super(key: key);

  @override
  State<Star> createState() => _StarState();
}

class _StarState extends State<Star> {
  late Timer _timer;
  late int sec = 30;
  late double fontSize = 50;
  bool a = false;
  late String text1="ابدء";
  late int cans = 0;
  late int ans = 0;
  late int time=0;
  late int error = 0;
  SqlDb sqlDb = SqlDb();
  updateData(int tofa, int toca, int time, int nerrors, String answer , String note) async{
    // await sqlDb.updateData("UPDATE 'data' SET tofa = 0 WHERE level = $level");
    // await sqlDb.updateData("UPDATE 'data' SET toca = 0 WHERE level = $level");
    // await sqlDb.updateData("UPDATE 'data' SET time = 0 WHERE level = $level");
    // await sqlDb.updateData("UPDATE 'data' SET nerrors = 0 WHERE level = $level");
    // await sqlDb.updateData("UPDATE 'data' SET answer = 'لا' WHERE level = $level");
    // await sqlDb.updateData("UPDATE 'data' SET note = '' WHERE level = $level");
    await sqlDb.updateData("UPDATE 'data' SET tofa = $tofa,toca = $toca,time = $time, nerrors = $nerrors, answer = '$answer', note = '$note'  WHERE level = 2");

  }
  timer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (sec > 0) {
          sec--;
        } else {
          _timer.cancel();
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
                      Get.offAll(() => const Levels());
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
                  "assets/level2/star.json",
                  animate: a,
                ),
              ),
            ),
            CustomButton(function: (){
              if(a == false){
                timer();
                setState(() {
                  a = true;
                  text1 = "توقف";
                });

              }else{
                _timer.cancel();
                cans = 30 - sec;
                ans = 30 - sec;
                int time = cans - ans;
                updateData(ans, cans, time, error, "نعم", "");
                correct();
              }
            },buttonText: text1,width: double.infinity,),
          ],
        ),
      )),
    );
  }
}
