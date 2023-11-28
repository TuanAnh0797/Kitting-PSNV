import 'dart:async';
//import 'dart:html';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../../../Controller/Kitting/KittingOutside/api_kittingReceiveOutside.dart';
import '../../../Model/Kitting/KittingOutside/Class_KittingReceiveOutside.dart';
import 'MenuKittingOutside.dart';

import 'package:flutter_datawedge/models/scan_result.dart';
import 'package:flutter_datawedge/flutter_datawedge.dart';
import 'dart:io';


/*void main() {
  runApp(new KittingFA());
}*/

class KittingReceiveFA extends StatelessWidget {
  const KittingReceiveFA({Key? key, required this.UserID}) : super(key: key);
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
      home: new ExampleWidget(
        datauser: UserID,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ExampleWidget extends StatefulWidget {
  ExampleWidget({Key? key, required this.datauser}) : super(key: key);
  final String datauser;

  @override
  _ExampleWidgetState createState() =>
      new _ExampleWidgetState(datauser: datauser);
}

class _ExampleWidgetState extends State<ExampleWidget> {
  _ExampleWidgetState({required this.datauser});
  final String datauser;

  //bien focus
  late StreamSubscription<ScanResult> onScanResultListener;
  late FlutterDataWedge fdw;

  KittingOutsideReceive _call_api_kittingouside = new KittingOutsideReceive();
  List<Get_TBLGRTrans> _obj_dt_GRtran = List.empty();

  var txtPartCard = new TextEditingController();
  var txtAct_Qty = new TextEditingController();
  var txtBarcode = new TextEditingController();

  var focusNode = FocusNode(); //gia tri focus
  final FocusNode partcardid = FocusNode();
  late FocusNode actualqtyid = FocusNode();
  late FocusNode bacodeid = FocusNode();

  String lblTotal = '';
  //String lblcombine ='';
  String lblQtyAvaiable = '';

  String _pullistid2 = '';
  String _material2 = '';
  String _deliverydate2 = '';
  String _plant2 = '';
  String _line2 = '';
  String _qty2 = '';

  String _groupValue = '';
  void checkRadio(String value) {
    setState(() {
      _groupValue = value;
    });
  }

  //bool txtPartCardEnabled = true;
  //bool txtCodeEnabled = true;
  //bool txtAct_QtyEnabled = true;

  //txtPartCard

  @override
  // Method that call only once to initiate the default app.
  void initState() {
    super.initState();
    _groupValue = "Normal";
    initScanner();
  }

  void initScanner() {
    if (Platform.isAndroid) {
      fdw = FlutterDataWedge(profileName: 'FlutterDataWedge');
      onScanResultListener = fdw.onScanResult
          .listen((result) => setState(() {
        if(partcardid.hasFocus)
        {
          //print('abc');
          txtPartCard.text = result.data;
          Partcardid_function(result.data, context);
        }
        /*else if(actualqtyid.hasFocus)
        {
          txtAct_Qty.text = result.data;
          Actualid_fucntion(result.data, context);
        }*/
        else if(bacodeid.hasFocus)
        {
          txtBarcode.text = result.data;
          button_clickOK(result.data, context);
        }

      } ));
    }
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    partcardid.dispose();
    bacodeid.dispose();
    actualqtyid.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Future.delayed(const Duration(),() => SystemChannels.textInput.invokeMethod('TextInput.hide'));
    return Scaffold(
        appBar: AppBar(
          title: Text('Kitting Outside Receive FA'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Row(children: [
              Radio<String>(
                  value: "Normal",
                  groupValue: _groupValue,
                  onChanged: (value) {
                    checkRadio(value as String);
                  }),
              Text("Normal"),
              const SizedBox(
                width: 30.0,
              ),
              Radio<String>(
                  value: "NG",
                  groupValue: _groupValue,
                  onChanged: (value) {
                    checkRadio(value as String);
                  }),
              Text("NG"),
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
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 80.0,
                        height: 50.0,
                        child: TextField(
                          controller: txtAct_Qty,
                          focusNode: actualqtyid,
                          //readOnly: true,
                          //showCursor: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Act Qty',
                            hintText: '',
                          ),
                          keyboardType: TextInputType.number,
                          onSubmitted: (value) {
                            Actualid_fucntion(value, context);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                        height: 50.0,
                      ),
                      Text(
                        ' / ',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                          width: 90.0,
                          height: 50.0,
                          child: lblTotal == ''
                              ? Card(
                                  child: Text(
                                  '0',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ))
                              : Card(
                                  child: Text(
                                  '${lblTotal}',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                )))
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: txtBarcode,
                    focusNode: bacodeid,
                    readOnly: true,
                    showCursor: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Barcode',
                      hintText: '',
                    ),
                    onSubmitted: (value) async {
                      //await button_clickOK(value, context);
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
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        new MenuKittingOutside(
                                            UserID: datauser)));
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
                          child: Text('Submint'),
                          onPressed: () {
                            //submit
                            if (_groupValue == 'NG') {
                              String soluong = txtAct_Qty.text.toString();
                              String _userid = datauser;
                              String sltong = lblTotal;
                              button_click_NG(soluong, sltong, _userid, context);
                            }
                            else
                            {
                              //_groupValue == 'Normal'
                              button_clickOK(txtBarcode.text.toString(),context);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 90.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 50.0,
                        height: 50.0,
                      ),
                      Text(
                        'User : ${datauser}',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 50.0,
                        height: 50.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void Actualid_fucntion(String value, BuildContext context) {
    if (value != '')
    {
      String soluong = txtAct_Qty.text.toString();
      String _userid = datauser;
      String sltong = lblTotal;
      if (double.parse(soluong) >double.parse(sltong)) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.red,
                content: Text('So luong nhap > so luong partcard!',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
                ),
              );
            });
        txtAct_Qty.text = '';
        actualqtyid.requestFocus();
      }
      else
      {
        if (_groupValue == "Normal")
        {
          txtBarcode.text = '';
          bacodeid.requestFocus();
        }
        else
        {
          //_groupValue == "NG"
          button_click_NG(soluong, sltong, _userid, context);
        }
      }
    }
    else
    {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.red,
              content: Text(
                'Ban chua nhap so luong',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            );
          });
      //txtAct_Qty.text='';
      actualqtyid.requestFocus();
    }
  }

  void Partcardid_function(String value, BuildContext context) {
    try
    {
      if (value == "")
      {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.red,
                content: Text(
                  'Du lieu null!',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              );
            });
        partcardid.requestFocus();
      }
      else
      {
        //28957;PNDE1107YA2G232/V2;REF;3;VC01;2023-09-27;2R10;NG-FIT;21S7;311;RECEIVE;OUTSIDE
        var chuoi = txtPartCard.text.toString();
        List<String>? itemList;
        itemList = chuoi.split(";");
        var check_receive =
        chuoi.substring(chuoi.length - 15, chuoi.length);
        print(check_receive);
        if (itemList.isNotEmpty &&
            check_receive == 'RECEIVE;OUTSIDE') {
          _pullistid2 = itemList[0].toString();
          _material2 = itemList[1].toString();
          _deliverydate2 = itemList[5].toString();
          _plant2 = itemList[4].toString();
          _line2 = itemList[2].toString();
          _qty2 = itemList[3].toString();

          print(_pullistid2);
          print(_material2);
          print(_deliverydate2);
          print(_plant2);
          print(_line2);
          print(_qty2);
          // kiem tra xem no da duoc kitting export chua?
          _call_api_kittingouside.procKitting_check_kitting_outside(_pullistid2).then((value) {
            if (value == '1') {
              print('=1');
              //truong hop chua duoc kitting
              setState(() {
                lblTotal = _qty2;
                //lblcombine = 'YorN';  //receive khong co truong hop combine
              });
              txtAct_Qty.text = _qty2;
              //kiem tra hang normal hay NG
              if (_groupValue == "Normal") {
                txtBarcode.text = '';
                bacodeid.requestFocus();
              } else {
                //_groupValue == "NG"
                //txtAct_Qty.text = '';
                txtAct_Qty.text=_qty2;
                txtAct_Qty.selection = TextSelection(baseOffset: 0, extentOffset: txtAct_Qty.text.length);
                actualqtyid.requestFocus();
              }
            } else {
              //khong co truong hop cong don => vi chi co 1 phieu partcard
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.red,
                      content: Text(
                        'NG kitting!!!',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  });
              /*setState(() {
                  lblcombine = 'YorN';
                });*/
              txtPartCard.text = '';
              partcardid.requestFocus();
            }
          });
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.red,
                  content: Text(
                    'NG Dinh dang barcode Receive!',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                );
              });
          txtPartCard.text = '';
          partcardid.requestFocus();
        }
      }
    }
    catch(e)
    {
      thongbaoNG(context, e.toString());
    }

  }

  Future<void> button_clickOK(String value, BuildContext context) async {
    try
    {
      if (value != '')
      {
        String remainder = '';
        //pending
        //VF003;K221223004;1;01/02/2023;P221223004;0001;K4AC09B00007;7680;7680;1;2200000160;00001
        var chuoi2 = txtBarcode.text.toString();
        List<String>? itemList2;
        itemList2 = chuoi2.split(";");
        print(chuoi2);
        print(itemList2.length);

        if (itemList2.length == 12) {
          //kiem tra material tren phieu kho va partcard
          String check_material = itemList2[6].toString();
          if (check_material != _material2) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.red,
                    content: Text('Barcode khong dung',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
                    ),
                  );
                });
            txtBarcode.text = '';
            bacodeid.requestFocus();
          }
          else
          {
            //check barcode co trong bang tblGRTran
            String Barcode = txtBarcode.text.toString();
            _obj_dt_GRtran = (await _call_api_kittingouside.Get_TBLGRTrans_outside(Barcode))!;
            if (_obj_dt_GRtran.length > 0) {
              if (double.parse(_obj_dt_GRtran[0].GetQuantity.toString()) != 0) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.red,
                        content: Text('Barcode khong hop le',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                      );
                    });
                txtBarcode.text = '';
                bacodeid.requestFocus();
              }
              else if (double.parse(_obj_dt_GRtran[0].GetQuantity.toString()) ==0 &&double.parse(_obj_dt_GRtran[0].AvaiableQuantity.toString()) >0)
              {
                setState(() {
                  lblQtyAvaiable = _obj_dt_GRtran[0].AvaiableQuantity.toString();
                });

                String soluong = txtAct_Qty.text.toString();
                String _userid = datauser;
                String sltong = lblTotal;
                //truong hop Kitting receive khong co truong hop combine

                if(double.parse(soluong.toString()) < double.parse(sltong.toString()))
                {
                  //truong hop hang thieu
                  //update bang kho
                  //TBL_Posdiffrence_Add
                  String GRTranID = _obj_dt_GRtran[0].GRTranID.toString();
                  String QtyOld = soluong;
                  String QtyNew = txtAct_Qty.text.toString();//_obj_dt_GRtran[0].AvaiableQuantity.toString();
                  String Create_User = datauser;
                  String Typediff = '1';
                  String Reason = 'KittingOutside';
                  //cap nhat so luong ton kho
                  _call_api_kittingouside.TBL_Posdiffrence_Add(GRTranID, QtyOld, QtyNew, Create_User, Typediff, Reason).then((value5) {
                    if(value5 == true)
                    {
                      _call_api_kittingouside.procKitting_check_kitting_outside_update_thieu(_pullistid2, soluong, _userid).then((value1){
                        if(value1 == '0')
                        {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Colors.red,
                                  content: Text('Kitting NG!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
                                );
                              });
                          reset();
                        }
                        else
                        {
                          //update ton kho chuyen ra vong ngoai

                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Colors.green,
                                  content: Text('Thanh cong!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
                                );
                              });
                          reset();

                        }
                      });
                    }
                    else
                    {
                      thongbaoNG(context, "Update kho loi!");
                      txtBarcode.text = '';
                      bacodeid.requestFocus();
                    }
                  });

                }
                else
                {
                  //truong hop normal
                  //print('truong hop normal');
                  //update bang kho
                  String GRTranID = _obj_dt_GRtran[0].GRTranID.toString();
                  String QtyOld = soluong;
                  String QtyNew = txtAct_Qty.text.toString();//_obj_dt_GRtran[0].AvaiableQuantity.toString();
                  String Create_User = datauser;
                  String Typediff = '1';
                  String Reason = 'KittingOutside';

                  //cap nhat so luong ton kho
                  _call_api_kittingouside.TBL_Posdiffrence_Add(GRTranID, QtyOld, QtyNew, Create_User, Typediff, Reason).then((value5) {
                    if(value5 == true)
                    {
                      _call_api_kittingouside.procKitting_check_kitting_outside_update(_pullistid2, soluong, _userid).then((value8) {
                        if(value8 == '1')
                        {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Colors.green,
                                  content: Text('Thanh cong!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
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
                                  content: Text('NG!!!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
                                );
                              });
                          txtBarcode.text='';
                          bacodeid.requestFocus();
                        }
                      });
                    }
                    else
                    {
                      thongbaoNG(context, "Update kho loi!");
                      txtBarcode.text = '';
                      bacodeid.requestFocus();
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
                        content: Text('So luong Partcard da het!',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                      );
                    });
                txtBarcode.text = '';
                bacodeid.requestFocus();
              }
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.red,
                      content: Text('Khong co du lieu',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
                      ),
                    );
                  });
              txtBarcode.text = '';
              bacodeid.requestFocus();
            }
          }
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.red,
                  content: Text('Barcode khong dung, sai dinh dang',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                );
              });
          txtBarcode.text = '';
          bacodeid.requestFocus();
        }
      }
      else
      {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.red,
                content: Text(
                  'Ban phai scan code box!',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              );
            });
        txtPartCard.text="";
        txtBarcode.text = "";
        partcardid.requestFocus();
      }
    }
    catch(e)
    {
      thongbaoNG(context, e.toString());
    }

  }

  void button_click_NG(String soluong, String sltong, String _userid, BuildContext context) {
    if (double.parse(soluong) < double.parse(sltong)) {
      //truong hop hang thieu
      print('truong hop hang thieu');
      _call_api_kittingouside.procKitting_check_kitting_outside_update_thieu(_pullistid2, soluong, _userid).then((value1) {
        if (value1 == '0') {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.red,
                  content: Text(
                    'Hang da kitting het, kiem tra lai!',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                );
              });
          txtAct_Qty.text = '';
          actualqtyid.requestFocus();
        }
        else
        {
          //select 1,@slconlai as slconlai
          //hang NG ==> co tru kho  -> stored tru kho
          print('may vao day');
          print(_pullistid2);
          print(soluong);
          print(_userid);
          Update_Qty_ReceiveNG(soluong, _userid, context);
        }
      });
    }
    else
    {
      //truong hop normal
      print('truong hop normal');
      _call_api_kittingouside.procKitting_check_kitting_outside_update(_pullistid2, soluong, _userid).then((value2) {
        if (value2 == '1') {
          //hang NG ==> Co tru kho
          Update_Qty_ReceiveNG(soluong, _userid, context);
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.red,
                  content: Text(
                    'Time out!',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                );
              });
          txtAct_Qty.text = '';
          actualqtyid.requestFocus();
        }
      });
    }
  }

  void Update_Qty_ReceiveNG(String soluong, String _userid, BuildContext context) {
    _call_api_kittingouside.Update_Kitting_ReceiveNG(_pullistid2, soluong, _userid).then((value9) {
      if (value9 == '1') {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.green,
                content: Text('Kitting Receive hang NG Thanh cong!',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
                ),
              );
            });
        reset();
      }
      else
      {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(backgroundColor: Colors.red,
                content: Text('Kitting NG!',style: TextStyle( fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
                ),
              );
            });
        reset();
      }
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

  void reset() {
    setState(() {
      txtPartCard.text = '';
      txtAct_Qty.text = '';
      txtBarcode.text = '';
      partcardid.requestFocus();

      //lblcombine='';
      lblTotal = '';
      _groupValue = "Normal";

      _pullistid2 = '';
      _material2 = '';
      _deliverydate2 = '';
      _plant2 = '';
      _line2 = '';
      _qty2 = '';
    });
  }
}
