import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../../../Controller/Kitting/UnlockMaterial/api_unlockmaterial.dart';
import '../../../Model/Kitting/UnlockMaterial/Class_UnlokcMaterial.dart';
import '../MenuKitting.dart';

import 'package:flutter_datawedge/models/scan_result.dart';
import 'package:flutter_datawedge/flutter_datawedge.dart';
import 'dart:io';


/*void main() {
  runApp(new KittingFA());
}*/

class UnlockMaterial extends StatelessWidget {

  const UnlockMaterial({Key? key, required this.UserID}) : super(key: key);
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

  String display = '';
  List<GetMaterialLocked> _obj_dt_GRtran = List.empty();
  Class_unlockmaterialGRtran _call_api_dtGRtran = Class_unlockmaterialGRtran();

  var txtCode = new TextEditingController();

  var focusNode = FocusNode();  //gia tri focus
  final FocusNode txtCodeid = FocusNode();

  String Material='';
  String ListID='';

  Widget showgridview() {
    return new FutureBuilder<String>(builder: (context, snapshot) {
      // if(snapshot.hasData){return new Text(display);}    //does not display updated text
      //f (display != null) {
      if (display == '1') {
        print('gia tri griview: ${display}');
        //print(' vao OK');

        return createTable(context, snapshot);
      } else {
        print('gia tri griview: ${display}');
        //print('=>NG');
        //return new Text("no data yet!");
        return createTable_null(context, snapshot);
      }
    }, future: null,);
  }

  void initState() {
    //Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
    super.initState();
    initScanner();
  }

  void initScanner() {
    if (Platform.isAndroid) {
      fdw = FlutterDataWedge(profileName: 'FlutterDataWedge');
      onScanResultListener = fdw.onScanResult
          .listen((result) => setState(() async {
        if(txtCodeid.hasFocus)
        {
          //print('abc');
          txtCode.text = result.data;
          await Codeboxid_function(result.data, context);
        }

      } ));
    }
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    txtCodeid.dispose();
    super.dispose();
    onScanResultListener.cancel();
  }

  @override
  Widget build(BuildContext context) {
    //Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
    return
      Scaffold(
          appBar: AppBar(title: Text('Unlock Material'),),
          body: Column(
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
                      controller: txtCode,
                      focusNode: txtCodeid,
                      readOnly: true,
                      showCursor: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Code ',
                        hintText: '',
                      ),
                      onSubmitted: (value) async {
                        //await Codeboxid_function(value, context);
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),



                    const SizedBox(
                      height: 10.0,
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
                              //Navigator.push(context, new MaterialPageRoute(builder: (context) => new MenuKitting(UserID: datauser)));
                              Navigator.push(context, new MaterialPageRoute(builder: (context) => new MenuKitting(UserID: datauser)));
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 15.0),
                          child: ElevatedButton(
                            child: Text('clear'),
                            onPressed: () {
                              reset();
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 15.0),
                          child: ElevatedButton(
                            child: Text('Unlock'),
                            onPressed: () {
                              showAlertDialog_ListID(context);
                            },
                          ),
                        ),


                      ],
                    ),

                    Divider(),
                    showgridview(),




                  ],
                ),
              ),

            ],
          )
      );

  }

  Future<void> Codeboxid_function(String value, BuildContext context) async {
    try
    {
      if (value == "")
      {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.red,
                content: Text('Du lieu null!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
              );
            });
        txtCodeid.requestFocus();
      }
      else
      {
        var chuoi = txtCode.text.toString();
        List<String>? itemList;
        itemList = chuoi.split(";");
        print('print abc');
        Material = itemList[6].toString();
        print(Material);
        print(itemList.length);
        if(itemList.length == 12)
        {
          //_obj_dt_kittingtran = (await _call_api_chekingdip.get_dt_kittingTran(TypeKitting, DeliveriDate, Model, Plant, Category, Name_common, Time, UploadNo))!;

          _obj_dt_GRtran = (await _call_api_dtGRtran.Get_dt_GRtran(Material))!;
          if(_obj_dt_GRtran.length > 0)
          {
            setState(() {
              display = '1';
            });
          }
          else
          {
            setState(() {
              display = '0';
            });
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.red,
                    content: Text('Khong co du lieu!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
                  );
                });
            txtCodeid.requestFocus();
          }

        }
        else
        {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.red,
                  content: Text('Barcode khong dung',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
                );
              });
          txtCodeid.requestFocus();

        }


      }
    }
    catch(e)
    {
      thongbaoNG(context, e.toString());
    }
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

  showAlertDialog_ListID(BuildContext context) {
    // truong hop checking hang thieu
    Widget continueButton = TextButton(
      child: Text("YES"),
      onPressed: () {
        for (var i = 0; i < _obj_dt_GRtran.length; i++) {
          ListID = ListID + "," + _obj_dt_GRtran[i].GRTranID.toString();
        }
        print('gia tri list ID');
        print(ListID);
        //ListID = ListID.Substring(1);  //cat ky tu dau tien di ","
        setState(() {
          ListID = ListID.substring(1,ListID.length);
        });

        print(ListID);
        _call_api_dtGRtran.UnLockMaterial_ByListID(ListID).then((value) {
          if(value == true)
          {
            setState(() {
              display = '0';
            });
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.green,
                    content: Text('UNLOCK thanh cong!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
                  );
                });
            reset();
          }
          else
          {
            setState(() {
              display = '0';
            });
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.red,
                    content: Text('UNLOCK that bai!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
                  );
                });
            reset();
          }
        });


        Navigator.of(context, rootNavigator: true).pop(true);
      },
    );
    Widget cancelButton = TextButton(
      child: Text("NO"),
      onPressed: () {
        txtCode.text = '';
        txtCodeid.requestFocus();
        Navigator.of(context, rootNavigator: true)
            .pop(false); // dismisses only the dialog and returns false
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Thong bao"),
      content: Text("Ban muon UNLOCK ma hang nay?"),
      actions: [
        continueButton,
        cancelButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget createTable(BuildContext context, AsyncSnapshot snapshot) {
    return  SingleChildScrollView(
      /* scrollDirection: Axis.vertical,*/
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        //height: MediaQuery.of(context).size.height * 0.3,
        child:LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                //sortColumnIndex: _currentSortColumn,
                //sortAscending: _isAscending,
                headingRowColor: MaterialStateProperty.all(Colors.amber[200]),
                columns: [
                  DataColumn(
                    label: Text("GRTranID"),
                  ),
                  DataColumn(
                    label: Text("Barcode"),
                  ),

                ],   //_obj_dt_kittingtran
                rows: _obj_dt_GRtran.map(
                      (p) => DataRow(
                      color: MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                            // All rows will have the same selected color.
                            if (states.contains(MaterialState.selected)) {
                              return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                            }
                            // Even rows will have a grey color.
                            /*if (index.isEven) {
                                                      return Colors.grey.withOpacity(0.3);
                                                    }*/
                            return null; // Use default value for other states and odd rows.
                          }),
                      cells: [
                        DataCell(
                          Text(p.GRTranID.toString()),
                        ),
                        DataCell(
                          Text(p.Barcode),
                        ),
                      ]),
                ).toList(),
              ),
            ),
          );

        }),
      ),
    );
  }

  Widget createTable_null(BuildContext context, AsyncSnapshot snapshot) {
    return  SingleChildScrollView(
      /* scrollDirection: Axis.vertical,*/
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        //height: MediaQuery.of(context).size.height * 0.3,
        child:LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                //sortColumnIndex: _currentSortColumn,
                //sortAscending: _isAscending,
                headingRowColor: MaterialStateProperty.all(Colors.amber[200]),
                columns: [
                  DataColumn(
                    label: Text("IDGRtran"),
                  ),
                  DataColumn(
                    label: Text("Barcode"),
                  ),
                ],   //_obj_dt_kittingtran
                rows: const <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('')),
                      DataCell(Text('')),
                    ],
                  ),
                ],
              ),
            ),
          );

        }),
      ),
    );
  }

  void reset()
  {
    setState(() {
      txtCode.text='';
      txtCodeid.requestFocus();
      _obj_dt_GRtran =[];
      Material ='';
      ListID ='';
    });
  }




}