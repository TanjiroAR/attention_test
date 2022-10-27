import 'package:attention_test/data/levels_data.dart';
import 'package:attention_test/levels/details.dart';
import 'package:attention_test/levels/level_2.dart';
import 'package:attention_test/levels/level_7.dart';
import 'package:attention_test/levels/level_1.dart';
import 'package:attention_test/levels/widget/level_details.dart';
import 'package:attention_test/levels/widget/lists.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Levels extends StatefulWidget {
  const Levels({Key? key}) : super(key: key);

  @override
  State<Levels> createState() => _LevelsState();
}

class _LevelsState extends State<Levels> {
  SqlDb sqlDb = SqlDb();
  createData(int level, int tofa, int toca, int time, int nerrors,
      String answer, String note) async {
    await sqlDb.insertData(
        "INSERT INTO 'data'(level, tofa , toca, time, nerrors, answer, note) VALUES($level,$tofa,$toca,$time,$nerrors,'$answer','$note')");
  }

  check() async {
    List response = await sqlDb.readData("SELECT * FROM 'data'");
    if (response.isEmpty == true) {
      createData(1, 0, 0, 0, 0, "لا", "");
      createData(2, 0, 0, 0, 0, "لا", "");
      createData(3, 0, 0, 0, 0, "لا", "");
      createData(4, 0, 0, 0, 0, "لا", "");
      createData(5, 0, 0, 0, 0, "لا", "");
      createData(6, 0, 0, 0, 0, "لا", "");
      createData(7, 0, 0, 0, 0, "لا", "");
      createData(8, 0, 0, 0, 0, "لا", "");
      createData(9, 0, 0, 0, 0, "لا", "");
      createData(10, 0, 0, 0, 0, "لا", "");
    }

    if (kDebugMode) {
      print("$response");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Level(
            assets: "assets/000.png",
              function: () {
                Get.to(() => const Data());
              },
              text2: "فهرس المستويات "),

          //#########################################################################################
          // level 1
          Level(
              function: () {
                Get.to(() => Details(
                      function: () {
                        Get.to(const Light());
                      },
                      text:
                          "الانتباه دون انزعاج عندما يتعرض لضوء منخفض و ترتفع شدة الاضاءة بمرور 30 ثانية",
                      assets: "assets/level1/011.png",
                    ));
              },
              assets: "assets/level1/011.png",
              text1: 'المستوى الاول',
              text2: 'مستوى الحساسية للضوء'),
          //#################################################################################

          //level 2
          Level(
              function: () {
                Get.to(() => Details(
                      function: () {
                        Get.to(const Star());
                      },
                      text:
                          "الانتباه البصري الأول لنجم مضئ متحرك يظهر ثم تختفى فى اماكن مختلفة من الشاشة على خلفية مظلمة لمدة 30 ثانية ( ثلاث مرات فى كل مرة 10 ثوانى ) ",
                      assets: "assets/level2/18.png",
                    ));
              },
              assets: "assets/level2/18.png",
              text1: 'المستوى الثاتي',
              text2: 'بداية الاستقبال البصري'),
          //#################################################################################

          // level 3
          Level(
              function: () {
                Get.to(() => Details(
                      function: () {},
                      text:
                          "استمرار الانتباه البصري لسيارة تسير بسرعة ثم تتوقف فجأة و تتكرر(6) مرات متتالية .",
                      assets: "assets/level3/15.png",
                    ));
              },
              assets: "assets/level3/15.png",
              text1: 'المستوى الثالث',
              text2: 'طول مدة استمرار الانتباه البصري للعلاقات المكانية'),
          //#################################################################################

          // level 4
          Level(
              function: () {
                Get.to(() => Details(
                      function: () {},
                      text:
                          "استمرار الإدراك البصري لمتابعة ظهور بلونة صغيرة لونها احمر ثم تبدأ يزيد حجمها بالتدريج ومحاولة تفجيرها لمدة30 ثانية. ",
                      assets: "assets/level4/13.png",
                    ));
              },
              assets: "assets/level4/13.png",
              text1: 'المستوى الرابع',
              text2: 'طول مدة استمرار الإدراك البصري'),
          //#################################################################################

          // level 5
          Level(
              function: () {
                Get.to(() => Details(
                      function: () {},
                      text: "مطابقة دائرة ملونة لأخرى بنفس اللون",
                      assets: "assets/level5/16.png",
                    ));
              },
              assets: "assets/level5/16.png",
              text1: 'المستوى الخامس',
              text2: 'مضاهاة الأشكال'),
          //#################################################################################

          // level 6
          Level(
              function: () {
                Get.to(() => Details(
                      function: () {},
                      text: "استخراج ( 3) اختلافات",
                      assets: "assets/level6/1.png",
                    ));
              },
              assets: "assets/level6/1.png",
              text1: 'المستوى السادس',
              text2: 'التمييز البصري'),
          //#################################################################################

          // level 7
          Level(
              function: () {
                Get.to(() => Details(
                      function: () {
                        Get.to(() => const Level7());
                      },
                      assets: "assets/level7/2.jpg",
                      text:
                          // "إكمال الشكل بوضع الدائرة الملونة مع الكوب الملون بنفس اللون "
                          "إكمال الجزء الثانى من الولد",
                    ));
              },
              assets: "assets/level7/00.jpg",
              text1: 'المستوى السابع',
              text2: 'الإغلاق البصري'),
          //#################################################################################

          // level 8
          Level(
              function: () {
                Get.to(() => Details(
                      function: () {},
                      text: "تذكر الناقص من الصورة",
                      assets: "assets/level8/1.png",
                    ));
              },
              assets: "assets/level8/1.png",
              text1: 'المستوى الثامن',
              text2: 'الذاكرة البصرية'),
          //#################################################################################

          // level 9
          Level(
              function: () {
                Get.to(() => Details(
                      function: () {},
                      text: "اضغط على اكبر تفاحة و اضغط على اصغر تفاحة",
                      assets: "assets/level9/1.png",
                    ));
              },
              assets: "assets/level9/1.png",
              text1: 'المستوى التاسع',
              text2: 'مرونة الانتقال البصري الحركي'),
          //#################################################################################

          // level 10
          Level(
              function: () {},
              text1: 'المستوى العاشر',
              text2: 'مرونة التآزر البصري الحركي'),
          //#################################################################################
        ],
      ),
    );
  }
}
// Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(function: (){})));
