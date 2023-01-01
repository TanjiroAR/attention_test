import 'package:attention_test/levels/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/levels_data.dart';
import 'levels_list.dart';

class FinalScreen extends StatefulWidget {
  const FinalScreen({Key? key}) : super(key: key);

  @override
  State<FinalScreen> createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  SqlDb sqlDb = SqlDb();
  late List<Map> _sum;
  // Future<List<Map>> readData() async {
  //   List<Map> sum = await sqlDb.readData("SELECT SUM(toca) FROM data");
  //   _sum = sum;
  // }
  Future<List<Map>> readData() async {
    List<Map> sum = await sqlDb.readData("SELECT SUM(toca) FROM data");
    _sum = sum;
    return _sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
            onPressed: () {
              Get.offAll(const Levels());
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(': عدد الثواني الكلي',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            FutureBuilder(
                future: readData(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
                  if (snapshot.hasData) {
                    return Text(_sum[0]["SUM(toca)"].toString(),
                        style: const TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold));
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
            // Text(_sum[0]["SUM(toca)"].toString(),style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
            CustomButton(
              function: () {
                Get.offAll(() => const Levels());
              },
              width: MediaQuery.of(context).size.width / 2,
              buttonText: 'القائمة',
            )
          ],
        ),
      ),
    );
  }
}
