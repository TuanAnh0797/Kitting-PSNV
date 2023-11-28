import 'dart:async';
import 'package:edimobilesystem/View/MenuPage/MenuPage.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';


import 'package:flutter_datawedge/models/scan_result.dart';
import 'package:flutter_datawedge/flutter_datawedge.dart';
import 'dart:io';

import '../../Controller/Otherfunction/api_CheckStatus.dart';
import '../../Model/Otherfuntion/ClassCheckStatus.dart';


/*void main() {
  runApp(new KittingFA());
}*/

class CheckMaterial extends StatelessWidget {

  const CheckMaterial({Key? key, required this.UserID}) : super(key: key);
  final String UserID;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      /* title: 'Flutter Demo',
        initialRoute:'/',
      routes: {
        '/menu_kittingFA': (context) => MenuFA(),
      },*/
      home: new ExampleWidget(datauser: UserID,),
      debugShowCheckedModeBanner: false,
    );
  }
}



class ExampleWidget extends StatefulWidget {
  ExampleWidget({Key? key, required this.datauser}) : super(key: key);
  final String datauser;

  @override
  _ExampleWidgetState createState() => new _ExampleWidgetState(datauser:datauser);
}

class _ExampleWidgetState extends State<ExampleWidget> {
  _ExampleWidgetState({required this.datauser});
  final String datauser;

  //bien focus
  late StreamSubscription<ScanResult> onScanResultListener;
  late FlutterDataWedge fdw;

  APICheckStaus _callapi= new APICheckStaus();
  List<procGetInfoMaterial> _obj_dtDependent_material = List.empty();

  var txtPartCard = new TextEditingController();
  var focusNode = FocusNode();  //gia tri focus
  final FocusNode partcardid = FocusNode();

  String display = '';

  Widget showgridview() {
    return new FutureBuilder<String>(builder: (context, snapshot) {
      // if(snapshot.hasData){return new Text(display);}    //does not display updated text
      //f (display != null) {
      if (display == '1') {
        print('${display}');
        //print(' vao OK');

        return createTable(context, snapshot);
      } else {
        print('${display}');
        //print('=>NG');
        //return new Text("no data yet!");
        return createTable_null(context, snapshot);
      }
    }, future: null,);
  }

  @override
  // Method that call only once to initiate the default app.
  void initState() {
    super.initState();
    initScanner();
  }

  void initScanner() {
    if (Platform.isAndroid) {
      fdw = FlutterDataWedge(profileName: 'FlutterDataWedge');
      onScanResultListener = fdw.onScanResult
          .listen((result) => setState(() async {
        if(partcardid.hasFocus)
        {
          txtPartCard.text = result.data;
          Partcardid_function(result.data, context);
        }
        /*else if(bacodeid.hasFocus)
        {
          txtBarcode.text = result.data;
          //await button_clickOK(result.data, context);
        }*/

      } ));
    }
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    partcardid.dispose();
    /*bacodeid.dispose();
    actualqtyid.dispose();*/
    super.dispose();

    onScanResultListener.cancel();
  }

  @override
  Widget build(BuildContext context) {
    //Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
    return
      Scaffold(
          appBar: AppBar(title: Text('Check Status by material'),),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10.0,
                ),

                Container(
                  /*height: 1000,*/
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        autofocus: true,
                        controller: txtPartCard,
                        focusNode: partcardid,
                        readOnly: true,
                        showCursor: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Partcard',
                          hintText: '',
                        ),
                        onSubmitted: (value) {
                          //Partcardid_function(value, context);
                        },
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 10.0),
                            child: ElevatedButton(
                              child: Text('Home'),
                              onPressed: () {
                                Navigator.push(context, new MaterialPageRoute(builder: (context) => new MenuPage()));
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 15.0),
                            child: ElevatedButton(
                              child: Text('Clear'),
                              onPressed: () {
                                reset();
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),

                      Divider(),
                      showgridview(),

                    ],
                  ),
                ),

              ],
            ),
          )
      );

  }



  void Partcardid_function(String value, BuildContext context) async  {
    try
    {
      if (value == "")
      {
        thongbaoNG(context, "Du lieu null!");
        partcardid.requestFocus();
      }
      else
      {
        //--21024252;2300000102;66;06/01/2023;4500266924;49;PNGTB123ZA/V1;600;3800;1;20230601-DP2;00001
        var chuoi = txtPartCard.text.toString();
        List<String>? itemList;
        itemList = chuoi.split(";");
        //var check_barcode = chuoi.substring(chuoi.length - 1,chuoi.length);
        //print(check_barcode);

        String Material = itemList[6].toString();//;txtPartCard.text.toString();
        //print (Material);
        _obj_dtDependent_material = (await _callapi.Get_Dependent_material(Material))!;
        if(_obj_dtDependent_material.length > 0)
        {

          setState(() {
            display = '1';
          });
          txtPartCard.selection = TextSelection(baseOffset: 0, extentOffset: txtPartCard.text.length);

        }
        else
        {
          setState(() {
            display = '0';
          });
        }

      }
    }
    catch (e)
    {
      thongbaoNG(context, e.toString());
    }

  }

  Widget createTable(BuildContext context, AsyncSnapshot snapshot) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child:LayoutBuilder(builder: (context, constraints) {
            return  SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(
                    label: Text("Material"),
                  ),
                  DataColumn(
                    label: Text("Sloc"),
                  ),
                  DataColumn(
                    label: Text("Qty"),
                  ),
                  DataColumn(
                    label: Text("Pos"),
                  ),
                  DataColumn(
                    label: Text("SubQty"),
                  ),
                  DataColumn(
                    label: Text("SubPos"),
                  ),
                  DataColumn(
                    label: Text("PIC"),
                  ),
                  DataColumn(
                    label: Text("Plant"),
                  ),
                ],
                rows: _obj_dtDependent_material.map(
                      (p) => DataRow(cells: [
                    DataCell(
                      Text(p.Material),
                    ),
                    DataCell(
                      Text(p.Sloc),
                    ),
                    DataCell(
                      Text(p.Qty.toString()),
                    ),
                    DataCell(
                      Text(p.Pos),
                    ),
                    DataCell(
                      Text(p.SubQty.toString()),
                    ),
                    DataCell(
                      Text(p.SubPos),
                    ),
                    DataCell(
                      Text(p.PIC),
                    ),
                    DataCell(
                      Text(p.Plant),
                    ),
                  ]),
                ).toList(),
              ),
            );
          })
      ),

    );
  }

  Widget createTable_null(BuildContext context, AsyncSnapshot snapshot) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(
                      label: Text("Material"),
                    ),
                    DataColumn(
                      label: Text("Sloc"),
                    ),
                    DataColumn(
                      label: Text("Qty"),
                    ),
                    DataColumn(
                      label: Text("Pos"),
                    ),
                    DataColumn(
                      label: Text("SubQty"),
                    ),
                    DataColumn(
                      label: Text("SubPos"),
                    ),
                    DataColumn(
                      label: Text("PIC"),
                    ),
                    DataColumn(
                      label: Text("Plant"),
                    ),
                  ],
                  rows: const <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  void thongbaoThanhcong(BuildContext context, String thongbao) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.green,
            content: Text('${thongbao}!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
          );
        });
  }

  void thongbaoNG(BuildContext context,String thongbao) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.red,
            content: Text('${thongbao}',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
          );
        });
  }

  void reset()
  {
    setState(() {
      txtPartCard.text='';
      partcardid.requestFocus();
      _obj_dtDependent_material = [];

    });
  }



}