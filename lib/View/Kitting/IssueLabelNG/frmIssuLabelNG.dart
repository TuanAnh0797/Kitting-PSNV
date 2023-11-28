import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../../../Controller/Kitting/IssueLabelNG/api_issuelabelNG.dart';
import '../../../Model/Kitting/IssueLabelNG/Class_IssuelabelNG.dart';
import '../MenuKitting.dart';

import 'package:flutter_datawedge/models/scan_result.dart';
import 'package:flutter_datawedge/flutter_datawedge.dart';
import 'dart:io';

/*void main() {
  runApp(new KittingFA());
}*/

class IssulabelNG extends StatelessWidget {

  const IssulabelNG({Key? key, required this.UserID}) : super(key: key);
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

  Class_IssuelabelNG _call_api_issuelabelNG =  new Class_IssuelabelNG();
  List<procGetInfoMaterial_SLOC> _obj_dt_position = List.empty();

  var txtCode = new TextEditingController();
  var txtQuantity = new TextEditingController();

  String lblQuantity ='';
  String lblMaterial ='';

  String Material ='';
  String Sloc='';
  String ID='';
  String Plant='';



  var focusNode = FocusNode();  //gia tri focus
  final FocusNode txtCodeid = FocusNode();
  late FocusNode txtQuantityid = FocusNode();

  String _groupValue = '';
  void checkRadio(String value ) {
    setState(() {
      _groupValue = value;
    });
  }


  @override
  // Method that call only once to initiate the default app.
  void initState() {
    super.initState();
    _groupValue = "rbtnHaveDA";
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
          await Codeid_function(result.data, context);
        }else if(txtQuantityid.hasFocus)
        {
          txtQuantity.text = result.data;
          Qtyid_function(result.data, context);
        }

      } ));
    }
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    txtCode.dispose();
    txtQuantity.dispose();
    super.dispose();
    onScanResultListener.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
    return
      Scaffold(
          appBar: AppBar(title: Text('Issue Label NG'),),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Row(children: [
                Radio<String>(
                    value: "rbtnHaveDA",
                    groupValue: _groupValue,
                    onChanged: (value) {
                      checkRadio(value as String);
                    }),
                Text("Have DA"),
                const SizedBox(
                  width: 30.0,
                ),
                Radio<String>(
                    value: "rbtnNoDA",
                    groupValue: _groupValue,
                    onChanged: (value) {
                      checkRadio(value as String);
                    }),
                Text("No DA"),
              ]),

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
                        labelText: 'Material',
                        hintText: '',
                      ),
                      onSubmitted: (value) async {
                        //await Codeid_function(value, context);
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 120.0,
                          height: 50.0,
                          child: TextField(
                            controller: txtQuantity,
                            focusNode: txtQuantityid,
                            readOnly: true,
                            showCursor: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Qty',
                              hintText: '',
                            ),
                            keyboardType: TextInputType.number,
                            onSubmitted:(value) {
                              //Qtyid_function(value, context);
                            },
                          ),
                        ),

                      ],
                    ),

                    const SizedBox(
                      height: 10.0,
                    ),

                    SizedBox(
                        width: 300.0,
                        height: 50.0,
                        child: lblQuantity == ''? Card(child: Text('0',style: TextStyle(fontSize: 25,color: Colors.red, fontWeight: FontWeight.bold,), textAlign: TextAlign.center,)):
                        Card(child: Text('${lblQuantity}',style: TextStyle(fontSize: 25,color: Colors.blue, fontWeight: FontWeight.bold), textAlign: TextAlign.center,))
                    ),
                    SizedBox(
                        width: 300.0,
                        height: 50.0,
                        child: lblMaterial == ''? Card(child: Text('lable1',style: TextStyle(fontSize: 25,color: Colors.black, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)):
                        Card(child: Text('${lblMaterial}',style: TextStyle(fontSize: 25,color: Colors.blue, fontWeight: FontWeight.bold), textAlign: TextAlign.center,))
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
                            child: Text('Clear'),
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
                            child: Text('Issue'),
                            onPressed: () {
                              btnIssue_Click(context);
                            },
                          ),
                        ),
                      ],
                    ),




                  ],
                ),
              ),

            ],
          )
      );

  }

  void Qtyid_function(String value, BuildContext context) {
    if(value != '')
    {
      btnIssue_Click(context);
    }
    else
    {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.red,
              content: Text('Ban chua nhap so luong'),
            );
          });
      //txtAct_Qty.text='';
      txtQuantityid.requestFocus();
    }
  }

  Future<void> Codeid_function(String value, BuildContext context) async {
    try
    {
      if (value == "")
      {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.red,
                content: Text('du lieu null!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
              );
            });
        txtCodeid.requestFocus();
      }
      else
      {
        var chuoi = txtCode.text.toString();
        List<String>? itemList;
        itemList = chuoi.split(";");
        //print(chuoi);
        //print(itemList.length);
        //Material, Sloc, Plant

        if(itemList.length == 14)  //itemList != null &&   itemList != null &&
            {
          Material = itemList[1].toString();
          Sloc = itemList[5].toString();
          print(chuoi.length);
          var _chuoicat = chuoi.substring(chuoi.length-2,chuoi.length);
          print(_chuoicat);
          if(_chuoicat== ';P')
          {
            Plant = itemList[9].toString();
            print(Plant);
          }
          else
          {
            Plant = itemList[7].toString();
            print(Plant);
          }
          //print(Material);
          //print(Sloc);

          //lay thong tin kho
          _obj_dt_position = (await _call_api_issuelabelNG.Get_Info_Material(Material,Sloc, Plant))!;
          if(_obj_dt_position.length > 0)
          {
            if(_obj_dt_position.length == 0)
            {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.red,
                      content: Text('Ma nay da het hang',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                    );
                  });
              //blnScan = false;
              txtCode.text="";
              txtCodeid.requestFocus();
            }
            else
            {
              setState(() {
                lblQuantity = _obj_dt_position[0].Quantity.toString();
                Material = _obj_dt_position[0].Material;
                Sloc = _obj_dt_position[0].Sloc;
                ID = _obj_dt_position[0].ID.toString();
                Plant = _obj_dt_position[0].Plant;
                lblMaterial = Material + ' - ' + Sloc;
              });

              txtQuantity.text="";
              txtQuantityid.requestFocus();

            }

          }
          else
          {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.red,
                    content: Text('Ma nay khong ton tai!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                  );
                });
            //blnScan = false;
            txtCode.text="";
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
                  content: Text('Khong pai part card!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                );
              });
          txtCode.text = "";
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

  void btnIssue_Click(BuildContext context) {
    try
    {
      if(txtQuantity.text != '')
      {
        if(double.parse(txtQuantity.text.toString()) > double.parse(lblQuantity.toString())  )
        {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.red,
                  content: Text('So luong ton kho chi con: ${lblQuantity}',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                );
              });
          txtQuantity.text='';
          txtQuantityid.requestFocus();
        }
        else
        {
          String type;
          if(_groupValue == 'rbtnHaveDA')
          {
            type = _groupValue.toUpperCase();
          }
          else
          {
            type = _groupValue.toUpperCase();
          }
          String Partcard=txtCode.text.toString();
          String TypeLabel = type;
          String Quantity = txtQuantity.text.toString();
          String User = datauser;
          //print('==>ket qua tai day:');
          //print(Partcard);
          //print(TypeLabel);
          //print(Quantity);
          //print(User);

          _call_api_issuelabelNG.procGRTransNG_add(Partcard, Material, Plant, Sloc, TypeLabel, ID, Quantity, User).then((value) {
            if(value = true)
            {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.green,
                      content: Text('Issue label Success!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                    );
                  });
              reset();
            }
            else
            {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.red,
                      content: Text('Issue label Fails!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                    );
                  });
              txtQuantity.text='';
              txtQuantityid.requestFocus();
            }

          });


        }
      }
      else
      {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.red,
                content: Text('Ban chua nhap so luong',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
              );
            });
        //txtAct_Qty.text='';
        txtQuantityid.requestFocus();
      }
    }
    catch(e)
    {
      thongbaoNG(context, e.toString());
    }
  }

  void reset()
  {
    setState(() {
      txtCode.text = '';
      txtQuantity.text='';
      txtCodeid.requestFocus();
      lblMaterial='';
      lblQuantity='0';
      _obj_dt_position = [];

    });
  }




}