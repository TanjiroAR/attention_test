import 'package:attention_test/levels/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import 'model.dart';

class Print extends StatefulWidget {
  const Print({Key? key}) : super(key: key);

  @override
  State<Print> createState() => _PrintState();
}

class _PrintState extends State<Print> {
  int _value = 1;
  late String gen = "male";
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
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
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
                  _date.text =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
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
                          gen = "Male";
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
                          gen = "Female";
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
              _displayPdf();
            },
            width: double.infinity,
            buttonText: "تم",
          )
            ],
          ),
        ),
      ),
    );
  }

  void _createPdf() async {
    final doc = pw.Document();

    /// for using an image from assets
    // final image = await imageFromAssetBundle('assets/image.png');

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Row(children: [
              pw.Text("Ahmed"),
            ])
          ]);
          //   pw.Center(
          //   child: pw.Text('Hello world'),
          // ); // Center
        },
      ),
    ); // Page

    /// print the document using the iOS or Android print service:
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());

    /// share the document to other applications:
    // await Printing.sharePdf(bytes: await doc.save(), filename: 'my-document.pdf');

    /// tutorial for using path_provider: https://www.youtube.com/watch?v=fJtFDrjEvE8
    /// save PDF with Flutter library "path_provider":
    // final output = await getTemporaryDirectory();
    // final file = File('${output.path}/example.pdf');
    // await file.writeAsBytes(await doc.save());
  }

  /// display a pdf document.
  void _displayPdf() {
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
              children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                    children: [
                      pw.Text(
                        'mame:',
                        style: const pw.TextStyle(fontSize: 30),
                      ),
                      pw.Text(
                        _name.text,
                        style: const pw.TextStyle(fontSize: 30),
                      ),
                    ]),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                    children: [
                      pw.Text(
                        'Date of Birth:',
                        style: const pw.TextStyle(fontSize: 30),
                      ),
                      pw.Text(
                        _date.text,
                        style: const pw.TextStyle(fontSize: 30),
                      ),
                    ]),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                    children: [
                      pw.Text(
                        'Examination date:',
                        style: const pw.TextStyle(fontSize: 30),
                      ),
                      pw.Text(
                        _dateNow.text,
                        style: const pw.TextStyle(fontSize: 30),
                      ),
                    ]),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                    children: [
                      pw.Text(
                        'Gender:',
                        style: const pw.TextStyle(fontSize: 30),
                      ),
                      pw.Text(
                        gen,
                        style: const pw.TextStyle(fontSize: 30),
                      ),
                    ]),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                    children: [
                      pw.Text(
                        'Classroom:',
                        style: const pw.TextStyle(fontSize: 30),
                      ),
                      pw.Text(
                        _classroom.text,
                        style: const pw.TextStyle(fontSize: 30),
                      ),
                    ]),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                    children: [
                      pw.Text(
                        'school/city:',
                        style: const pw.TextStyle(fontSize: 30),
                      ),
                      pw.Text(
                        _school.text,
                        style: const pw.TextStyle(fontSize: 30),
                      ),
                    ]),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                    children: [
                      pw.Text('Diagnosis:',
                        style: const pw.TextStyle(fontSize: 30),),
                      pw.Text(
                        _diagnosis.text,
                        style: const pw.TextStyle(fontSize: 30),
                      ),
                    ]
                ),
              ]);
        },
      ),
    );

    /// open Preview Screen
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewScreen(doc: doc),
        ));
  }
}


