import 'package:attention_test/levels/widget/custom_button.dart';
import 'package:flutter/material.dart';
import '../data/levels_data.dart';

class Data extends StatefulWidget {
  const Data({Key? key}) : super(key: key);
  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  SqlDb sqlDb = SqlDb();
  Future<List<Map>> readData() async{
    List<Map> response = await sqlDb.readData("SELECT * FROM data");
    return response;
  }
  updateData(int level) async{
    await sqlDb.updateData("UPDATE 'data' SET tofa = 0,toca = 0,time = 0, nerrors = 0, answer = 'لا', note = ''  WHERE level = $level");

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("تفاصيل كل مستوى")),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 570,
            child: FutureBuilder(future: readData(),builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
              if(snapshot.hasData){
                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    DataTable(columns: const[
                      DataColumn(label: Text("")),
                      DataColumn(label: Text("المستوى")),
                      DataColumn(label: Text("زمن اول اجابة")),
                      DataColumn(label: Text("زمن الاجابة الصحيحة")),
                      DataColumn(label: Text("الفارق الزمني")),
                      DataColumn(label: Text("عدد الاخطاء")),
                      DataColumn(label: Text("تمت الاجابة")),
                      DataColumn(label: Text("ملاحظة")),
                    ], rows: [
                      DataRow(selected: true,cells: [
                        DataCell(IconButton(onPressed: (){
                          setState(() {
                            updateData(1);
                          });
                        }, icon: const Icon(Icons.delete))),
                        DataCell(Text("${snapshot.data![0]["level"]}")),
                        DataCell(Text("ثانية${snapshot.data![0]["tofa"]}")),
                        DataCell(Text("ثانية${snapshot.data![0]["toca"]}")),
                        DataCell(Text("ثانية${snapshot.data![0]["time"]}")),
                        DataCell(Text("${snapshot.data![0]["nerrors"]}")),
                        DataCell(Text("${snapshot.data![0]["answer"]}")),
                        DataCell(Text("${snapshot.data![0]["note"]}")),

                      ]),
                      DataRow(cells: [
                        DataCell(IconButton(onPressed: (){
                          setState(() {
                            updateData(2);
                          });
                        }, icon: const Icon(Icons.delete))),
                        DataCell(Text("${snapshot.data![1]["level"]}")),
                        DataCell(Text("ثانية${snapshot.data![1]["tofa"]}")),
                        DataCell(Text("ثانية${snapshot.data![1]["toca"]}")),
                        DataCell(Text("ثانية${snapshot.data![1]["time"]}")),
                        DataCell(Text("${snapshot.data![1]["nerrors"]}")),
                        DataCell(Text("${snapshot.data![1]["answer"]}")),
                        DataCell(Text("${snapshot.data![1]["note"]}")),

                      ]),
                      DataRow(selected: true,cells: [
                        DataCell(IconButton(onPressed: (){
                          setState(() {
                            updateData(3);
                          });
                        }, icon: const Icon(Icons.delete))),
                        DataCell(Text("${snapshot.data![2]["level"]}")),
                        DataCell(Text("ثانية${snapshot.data![2]["tofa"]}")),
                        DataCell(Text("ثانية${snapshot.data![2]["toca"]}")),
                        DataCell(Text("ثانية${snapshot.data![2]["time"]}")),
                        DataCell(Text("${snapshot.data![2]["nerrors"]}")),
                        DataCell(Text("${snapshot.data![2]["answer"]}")),
                        DataCell(Text("${snapshot.data![2]["note"]}")),

                      ]),
                      DataRow(cells: [
                        DataCell(IconButton(onPressed: (){
                          setState(() {
                            updateData(4);
                          });
                        }, icon: const Icon(Icons.delete))),
                        DataCell(Text("${snapshot.data![3]["level"]}")),
                        DataCell(Text("ثانية${snapshot.data![3]["tofa"]}")),
                        DataCell(Text("ثانية${snapshot.data![3]["toca"]}")),
                        DataCell(Text("ثانية${snapshot.data![3]["time"]}")),
                        DataCell(Text("${snapshot.data![3]["nerrors"]}")),
                        DataCell(Text("${snapshot.data![3]["answer"]}")),
                        DataCell(Text("${snapshot.data![3]["note"]}")),

                      ]),
                      DataRow(selected: true,cells: [
                        DataCell(IconButton(onPressed: (){
                          setState(() {
                            updateData(5);
                          });
                        }, icon: const Icon(Icons.delete))),
                        DataCell(Text("${snapshot.data![4]["level"]}")),
                        DataCell(Text("ثانية${snapshot.data![4]["tofa"]}")),
                        DataCell(Text("ثانية${snapshot.data![4]["toca"]}")),
                        DataCell(Text("ثانية${snapshot.data![4]["time"]}")),
                        DataCell(Text("${snapshot.data![4]["nerrors"]}")),
                        DataCell(Text("${snapshot.data![4]["answer"]}")),
                        DataCell(Text("${snapshot.data![4]["note"]}")),

                      ]),
                      DataRow(cells: [
                        DataCell(IconButton(onPressed: (){
                          setState(() {
                            updateData(6);
                          });
                        }, icon: const Icon(Icons.delete))),
                        DataCell(Text("${snapshot.data![5]["level"]}")),
                        DataCell(Text("ثانية${snapshot.data![5]["tofa"]}")),
                        DataCell(Text("ثانية${snapshot.data![5]["toca"]}")),
                        DataCell(Text("ثانية${snapshot.data![5]["time"]}")),
                        DataCell(Text("${snapshot.data![5]["nerrors"]}")),
                        DataCell(Text("${snapshot.data![5]["answer"]}")),
                        DataCell(Text("${snapshot.data![5]["note"]}")),

                      ]),
                      DataRow(selected: true,cells: [
                        DataCell(IconButton(onPressed: (){
                          setState(() {
                            updateData(7);
                          });
                        }, icon: const Icon(Icons.delete))),
                        DataCell(Text("${snapshot.data![6]["level"]}")),
                        DataCell(Text("ثانية${snapshot.data![6]["tofa"]}")),
                        DataCell(Text("ثانية${snapshot.data![6]["toca"]}")),
                        DataCell(Text("ثانية${snapshot.data![6]["time"]}")),
                        DataCell(Text("${snapshot.data![6]["nerrors"]}")),
                        DataCell(Text("${snapshot.data![6]["answer"]}")),
                        DataCell(Text("${snapshot.data![6]["note"]}")),

                      ]),
                      DataRow(cells: [
                        DataCell(IconButton(onPressed: (){
                          setState(() {
                            updateData(8);
                          });
                        }, icon: const Icon(Icons.delete))),
                        DataCell(Text("${snapshot.data![7]["level"]}")),
                        DataCell(Text("ثانية${snapshot.data![7]["tofa"]}")),
                        DataCell(Text("ثانية${snapshot.data![7]["toca"]}")),
                        DataCell(Text("ثانية${snapshot.data![7]["time"]}")),
                        DataCell(Text("${snapshot.data![7]["nerrors"]}")),
                        DataCell(Text("${snapshot.data![7]["answer"]}")),
                        DataCell(Text("${snapshot.data![7]["note"]}")),

                      ]),
                      DataRow(selected: true,cells: [
                        DataCell(IconButton(onPressed: (){
                          setState(() {
                            updateData(9);
                          });
                        }, icon: const Icon(Icons.delete))),
                        DataCell(Text("${snapshot.data![8]["level"]}")),
                        DataCell(Text("ثانية${snapshot.data![8]["tofa"]}")),
                        DataCell(Text("ثانية${snapshot.data![8]["toca"]}")),
                        DataCell(Text("ثانية${snapshot.data![8]["time"]}")),
                        DataCell(Text("${snapshot.data![8]["nerrors"]}")),
                        DataCell(Text("${snapshot.data![8]["answer"]}")),
                        DataCell(Text("${snapshot.data![8]["note"]}")),

                      ]),
                      DataRow(cells: [
                        DataCell(IconButton(onPressed: (){
                          setState(() {
                            updateData(10);
                          });
                        }, icon: const Icon(Icons.delete))),
                        DataCell(Text("${snapshot.data![9]["level"]}")),
                        DataCell(Text("ثانية${snapshot.data![9]["tofa"]}")),
                        DataCell(Text("ثانية${snapshot.data![9]["toca"]}")),
                        DataCell(Text("ثانية${snapshot.data![9]["time"]}")),
                        DataCell(Text("${snapshot.data![9]["nerrors"]}")),
                        DataCell(Text("${snapshot.data![9]["answer"]}")),
                        DataCell(Text("${snapshot.data![9]["note"]}")),

                      ]),
                    ])
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator(),);
            },),
          ),
          CustomButton(function: (){
            setState(() {
              updateData(1);
              updateData(2);
              updateData(3);
              updateData(4);
              updateData(5);
              updateData(6);
              updateData(7);
              updateData(8);
              updateData(9);
              updateData(10);
            });
          },buttonText: "مسح جميع البيانات",)
        ],
      ),


    );
  }
}
