import 'package:attention_test/model.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../data/levels_data.dart';
import 'dart:math';
void generateAndPrintArabicPdf(BuildContext context ,String name,String date,String dateNow,String gen,String classroom,String school,String diagnosis,) async {
  SqlDb sqlDb = SqlDb();
  List<Map> response = await sqlDb.readData("SELECT tofa,nerrors,toca FROM data");
  final Document pdf = Document();
  var arabicFont = Font.ttf(await rootBundle.load("assets/arabic.ttf"));
  pdf.addPage(Page(
      theme: ThemeData.withFont(
        base: arabicFont,
      ),
      pageFormat: PdfPageFormat.roll80,
      build: (Context context) {
        return Center(
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    '''         ${name.toString()}''', style: const TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text('اسم المتدرب : ', style: const TextStyle(
                                  fontSize: 10,
                                ))
                            ),
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    '''${date.toString()}           ''', style: const TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text('تاريخ ميلاده : ', style: const TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    '''${dateNow.toString()}           ''', style: const TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text('تاريخ الفحص : ', style: const TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                      ]
                  ),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    '''         ${gen.toString()}''', style: const TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text('الجنس ذكر / انثى : ', style: const TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    '''         ${classroom.toString()}''', style: const TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text('الصف الدراسى : ', style: const TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    '''         ${school.toString()}''', style: const TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text('المدرسة/ المركز : ', style: const TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                      ]
                  ),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    '''         ${diagnosis.toString()}''', style: const TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text('التشخيص : ', style: const TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                      ]
                  ),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    '''${(Random().nextInt(88888888)+10000000).toString()}           ''', style: const TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text('الرقم التسلسلي : ', style: const TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                      ]
                  ),
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text('الاحصائيات' , style: const TextStyle(
                          fontSize: 10,
                        color: PdfColors.red,
                      ))
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(22, 5, 22, 5),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Table.fromTextArray(
                        headerStyle: const TextStyle(
                            fontSize: 6
                        ),
                        headers: <dynamic>['زمن الاستجابة الاولى', 'عدد الاخطاء' ,'عدد الثواني', 'المستوى'],
                        cellAlignment: Alignment.center,
                        cellStyle: const TextStyle(
                            fontSize: 5
                        ),
                        data:
                        <List<dynamic>>[
                          ['${response[0]['tofa']}', '${response[0]['nerrors']}' ,'${response[0]['toca']}', 'الاول' ],
                          ['${response[1]['tofa']}', '${response[1]['nerrors']}' ,'${response[1]['toca']}', 'الثاني' ],
                          ['${response[2]['tofa']}', '${response[2]['nerrors']}' ,'${response[2]['toca']}', 'الثالث' ],
                          ['${response[3]['tofa']}', '${response[3]['nerrors']}' ,'${response[3]['toca']}', 'الرابع' ],
                          ['${response[4]['tofa']}', '${response[4]['nerrors']}' ,'${response[4]['toca']}', 'الخامس' ],
                          ['${response[5]['tofa']}', '${response[5]['nerrors']}' ,'${response[5]['toca']}', 'السادس' ],
                          ['${response[6]['tofa']}', '${response[6]['nerrors']}' ,'${response[6]['toca']}', 'السابع' ],
                          ['${response[7]['tofa']}', '${response[7]['nerrors']}' ,'${response[7]['toca']}', 'الثامن' ],
                          ['${response[8]['tofa']}', '${response[8]['nerrors']}' ,'${response[8]['toca']}', 'التاسع' ],
                          ['${response[9]['tofa']}', '${response[9]['nerrors']}' ,'${response[9]['toca']}', 'العاشر' ],
                        ],
                      ),
                    ),
                  ),
                ]
            )
        );
      }
  ));
  Get.to(PreviewScreen(doc: pdf,));
}