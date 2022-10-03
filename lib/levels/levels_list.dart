import 'package:attention_test/levels/details.dart';
import 'package:attention_test/levels/level_7.dart';
import 'package:attention_test/levels/widget/level_details.dart';
import 'package:attention_test/levels/widget/lists.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Levels extends StatefulWidget {
  const Levels({Key? key}) : super(key: key);

  @override
  State<Levels> createState() => _LevelsState();
}

class _LevelsState extends State<Levels> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Level(function: (){Get.to(()=> const Data());},text1: "تفاصيل المستويات"),


          //#########################################################################################
          // level 1
          Level(
              function: () {
                Get.to(() => Details(
                      function: () {},
                      text:
                          "الانتباه دون انزعاج عندما يتعرض لضوء منخفض و ترتفع شدة الاضاءة بمرور 30 ثانية",
                    ));
              },
              text1: 'المستوى الاول',
              text2: 'مستوى الحساسية للضوء'),
          //#################################################################################

          //level 2
          Level(
              function: () {
                Get.to(() => Details(
                      function: () {},
                      text:
                          "الانتباه البصري الأول لنجم مضئ متحرك يظهر ثم تختفى فى اماكن مختلفة من الشاشة على خلفية مظلمة لمدة 30 ثانية ( ثلاث مرات فى كل مرة 10 ثوانى ) ",
                    ));
              },
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
                    ));
              },
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
                    ));
              },
              text1: 'المستوى الرابع',
              text2: 'طول مدة استمرار الإدراك البصري'),
          //#################################################################################

          // level 5
          Level(
              function: () {
                Get.to(() => Details(
                      function: () {},
                      text: "مطابقة دائرة ملونة لأخرى بنفس اللون",
                    ));
              },
              text1: 'المستوى الخامس',
              text2: 'مضاهاة الأشكال'),
          //#################################################################################

          // level 6
          Level(
              function: () {
                Get.to(() => Details(
                      function: () {},
                      text: "استخراج ( 3) اختلافات",
                    ));
              },
              text1: 'المستوى السادس',
              text2: 'التمييز البصري'),
          //#################################################################################

          // level 7
          Level(
              function: () {
                Get.to(() => Details(
                      function: () {Get.to(()=>Level7());},
                      text:
                          "إكمال الشكل بوضع الدائرة الملونة مع الكوب الملون بنفس اللون "
                          "-إكمال الجزء الثانى من الولد",
                    ));
              },
              text1: 'المستوى السابع',
              text2: 'الإغلاق البصري'),
          //#################################################################################

          // level 8
          Level(
              function: () {
                Get.to(() => Details(
                      function: () {},
                      text: "تذكر الناقص من الصورة",
                    ));
              },
              text1: 'المستوى الثامن',
              text2: 'الذاكرة البصرية'),
          //#################################################################################

          // level 9
          Level(
              function: () {
                Get.to(() => Details(
                      function: () {},
                      text: "اضغط على اكبر تفاحة و اضغط على اصغر تفاحة",
                    ));
              },
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
