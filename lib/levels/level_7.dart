import 'dart:async';
import 'package:attention_test/levels/levels_list.dart';
import 'package:attention_test/levels/widget/custom_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  late int ans = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(sec.toString(), style: TextStyle(fontSize: fontSize)),
          Ink.image(
            image: const AssetImage("assets/12.png"),
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
                  _timer.cancel();
                  if(firstAns == true){firstAns= false;ans = 30 - sec;}
                  if (kDebugMode) {
                    print(ans);
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
                                sec = 31;
                                _timer = Timer.periodic(
                                    const Duration(seconds: 1), (timer) {
                                  setState(() {
                                    if (sec > 0) {
                                      sec--;
                                    } else {
                                      _timer.cancel();
                                    }
                                  });
                                });
                              },
                              buttonText: "حاول مجددا",
                            )
                          ],
                        );
                      });
                },
                child: Ink.image(
                  image: const AssetImage("assets/12.png"),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              InkWell(
                splashColor: Colors.black26,
                onTap: () {
                  _timer.cancel();
                  if(firstAns == true){firstAns= false;ans = 30 - sec;}
                  if (kDebugMode) {
                    print(ans);
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
                                sec = 31;
                                _timer = Timer.periodic(
                                    const Duration(seconds: 1), (timer) {
                                  setState(() {
                                    if (sec > 0) {
                                      sec--;
                                    } else {
                                      _timer.cancel();
                                    }
                                  });
                                });
                              },
                              buttonText: "حاول مجددا",
                            )
                          ],
                        );
                      });
                },
                child: Ink.image(
                  image: const AssetImage("assets/12.png"),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              InkWell(
                splashColor: Colors.black26,
                onTap: () {
                  _timer.cancel();
                  if(firstAns == true){firstAns= false;ans = 30 - sec;}
                  if (kDebugMode) {
                    print(ans);
                  }
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Center(
                            child: Text("أحسنت"),
                          ),
                          actions: [CustomButton(function: () {Get.offAll(()=>const Levels());},buttonText: "تم",sizeTextButton: 30,)],
                        );
                      });
                },
                child: Ink.image(
                  image: const AssetImage("assets/12.png"),
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
// AlertDialog(title: Text("Ahmed"),content: Text("Mohammed")),
