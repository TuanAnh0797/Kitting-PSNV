import 'dart:async';
import 'package:edimobilesystem/View/MenuPage/MenuPage.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';


import 'package:flutter_datawedge/models/scan_result.dart';
import 'package:flutter_datawedge/flutter_datawedge.dart';
import 'dart:io';

import '../../Controller/Otherfunction/api_CheckStatus.dart';
import '../../Model/Otherfuntion/ClassCheckStatus.dart';
import 'frmCheckMaterial.dart';


/*void main() {
  runApp(new KittingFA());
}*/

class CheckStockcard extends StatelessWidget {

  const CheckStockcard({Key? key, required this.UserID}) : super(key: key);
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
  List<Get_List_CheckStock> _obj_dtStorage = List.empty();
  List<Get_List_CheckStock_duoiL> _obj_dtStorage_L = List.empty();

  List<Get_Detail_Dependent_CheckSloc> _obj_dtDependent = List.empty();


  var txtPartCard = new TextEditingController();


  var focusNode = FocusNode();  //gia tri focus
  final FocusNode partcardid = FocusNode();

  String lblQtybox = '';
  String lblQtyLot = '';
  String lblQtyStock = '';

  String qtybox = '';
  String qtylot = '';
  String qtystock = '';

  bool isChecked = false;
  bool isduoiL = false;

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
          appBar: AppBar(title: Text('Detail of material'),),
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
                        children: [
                          Card(child: isduoiL == false ? Text(' Qty box: ',style: TextStyle(fontSize: 18,color: Colors.blue, fontWeight: FontWeight.bold),): Text(' Qty Location: ',style: TextStyle(fontSize: 18,color: Colors.blue, fontWeight: FontWeight.bold),),),
                          //Text(' Qty box: ',style: TextStyle(fontSize: 18,color: Colors.blue, fontWeight: FontWeight.bold),),
                          SizedBox(
                              width: 100.0,
                              height: 50.0,
                              child: lblQtybox == ''? Card(child: Text('0',style: TextStyle(fontSize: 22,color: Colors.blue, fontWeight: FontWeight.bold),)):
                              Card(child: Text('${lblQtybox}',style: TextStyle(fontSize: 22,color: Colors.blue, fontWeight: FontWeight.bold),))
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Card(child:  isduoiL== false ? Text(' Qty Lot: ',style: TextStyle(fontSize: 18,color: Colors.blue, fontWeight: FontWeight.bold),): Text(' Qty Dependent: ',style: TextStyle(fontSize: 18,color: Colors.blue, fontWeight: FontWeight.bold),),),
                          //Text(' Qty Lot: ',style: TextStyle(fontSize: 18,color: Colors.blue, fontWeight: FontWeight.bold),),
                          SizedBox(
                              width: 100.0,
                              height: 50.0,
                              child: lblQtyLot == ''? Card(child: Text('0',style: TextStyle(fontSize: 22,color: Colors.blue, fontWeight: FontWeight.bold),)):
                              Card(child: Text('${lblQtyLot}',style: TextStyle(fontSize: 22,color: Colors.blue, fontWeight: FontWeight.bold),))
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Card(child:  isduoiL == false ? Text(' Qty stock: ',style: TextStyle(fontSize: 18,color: Colors.blue, fontWeight: FontWeight.bold),): Text('Qty Stock',style: TextStyle(fontSize: 18,color: Colors.blue, fontWeight: FontWeight.bold),),),
                          //Text(' Qty stock: ',style: TextStyle(fontSize: 18,color: Colors.blue, fontWeight: FontWeight.bold),),
                          SizedBox(
                              width: 100.0,
                              height: 50.0,
                              child: lblQtyStock == ''? Card(child: Text('0',style: TextStyle(fontSize: 22,color: Colors.blue, fontWeight: FontWeight.bold),)):
                              Card(child: Text('${lblQtyStock}',style: TextStyle(fontSize: 22,color: Colors.blue, fontWeight: FontWeight.bold),))
                          ),
                        ],
                      ),


                      Row(
                        children: <Widget>[
                          SizedBox(width: 10,),
                          //CheckboxListTile(
                          Checkbox(
                            value: isChecked,
                            onChanged: (bool? value) async {
                              setState(() {
                                isChecked = value!;
                              });

                            },
                          ),
                          SizedBox(
                              width: 200.0,
                              height: 30.0,
                              child: isChecked == false? Card(child: Text('Detail Dependent',style: TextStyle(fontSize: 18,color: Colors.blue, fontWeight: FontWeight.bold),)):
                              Card(child: Text('Detail Dependent',style: TextStyle(fontSize: 18,color: Colors.blue, fontWeight: FontWeight.bold),))
                          )
                          //Text('View Plant Kitting',style: TextStyle(fontSize: 18.0), ),
                        ],
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
                            width: 5.0,
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

                          const SizedBox(
                            width: 5.0,
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 15.0),
                            child: ElevatedButton(
                              child: Text('Material'),
                              onPressed: () {
                                Navigator.push(context, new MaterialPageRoute(builder: (context) => new CheckMaterial(UserID: datauser)));
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

                     /* Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 50.0,
                            height: 10.0,
                          ),
                          Text('User : ${datauser}',style: TextStyle(fontSize: 16,color: Colors.blue, fontWeight: FontWeight.bold),),


                        ],
                      ),*/
                    ],
                  ),
                ),

              ],
            ),
          )
      );

  }



  void Partcardid_function(String value, BuildContext context) {
    try
    {
      if (value == "")
      {
        thongbaoNG(context, "Du lieu null!");
        partcardid.requestFocus();
      }
      else
      {
        var chuoi = txtPartCard.text.toString();
        List<String>? itemList;
        itemList = chuoi.split(";");
        var check_barcode = chuoi.substring(chuoi.length - 1,chuoi.length);
        print(check_barcode);


        String Barcode = txtPartCard.text.toString();

        _callapi.Check_Stock(Barcode).then((value) async {
          if(value != '-1')
          {
            if(check_barcode != 'L')
            {
              //print(value);
              List<String>? itemList2;
              itemList2 = value.split(";");

              qtybox = itemList2[0].toString();
              qtylot = itemList2[1].toString();
              qtystock = itemList2[2].toString();

              //table :  --qtybox;qtylot;qtysloc  (3 cot)
              //20000000;20230606;12;06/06/2023;4500000000;12;PNPG3933001YA/V1;10;10;1;LOST;00001
              //print('vao 2');
              _obj_dtStorage = (await _callapi.Get_CheckStock(Barcode))!;
              setState(() {
                isduoiL = false;
                lblQtybox  = qtybox;
                lblQtyLot  = qtylot;
                lblQtyStock  = qtystock;
                display = '1';
              });
            }
            else
            {
              //print('duoi L: gia tri check stock  duoc cat ra:');
              //print(value);
              List<String>? itemList2;
              itemList2 = value.split(";");

              //table :  --Qtyposition;qtydepent  (2 cot)
              // DPGB1619ZA/X1;VB01;5P30;PJ-15A5-2C;L
              _obj_dtDependent = (await _callapi.Get_Dependent(Barcode))!;
              _obj_dtStorage_L = (await _callapi.Get_List_CheckStock_L(Barcode))!;

              qtybox = itemList2[0].toString();
              qtylot = itemList2[1].toString();
              //qtystock = '0';

              //table co 2 cot (_obj_dtStorage) : DateStogare;Qty_Lot
              setState(() {
                isduoiL = true;
                lblQtybox  = qtybox;
                lblQtyLot  = qtylot;
                //lblQtyStock  = qtystock;
                display = '1';
              });
            }
          }
          else
          {
            thongbaoNG(context, "Ma nay khong the check");
            txtPartCard.text='';
            partcardid.requestFocus();
          }
        });
      }
    }
    catch(e)
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
              if( isChecked == true)
              {
                //dt_dependent
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(
                        label: Text("ID"),
                      ),
                      DataColumn(
                        label: Text("Position"),
                      ),
                      DataColumn(
                        label: Text("Quantity"),
                      ),

                    ],
                    rows: _obj_dtDependent.map(
                          (p) => DataRow(cells: [
                        DataCell(
                          Text(p.ID.toString()),
                        ),
                        DataCell(
                          Text(p.Position),
                        ),
                        DataCell(
                          Text(p.Quantity.toString()),
                        ),
                      ]),
                    ).toList(),
                  ),
                );
              }
              else
              {
                //dt_stock
                if(isduoiL ==  true)
                {
                  return  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columns: [
                        DataColumn(
                          label: Text("DateStogare"),
                        ),
                        DataColumn(
                          label: Text("Qty_Lot"),
                        ),
                      ],
                      rows: _obj_dtStorage_L.map(
                            (p) => DataRow(cells: [
                          DataCell(
                            Text(p.DateStogare),
                          ),
                          DataCell(
                            Text(p.Qty_Lot.toString()),
                          ),
                        ]),
                      ).toList(),
                    ),
                  );
                }
                else
                {
                  return  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(
                          label: Text("UnitNo"),
                        ),
                        DataColumn(
                          label: Text("InvoiceNo"),
                        ),
                        DataColumn(
                          label: Text("QtyDetail"),
                        ),
                        DataColumn(
                          label: Text("QtyBox"),
                        ),
                      ],
                      rows: _obj_dtStorage.map(
                            (p) => DataRow(cells: [
                          DataCell(
                            Text(p.UnitNo),
                          ),
                          DataCell(
                            Text(p.InvoiceNo),
                          ),
                          DataCell(
                            Text(p.QuantityDetail.toString()),
                          ),
                          DataCell(
                            Text(p.QuantityBox.toString()),
                          ),

                        ]),
                      ).toList(),
                    ),
                  );
                }

              }
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
                      label: Text("UnitNo"),
                    ),
                    DataColumn(
                      label: Text("InvoiceNo"),
                    ),
                    DataColumn(
                      label: Text("QtyDetail"),
                    ),
                    DataColumn(
                      label: Text("QtyBox"),
                    ),
                  ],
                  rows: const <DataRow>[
                    DataRow(
                      cells: <DataCell>[
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
      lblQtybox = '';
      lblQtyLot = '';
      lblQtyStock = '';
      qtybox = '';
      qtylot = '';
      qtystock = '';
      isChecked = false;
      display = '0';
      _obj_dtStorage = [];
      _obj_dtDependent=[];
      _obj_dtStorage_L = [];

    });
  }



}