import 'dart:async';
import 'dart:convert';
import 'package:edimobilesystem/View/MenuPage/MenuPage.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';


import 'package:flutter_datawedge/models/scan_result.dart';
import 'package:flutter_datawedge/flutter_datawedge.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';
import 'dart:io';

import '../../Controller/Otherfunction/api_CheckStatus.dart';
import '../../Model/Otherfuntion/ClassCheckStatus.dart';
import 'frmCheckMaterial.dart';


/*void main() {
  runApp(new KittingFA());
}*/

class Postdiff extends StatelessWidget {

  const Postdiff({Key? key, required this.UserID}) : super(key: key);
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
  List<Get_TBLGRTrans> _obj_TBLGRTrans = List.empty();


  var txtCode = new TextEditingController();
  var txtQtyAdd = new TextEditingController();
  var txtQtySub = new TextEditingController();

  var focusNode = FocusNode();  //gia tri focus
  final FocusNode codedid = FocusNode();
  final FocusNode Qtyaddid = FocusNode();
  final FocusNode Qtysubid = FocusNode();

  String lblQtyAvaiable = '';
  String typediff = '';
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
    initScanner();
    getAllCategory();
  }

  void initScanner() {
    if (Platform.isAndroid) {
      fdw = FlutterDataWedge(profileName: 'FlutterDataWedge');
      onScanResultListener = fdw.onScanResult
          .listen((result) => setState(()  {
        if(codedid.hasFocus)
        {
          txtCode.text = result.data;
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

  List<Get_Reason_UpdateBox> categoryItemlist = List.empty();
  var dropdownvalue;
  void getAllCategory() async {
    List<Get_Reason_UpdateBox> temp = (await _callapi.getAllCategory("cate"))!;
    setState(() {
        categoryItemlist = temp;
    });
    // print(categoryItemlist);
  }


  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    codedid.dispose();
    Qtyaddid.dispose();
    Qtysubid.dispose();

    super.dispose();

    onScanResultListener.cancel();
  }

  @override
  Widget build(BuildContext context) {
    //Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
    return
      Scaffold(
          appBar: AppBar(title: Text('Post Difference'),),
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
                        controller: txtCode,
                        focusNode: codedid,
                        readOnly: true,
                        showCursor: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Code',
                          hintText: '',
                        ),
                        onSubmitted: (value) {
                          //Partcardid_function(value, context);
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),

                      Row(
                        children: [
                          //Text('Reason',style: TextStyle(fontSize: 18,color: Colors.blue, fontWeight: FontWeight.bold),),
                          DropdownButton(
                            //dropdownColor: Colors.lightGreen,
                            hint: Text('Reason',style: TextStyle(fontSize: 18),),
                            //elevation: 30,
                            //style: const TextStyle(color: Colors.blue,),
                            items: categoryItemlist.map((item) {
                              return DropdownMenuItem(
                                value: item.Reason.toString(),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0) //                 <--- border radius here
                                    ),
                                  ),
                                  margin: EdgeInsets.all(6),
                                  alignment: Alignment.center,
                                  constraints: BoxConstraints(minHeight: 80.0, minWidth: 260.0,),
                                  child: Text(item.Reason.toString(),style: TextStyle(fontSize: 18),),
                                )
                                //Text(item.Reason.toString()),
                              );
                            }).toList(),
                            onChanged: (newVal) {
                              setState(() {
                                dropdownvalue = newVal;
                              });
                              if(_groupValue == 'rAdd')
                              {
                                txtQtyAdd.text = "";
                                Qtyaddid.requestFocus();
                              }
                              else
                              {
                                txtQtySub.text = "";
                                Qtysubid.requestFocus();
                              }

                            },
                            value: dropdownvalue,
                          ),

                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Radio<String>(
                              value: "rAdd",
                              groupValue: _groupValue,
                              onChanged: (value) {
                                checkRadio(value as String);
                                setState(() {
                                  typediff = '1';
                                  Qtyaddid.requestFocus();
                                });
                                txtQtySub.text='';
                                txtQtyAdd.text ="";
                              }),

                          const SizedBox(
                            width: 5.0,
                          ),
                          Container(
                            width: 60,
                            padding: const EdgeInsets.all(10.0),
                            child: Text("Add (+)"),
                          ),
                          SizedBox(
                            width: 180,
                            height: 50,
                            child: TextField(
                              autofocus: true,
                              controller: txtQtyAdd,
                              focusNode: Qtyaddid,
                              style: TextStyle(color: Colors.red),
                              //readOnly: true,
                              //showCursor: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Add',
                                hintText: '',
                              ),
                              keyboardType: TextInputType.number,
                              onSubmitted: (value) {
                                    String _Qty = txtQtyAdd.text.toString();
                                    if(double.parse(_Qty) > 0)
                                    {
                                      showAlertDialog_ADD_SUB(context,"Ban muon them so luong vao Box?","add");
                                    }
                                    else
                                    {
                                      thongbaoNG(context, "Nhap lai so luong");
                                      txtQtyAdd.text ='';
                                      Qtyaddid.requestFocus();
                                    }
                              },
                            ),
                          )


                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Radio<String>(
                              value: "rSub",
                              groupValue: _groupValue,
                              onChanged: (value) {
                                checkRadio(value as String);
                                setState(() {
                                  typediff = '0';
                                  Qtysubid.requestFocus();
                                });
                                txtQtySub.text='';
                                txtQtyAdd.text ="";
                              }),

                          const SizedBox(
                            width: 5.0,
                          ),
                          Container(
                            width: 60,
                            padding: const EdgeInsets.all(10.0),
                            child: Text("Subtract (-)"),
                          ),
                          SizedBox(
                            width: 180,
                            height: 50,
                            child: TextField(
                              autofocus: true,
                              controller: txtQtySub,
                              focusNode: Qtysubid,
                              style: TextStyle(color: Colors.red),
                              //readOnly: true,
                              //showCursor: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Sub',
                                hintText: '',
                              ),
                              keyboardType: TextInputType.number,
                              onSubmitted: (value) {
                                  String _Qty = txtQtySub.text.toString();
                                  if(double.parse(_Qty) > 0)
                                  {
                                    showAlertDialog_ADD_SUB(context,"Ban muon tru so luong vao Box?","sub");
                                  }
                                  else
                                  {
                                    thongbaoNG(context, "Nhap lai so luong");
                                    txtQtyAdd.text ='';
                                    Qtyaddid.requestFocus();
                                  }
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),

                      Row(
                        children: [
                          Text(' Qty Avaiable: ',style: TextStyle(fontSize: 18,color: Colors.blue, fontWeight: FontWeight.bold),),
                          SizedBox(
                              width: 180.0,
                              height: 50.0,
                              child: lblQtyAvaiable == ''? Card(child: Text('0',style: TextStyle(fontSize: 22,color: Colors.blue, fontWeight: FontWeight.bold),)):
                              Card(child: Text('${lblQtyAvaiable}',style: TextStyle(fontSize: 22,color: Colors.blue, fontWeight: FontWeight.bold),))
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 20.0,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 10.0),
                            child: ElevatedButton(
                              child: Text('Back'),
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
                              child: Text('Unlock'),
                              onPressed: () {

                                showAlertDialog_Unlock(context);

                              },
                            ),
                          ),


                        ],
                      ),

                    ],
                  ),
                ),

              ],
            ),
          )
      );

  }


  void Partcardid_function(String value, BuildContext context) async {
    try
    {
      if (value == "")
      {
        thongbaoNG(context, "Du lieu null!");
        codedid.requestFocus();
      }
      else
      {
        var chuoi = txtCode.text.toString();
        List<String>? itemList;
        itemList = chuoi.split(";");
        //var check_barcode = chuoi.substring(chuoi.length - 1,chuoi.length);
        //print(check_barcode);
        //21024608;1600000172;55;01/08/2016;4500105443;5;PNJK1107PA/V1;9600;1200;8;P01-20160801;00001
        String Barcode = txtCode.text.toString();
        if(itemList != null && itemList.length == 12)
        {
          Openpeding();
          _obj_TBLGRTrans = (await _callapi.Get_TBLGRTrans_possdif(Barcode))!;
          if(_obj_TBLGRTrans.length > 0)
          {
            Closepending();
            if(double.parse(_obj_TBLGRTrans[0].GetQuantity.toString()) != 0)
            {
              //truong hop unlock barcode
              showAlertDialog_YesNo(context);

            }
            else if(double.parse(_obj_TBLGRTrans[0].GetQuantity.toString()) == 0 && double.parse(_obj_TBLGRTrans[0].AvaiableQuantity.toString()) > 0)
            {

              setState(() {
                lblQtyAvaiable = _obj_TBLGRTrans[0].AvaiableQuantity.toString();
                _groupValue = "rAdd";
              });
              txtQtyAdd.text='';
              Qtyaddid.requestFocus();

            }
          }
          else
          {
            Closepending();
            thongbaoNG(context, "Khong co du lieu.");
            txtCode.text ="";
            codedid.requestFocus();
          }

        }
        else
        {
          thongbaoNG(context, "Barcode khong dung");
          txtCode.text ="";
          codedid.requestFocus();
        }

      }
    }
    catch(e)
    {
      thongbaoNG(context, e.toString());
    }
  }

  void Openpeding() async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 10,
              ),
              Text('Loading...')
            ],
          ),
        );
      },
    );
  }

  void Closepending() {
    //Navigator.of(context).pop();
    Navigator.of(context, rootNavigator: true).pop(true);
  }


  showAlertDialog_ADD_SUB(BuildContext context,String thongbao,String type_action) {
    // truong hop checking hang thieu
    Widget continueButton = TextButton(
      child: Text("YES"),
      onPressed: () {
        //btnUNLOCK.Enabled = true;
        //them so luong vao kho
        //conn.ExcuteStored_bool("TBL_Posdiffrence_Add", arrParam, arrValue
        String GRTranID = _obj_TBLGRTrans[0].GRTranID.toString();
        String QtyOld = _obj_TBLGRTrans[0].AvaiableQuantity.toString();
        String QtyNew = '';//txtQtyAdd.text.toString();
        String Create_User = datauser;
        String Typediff = typediff;
        //String Reason = dropdownvalue;  ==> NG
        String Reason = "";

        if(type_action == "add")
        {
          QtyNew = txtQtyAdd.text.toString();
        }
        else
        {
          //type_action == "sub"
          QtyNew = txtQtySub.text.toString();
        }

        // print(GRTranID);
        // print(QtyOld);
        // print(QtyNew);
        // print(Create_User);
        // print(Typediff);

        if (dropdownvalue.toString() == "null")
        {
          Navigator.of(context, rootNavigator: true).pop(true);
          if(_groupValue == 'rAdd')
          {
            txtQtyAdd.text="Ly do null!";
            Qtyaddid.requestFocus();
          }
          else
          {
            txtQtySub.text= "Ly do null!";
            Qtysubid.requestFocus();
          }
        }
        else
        {
          Reason = dropdownvalue;
          _callapi.TBL_Posdiffrence_Add(GRTranID, QtyOld, QtyNew, Create_User, Typediff, Reason).then((value) {
            if(value == true)
            {
              thongbaoThanhcong(context, "Post Difference thanh cong");
              reset();
            }
            else
            {
              thongbaoNG(context, "Khong the Update");
              txtQtyAdd.text = '';
              Qtyaddid.requestFocus();
            }
          });

          Navigator.of(context, rootNavigator: true).pop(true);
        }
        //print(Reason);
        //Navigator.of(context, rootNavigator: true).pop(true); // dismisses only the dialog and returns true
      },
    );
    Widget cancelButton = TextButton(
      child: Text("NO"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop(false); // dismisses only the dialog and returns false
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Thong bao"),
      content: Text("${thongbao} \n Xac nhan?"),
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

  showAlertDialog_Unlock(BuildContext context) {
    // truong hop checking hang thieu
    Widget continueButton = TextButton(
      child: Text("YES"),
      onPressed: () {
        //btnUNLOCK.Enabled = true;
        String Barcode = txtCode.text.toString();
        _callapi.UnLockMaterial_ByListID_mobile(Barcode).then((value) {
            if(value == true)
            {
                thongbaoThanhcong(context, "UNLOCK thanh cong!");
                reset();
            }
            else
            {
              thongbaoNG(context, "UNLOCK that bai!");
              txtCode.text="";
              codedid.requestFocus();
            }
        });

        Navigator.of(context, rootNavigator: true).pop(true); // dismisses only the dialog and returns true
      },
    );
    Widget cancelButton = TextButton(
      child: Text("NO"),
      onPressed: () {
        txtCode.text ='';
        codedid.requestFocus();
        //reset();
        Navigator.of(context, rootNavigator: true).pop(false); // dismisses only the dialog and returns false
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Thong bao"),
      content: Text("Ban muon UNLOCK ma hang nay! \n Xac nhan?"),
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

  showAlertDialog_YesNo(BuildContext context) {
    // truong hop checking hang thieu
    Widget continueButton = TextButton(
      child: Text("YES"),
      onPressed: () {
        //btnUNLOCK.Enabled = true;
        Navigator.of(context, rootNavigator: true).pop(true); // dismisses only the dialog and returns true
      },
    );
    Widget cancelButton = TextButton(
      child: Text("NO"),
      onPressed: () {
        txtCode.text = '';
        codedid.requestFocus();
        Navigator.of(context, rootNavigator: true).pop(false); // dismisses only the dialog and returns false
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Thong bao"),
      content: Text("Box nay dang bi khoa! \n Ban muon Unlock?"),
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
        txtCode.text = "";
        txtQtyAdd.text = "";
        txtQtySub.text = "";
        codedid.requestFocus();

        lblQtyAvaiable = '';
        _groupValue = '';
        _obj_TBLGRTrans = [];
    });

  }





}