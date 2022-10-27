import 'package:attention_test/data/levels_data.dart';
import 'package:attention_test/levels/levels_list.dart';
import 'package:attention_test/levels/widget/custom_button.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb sqlDb = SqlDb();
  createData(int level, int tofa, int toca, int time, int nerrors,
      String answer, String note) async {
    await sqlDb.insertData(
        "INSERT INTO 'data'(level, tofa , toca, time, nerrors, answer, note) VALUES($level,$tofa,$toca,$time,$nerrors,'$answer','$note')");
  }
  deleteData() async{
    int response = await sqlDb.deleteData("DELETE  FROM 'data'");
    if (kDebugMode) {
      print("$response");
    }
  }
  readData() async{
    List<Map> response= await sqlDb.readData("SELECT * FROM 'data'");
    if (kDebugMode) {
      print("$response");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Text(
            "لنبدأ",
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          CustomButton(function: () {
            Get.to(() => const Levels());
            // createData(1, 0, 0, 0, 0, "لا", "");
            // createData(2, 0, 0, 0, 0, "لا", "");
            // createData(3, 0, 0, 0, 0, "لا", "");
            // createData(4, 0, 0, 0, 0, "لا", "");
            // createData(5, 0, 0, 0, 0, "لا", "");
            // createData(6, 0, 0, 0, 0, "لا", "");
            // createData(7, 0, 0, 0, 0, "لا", "");
            // createData(8, 0, 0, 0, 0, "لا", "");
            // createData(9, 0, 0, 0, 0, "لا", "");
            // createData(10, 0, 0, 0, 0, "لا", "");
            // deleteData();
            // readData();
          })
        ],
      ),
    );
  }
}
