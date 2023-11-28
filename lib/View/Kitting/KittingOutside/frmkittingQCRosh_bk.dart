import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../../../Controller/Kitting/KittingOutside/api_kittingQCRosh.dart';
import '../../../Model/Kitting/KittingOutside/Class_KittingQCRosh.dart';
import 'MenuKittingOutside.dart';

import 'package:flutter_datawedge/models/scan_result.dart';
import 'package:flutter_datawedge/flutter_datawedge.dart';
import 'dart:io';

/*void main() {
  runApp(new KittingFA());
}*/

class KittingQCRosh extends StatelessWidget {

  const KittingQCRosh({Key? key, required this.UserID}) : super(key: key);
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

  APIKittingQCRosh _call_api_kittingouside = new APIKittingQCRosh();
  List<Get_TBLGRTrans> _obj_dt_GRtran = List.empty();

  var txtPartCard = new TextEditingController();
  var txtAct_Qty = new TextEditingController();
  var txtBarcode = new TextEditingController();

  var focusNode = FocusNode();  //gia tri focus
  final FocusNode partcardid = FocusNode();
  late FocusNode actualqtyid = FocusNode();
  late FocusNode bacodeid = FocusNode();

  String lblTotal ='';

  String _pullistid2 ='';
  String _material2 ='';
  String _deliverydate2='';
  String _plant2 ='';
  String _line2='';
  String _qty2='';

  String lblcombine ='';

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
          //Partcardid_function(result.data, context);
        }
        else if(bacodeid.hasFocus)
        {
          txtBarcode.text = result.data;
          //await button_clickOK(result.data, context);
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

    onScanResultListener.cancel();
  }

  @override
  Widget build(BuildContext context) {
    //Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
    return
      Scaffold(
          appBar: AppBar(title: Text('Kitting Outside Export FA'),),
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
                              onSubmitted:(value) {
                                Actualid_function(value, context);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                            height: 50.0,
                          ),
                          Text(' / ',style: TextStyle(fontSize: 30,color: Colors.blue, fontWeight: FontWeight.bold),),
                          SizedBox(
                              width: 90.0,
                              height: 50.0,
                              child: lblTotal == ''? Card(child: Text('0',style: TextStyle(fontSize: 25,color: Colors.blue, fontWeight: FontWeight.bold),)):
                              Card(child: Text('${lblTotal}',style: TextStyle(fontSize: 25,color: Colors.blue, fontWeight: FontWeight.bold),))
                          )
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
                        onSubmitted: (value) async
                        {
                          await button_clickOK(value, context);
                        },

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
                                Navigator.push(context, new MaterialPageRoute(builder: (context) => new MenuKittingOutside(UserID: datauser)));
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
                              child: Text('Submit'),
                              onPressed: () async {
                                 await button_clickOK(txtBarcode.text.toString(), context);
                              },
                            ),
                          ),
                        ],
                      ),



                      SizedBox(
                        height: 10.0,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 50.0,
                            height: 10.0,
                          ),
                          Text('User : ${datauser}',style: TextStyle(fontSize: 16,color: Colors.blue, fontWeight: FontWeight.bold),),
                          SizedBox(
                            width: 50.0,
                            height: 10.0,
                          ),
                          Text('${lblcombine}',style: TextStyle(fontSize: 16,color: Colors.blue, fontWeight: FontWeight.bold),),

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

  void Actualid_function(String value, BuildContext context) {
    if(value != '')
    {
      /*String soluong = txtAct_Qty.text.toString();
      String _userid = datauser;
      String sltong = lblTotal;*/
      txtBarcode.text="";
      bacodeid.requestFocus();
    }
    else
    {
      thongbaoNG(context, "vui lòng input số lượng");
      txtAct_Qty.text='';
      actualqtyid.requestFocus();
    }
  }

  void Partcardid_function(String value, BuildContext context) {
    if (value == "")
    {
      thongbaoNG(context, "Du lieu null!");
      partcardid.requestFocus();
    }
    else
    {
      //16;K4AC02B00068;TF;6;VR01;01/30/2023;1170;DIP-PL-6A3-2A;1R17;311;EXPORT;OUTSIDE
      // kiem tra xem dung dang Export bang Tool kitting moi khong?
      var chuoi = txtPartCard.text.toString();
      List<String>? itemList;
      itemList = chuoi.split(";");
      var check_export = chuoi.substring(chuoi.length - 14,chuoi.length);
      print(check_export);
      if(itemList.isNotEmpty && check_export=='EXPORT;OUTSIDE')
      {
        _pullistid2 = itemList[0].toString();
        _material2 = itemList[1].toString();
        _deliverydate2 = itemList[5].toString();
        _plant2 = itemList[4].toString();
        _line2 = itemList[2].toString();
        _qty2 = itemList[3].toString();

        //print(_pullistid2);
        //print(_material2);
        //print(_deliverydate2);
        //print(_plant2);
        //print(_line2);
        //print(_qty2);
        // kiem tra xem no da duoc kitting export chua?
        //dt1 = cnn.TableWithParameter("procKitting_check_kitting_outside", objb1, obvb1);
        _call_api_kittingouside.procKitting_check_kitting_outside(_pullistid2).then((value) {
            if(value == '1')
            {
              setState(() {
                lblTotal = _qty2;
              });
              txtAct_Qty.text = _qty2;
              txtAct_Qty.selection = TextSelection(baseOffset: 0, extentOffset: txtAct_Qty.text.length);
              actualqtyid.requestFocus();
            }
            else
            {
              thongbaoNG(context, "Hang da duoc xuat!");
              partcardid.requestFocus();
            }
        });

      }
      else
      {
        thongbaoNG(context, "part card sai dinh dang!");
        partcardid.requestFocus();
      }


    }
  }

  Future<void> button_clickOK(String value, BuildContext context) async {
    if(value != '')
    {
      String soluong = txtAct_Qty.text.toString();
      String _userid = datauser;
      var chuoi2 = txtBarcode.text.toString();
      List<String>? itemList2;
      itemList2 = chuoi2.split(";");
      //print(chuoi2);
      //print(itemList2.length);
      if(itemList2.length == 12)
      {
        //kiem tra material tren phieu kho va partcard
        String check_material = itemList2[6].toString();
        if(check_material !=  _material2)
        {
          thongbaoNG(context, "Barcode khong dung");
          txtBarcode.text='';
          bacodeid.requestFocus();
        }
        else
        {
          //check barcode co trong bang tblGRTran
          String barcode=  txtBarcode.text.toString();
          //check storage da duoc luu kho hay chua?
          _call_api_kittingouside.ROSH_CHECKSTORAGE(barcode).then((value) {
            if(value == '-2')
            {
              //Ma nay da duoc storage
              print('Ma nay da duoc storage');
              //procKitting_check_kitting_outside_update_rosh
              //truong hop normal
              //update hang thieu
              _call_api_kittingouside.procKitting_check_kitting_outside_update_rosh(_pullistid2, soluong, _userid).then((value1) {
                if(value1 == '1')
                {
                  String quantity = soluong;
                  String status = '1';   //truong QC rosh status = 1
                  String userid = datauser;
                  //RoshQCHistory_INSERT   //Insert into tblRoshQCHistory
                  _call_api_kittingouside.RoshQCHistory_INSERT(barcode, quantity, status, userid).then((value2) async {
                    if(value2 == '1')
                    {
                      //lay gia tri so luong con trong code box
                      String Barcode = txtBarcode.text.toString();
                      _obj_dt_GRtran = (await _call_api_kittingouside.Get_TBLGRTrans_outside(Barcode))!;
                      if(_obj_dt_GRtran.length > 0)
                      {
                        //update so luong code box
                        /*TBL_Posdiffrence_Add(dtgettran.Rows[0]["GRTranID"].ToString()
                            , float.Parse(dtgettran.Rows[0]["AvaiableQuantity"].ToString())
                            , float.Parse(soluong), _userid, 0, "QCGETROSHINW");*/

                        String GRTranID = _obj_dt_GRtran[0].GRTranID.toString();
                        String QtyOld = _obj_dt_GRtran[0].AvaiableQuantity.toString();
                        String QtyNew = txtAct_Qty.text.toString();
                        String Create_User = datauser;
                        String Typediff = '1';
                        String Reason = 'QCGETROSHINW';

                        //cap nhat so luong ton code box
                        _call_api_kittingouside.TBL_Posdiffrence_Add(GRTranID, QtyOld, QtyNew, Create_User, Typediff, Reason).then((value5) {
                        });

                        thongbaoThanhcong(context,"Thanh Cong!");
                        reset();

                      }
                      else
                      {
                        thongbaoNG(context, "NG, Loi so luong code box!");
                        txtBarcode.text='';
                        bacodeid.requestFocus();
                      }

                    }
                    else
                    {
                      thongbaoNG(context, "NG, insert history rosh!");
                      txtBarcode.text='';
                      bacodeid.requestFocus();
                    }
                  });


                }
                else
                {
                  thongbaoNG(context, "NG!!!");
                  txtBarcode.text="";
                  bacodeid.requestFocus();
                }

              });

            }
            else
            {
              print('chua duoc luu kho storage');
              //procKitting_check_kitting_outside_update_rosh
              //truong hop normal
              _call_api_kittingouside.procKitting_check_kitting_outside_update_rosh(_pullistid2, soluong, _userid).then((value3) {
                  if(value3 == '1')
                  {
                    //RoshQCHistory_INSERT
                    String quantity = soluong;
                    String status = '0';   //truong hop Normal status = 0
                    String userid = datauser;
                    _call_api_kittingouside.RoshQCHistory_INSERT(barcode, quantity, status, userid).then((value4) {
                        if(value4 == '1')
                        {
                          thongbaoThanhcong(context, "Thanh cong!");
                          reset();
                        }
                        else
                        {
                          thongbaoNG(context, 'NG kitting!');
                          txtBarcode.text='';
                          bacodeid.requestFocus();
                        }
                    });

                  }
                  else
                  {
                    thongbaoNG(context, 'NG kitting!');
                    txtBarcode.text='';
                    bacodeid.requestFocus();
                  }

              });

            }
          });


        }
      }
      else
      {
          thongbaoNG(context, "Barcode sai ding dang");
          txtBarcode.text='';
          bacodeid.requestFocus();
      }

    }
    else
    {
      thongbaoNG(context, "Ban phai scan code box!");
      txtBarcode.text="";
      partcardid.requestFocus();
    }
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
      txtAct_Qty.text='';
      txtBarcode.text='';
      partcardid.requestFocus();

      lblTotal='';
    });
  }



}