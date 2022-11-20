import 'package:attention_test/levels/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/levels_data.dart';
import 'custom_print.dart';

class Print extends StatefulWidget {
  const Print({Key? key}) : super(key: key);

  @override
  State<Print> createState() => _PrintState();
}

class _PrintState extends State<Print> {
  SqlDb sqlDb = SqlDb();
  readData() async {
    List<Map> response =
        await sqlDb.readData("SELECT toca,nerrors,time FROM data");
    print(response);
    return response;
  }

  int _value = 1;
  late String gen = "ذكر";
  // bool ger = false;
  final TextEditingController _date = TextEditingController();
  final TextEditingController _dateNow = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _classroom = TextEditingController();
  final TextEditingController _school = TextEditingController();
  final TextEditingController _diagnosis = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: ListView(
            children: [
              TextFormField(
                maxLength: 20,
                controller: _name,
                decoration: InputDecoration(
                    labelText: "اسم المتدرب",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              TextFormField(
                maxLength: 10,
                controller: _date,
                decoration: InputDecoration(
                    labelText: "تاريخ الميلاد",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101));
                  if (pickedDate != null) {
                    setState(() {
                      _date.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                    });
                  }
                },
              ),
              TextFormField(
                maxLength: 10,
                controller: _dateNow,

                // controller: _date,
                decoration: InputDecoration(
                    prefix: IconButton(
                        onPressed: () {
                          _dateNow.text =
                              DateFormat('yyyy-MM-dd').format(DateTime.now());
                        },
                        icon: const Icon(Icons.date_range)),
                    labelText: "تاريخ الفحص",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      const Text("ذكر"),
                      Radio(
                          value: 1,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              gen = "ذكر";
                            });
                          })
                    ],
                  ),
                  Row(
                    children: [
                      const Text("انثى"),
                      Radio(
                          value: 2,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              gen = "انثى";
                            });
                          })
                    ],
                  ),
                ],
              ),
              TextFormField(
                maxLength: 50,
                controller: _classroom,
                decoration: InputDecoration(
                    labelText: "الصف الدراسى",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              TextFormField(
                maxLength: 50,
                controller: _school,
                decoration: InputDecoration(
                    labelText: "المدرسة/ المركز",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              TextFormField(
                maxLength: 50,
                controller: _diagnosis,
                decoration: InputDecoration(
                    labelText: "التشخيص",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              CustomButton(
                function: () {
                  // _displayPdf();
                  // readData();
                  return generateAndPrintArabicPdf(context,_name.text,_date.text,_dateNow.text,gen,_classroom.text,_school.text,_diagnosis.text,);
                },
                width: double.infinity,
                buttonText: "تم",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
