import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../../../Controller/Kitting/KittingOutside/api_kittingExportOutside.dart';
import '../../../Model/Kitting/KittingOutside/Class_KittingExportOutside.dart';
import 'MenuKittingOutside.dart';

import 'package:flutter_datawedge/models/scan_result.dart';
import 'package:flutter_datawedge/flutter_datawedge.dart';
import 'dart:io';

/*void main() {
  runApp(new KittingFA());
}*/

class KittingExportFA extends StatelessWidget {
  const KittingExportFA({Key? key, required this.UserID}) : super(key: key);
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

class Viewcombine {
  int ID;
  String Barcode, Qty;

  Viewcombine(this.ID, this.Qty, this.Barcode);
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

  List<Viewcombine> AddLst = <Viewcombine>[
    //ViewTable(1, "code", "0"),
    //ViewTable(2, "John", "Anderson"),
  ];
  var lastID = 1;
  String display = '';

  KittingOutsideExport _call_api_kittingouside = new KittingOutsideExport();
  List<Get_TBLGRTrans> _obj_dt_GRtran = List.empty();

  var txtPartCard = new TextEditingController();
  var txtAct_Qty = new TextEditingController();
  var txtBarcode = new TextEditingController();

  var focusNode = FocusNode(); //gia tri focus
  final FocusNode partcardid = FocusNode();
  late FocusNode actualqtyid = FocusNode();
  late FocusNode bacodeid = FocusNode();

  String lblTotal = '';
  String lblcombine = '';
  String lblQtyAvaiable = '';

  String _pullistid2 = '';
  String _material2 = '';
  String _deliverydate2 = '';
  String _plant2 = '';
  String _line2 = '';
  String _qty2 = '';

  //String _group2='';

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

  Widget showgridview() {
    return new FutureBuilder<String>(
      builder: (context, snapshot) {
        // if(snapshot.hasData){return new Text(display);}    //does not display updated text
        //f (display != null) {
        if (display == '1') {
          //print('${display}');
          //print(' vao OK');
          return createTable(context, snapshot);
        } else {
          //print('${display}');
          //print('=>NG');
          //return new Text("no data yet!");
          return createTable_null(context, snapshot);
        }
      },
      future: null,
    );
  }

  void initScanner() {
    if (Platform.isAndroid) {
      fdw = FlutterDataWedge(profileName: 'FlutterDataWedge');
      onScanResultListener =
          fdw.onScanResult.listen((result) => setState(() async {
                if (partcardid.hasFocus) {
                  txtPartCard.text = result.data;
                  Partcardid_function(result.data, context);
                }
                /*else if(actualqtyid.hasFocus)
        {
          txtAct_Qty.text = result.data;
          Actualid_function(result.data, context);
        }*/
                else if (bacodeid.hasFocus) {
                  txtBarcode.text = result.data;
                  await button_clickOK(result.data, context);
                }
              }));
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
    return Scaffold(
        appBar: AppBar(
          title: Text('Kitting Outside Export FA'),
        ),
        body: SingleChildScrollView(
          child: Column(
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
                              Actualid_function(value, context);
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
                            child: Text('Submit'),
                            onPressed: () {
                              if (_groupValue == 'NG') {
                                String soluong = txtAct_Qty.text.toString();
                                String _userid = datauser;
                                String sltong = lblTotal;
                                String value = txtAct_Qty.text.toString();
                                button_clickNG(
                                    soluong, sltong, _userid, context, value);
                              } else {
                                //_groupValue == 'Normal'
                                button_clickOK(
                                    txtBarcode.text.toString(), context);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    showgridview(),
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
                        Text(
                          'User : ${datauser}',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 50.0,
                          height: 10.0,
                        ),
                        Text(
                          '${lblcombine}',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void Actualid_function(String value, BuildContext context) {
    if (value != '') {
      String soluong = txtAct_Qty.text.toString();
      String _userid = datauser;
      String sltong = lblTotal;
      if (double.parse(soluong) > double.parse(sltong)) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.red,
                content: Text(
                  'So luong nhap > so luong partcard!',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              );
            });
        txtAct_Qty.text = '';
        actualqtyid.requestFocus();
      } else {
        if (_groupValue == "Normal") {
          txtBarcode.text = '';
          bacodeid.requestFocus();
        } else {
          //_groupValue == "NG"
          button_clickNG(soluong, sltong, _userid, context, value);
        }
      }
    } else {
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
      txtAct_Qty.text = '';
      actualqtyid.requestFocus();
    }
  }

  void Partcardid_function(String value, BuildContext context) {
    try {
      if (value == "") {
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
      } else {
        var chuoi = txtPartCard.text.toString();
        List<String>? itemList;
        itemList = chuoi.split(";");
        var check_export = chuoi.substring(chuoi.length - 14, chuoi.length);
        print(check_export);
        //16;K4AC02B00068;TF;6;VR01;01/30/2023;1170;DIP-PL-6A3-2A;1R17;311;EXPORT;OUTSIDE
        if (itemList.isNotEmpty && check_export == 'EXPORT;OUTSIDE') {
          _pullistid2 = itemList[0].toString();
          _material2 = itemList[1].toString();
          _deliverydate2 = itemList[5].toString();
          _plant2 = itemList[4].toString();
          _line2 = itemList[2].toString();
          _qty2 = itemList[3].toString();

          /*print(_pullistid2);
        print(_material2);
        print(_deliverydate2);
        print(_plant2);
        print(_line2);
        print(_qty2);*/

          // kiem tra xem no da duoc kitting export chua?
          _call_api_kittingouside
              .procKitting_check_kitting_outside(_pullistid2)
              .then((value) {
            if (value == '1') {
              print('=1');
              //truong hop chua duoc kitting
              setState(() {
                lblTotal = _qty2;
                lblcombine = 'YorN';
              });
              txtAct_Qty.text = _qty2;
              //kiem tra hang normal hay NG
              if (_groupValue == "Normal") {
                txtBarcode.text = '';
                bacodeid.requestFocus();
              } else {
                //_groupValue == "NG"
                txtAct_Qty.text = _qty2;
                txtAct_Qty.selection = TextSelection(
                    baseOffset: 0, extentOffset: txtAct_Qty.text.length);
                actualqtyid.requestFocus();
              }
            } else if (value == '0') {
              //check truong hop ban combine nhieu phieu kho -> ban co khac , quay lai -> phai duoc ban tiep
              // stored : Check_combine_hangthieu
              _call_api_kittingouside.Check_combine_hangthieu(_pullistid2)
                  .then((value) {
                if (value == '0') {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.red,
                          content: Text(
                            'Hang da duoc kitting!!!',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      });
                  setState(() {
                    lblcombine = 'YorN';
                  });
                  txtPartCard.text = '';
                  partcardid.requestFocus();
                } else {
                  String soluongconlai = value.toString();
                  print('vao truonghop nay:');
                  print(soluongconlai);
                  setState(() {
                    lblcombine = 'Yes';
                    lblTotal = soluongconlai;
                  });

                  txtAct_Qty.text = soluongconlai;
                  //txtAct_Qty.selection = TextSelection(baseOffset: 0, extentOffset: txtAct_Qty.text.length);
                  txtBarcode.text = '';
                  bacodeid.requestFocus();
                }
              });
            } else {
              if (value == 'err_time_out') {
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
                setState(() {
                  lblcombine = 'YorN';
                });
                txtPartCard.text = '';
                partcardid.requestFocus();
              } else {
                print('=> vao truong hop =2: so luong con lai:');
                print('test ky truong hop nay');
                //truong hop kitting tu nhieu stockcard
                String soluongconlai = value;
                print(soluongconlai);
                txtAct_Qty.text = soluongconlai;
                setState(() {
                  lblTotal = soluongconlai;
                  lblcombine = 'Yes';
                });
                //kiem tra hang normal hay NG
                if (_groupValue == "Normal") {
                  txtBarcode.text = '';
                  bacodeid.requestFocus();
                } else {
                  //_groupValue == "NG"
                  txtAct_Qty.text = '';
                  actualqtyid.requestFocus();
                }
              }
            }
          });
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.red,
                  content: Text(
                    'NG Dinh dang barcode Export!',
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
    } catch (e) {
      thongbaoNG(context, e.toString());
    }
  }

  Future<void> button_clickOK(String value, BuildContext context) async {
    try {
      if (value != '') {
        //21024252;2300000062;126;05/04/2023;4500265224;87;PNQT2640TA/V1;4000;2000;2;20230504-DP;00002
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
                    content: Text(
                      'Barcode khong dung',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                });
            txtBarcode.text = '';
            bacodeid.requestFocus();
          } else {
            //check barcode co trong bang tblGRTran
            String Barcode = txtBarcode.text.toString();
            _obj_dt_GRtran = (await _call_api_kittingouside.Get_TBLGRTrans_outside(Barcode))!;
            if (_obj_dt_GRtran.length > 0) {
              if (double.parse(_obj_dt_GRtran[0].GetQuantity.toString()) != 0) {
                thongbaoNG(context, "Barcode khong hop le");
                txtBarcode.text = '';
                bacodeid.requestFocus();
              }
              else if (double.parse(_obj_dt_GRtran[0].GetQuantity.toString()) ==0 &&double.parse(_obj_dt_GRtran[0].AvaiableQuantity.toString()) >0)
              {
                setState(() {
                  lblQtyAvaiable =
                      _obj_dt_GRtran[0].AvaiableQuantity.toString();
                });
                String soluong = txtAct_Qty.text.toString();
                String _userid = datauser;
                String sltong = lblTotal;
                if (lblcombine == 'Yes') {
                  //kiem tra truong hop hang kitting nhieu stockcard  ==> se update cot qty_origin
                  //cot qty_origin  = qty_origin - soluong kiting
                  //dieu kien qty_origin = Quantity_staged
                  if (double.parse(_obj_dt_GRtran[0].AvaiableQuantity.toString()) <= double.parse(sltong)) {
                    //truong hop hang thieu
                    String soluong_old = txtAct_Qty.text.toString();
                    String flagcombine = "combine";

                    //tru kho truoc => update trang thai mater sau
                    //update bang kho
                    //TBL_Posdiffrence_Add
                    String GRTranID = _obj_dt_GRtran[0].GRTranID.toString();
                    String QtyOld = soluong;
                    String QtyNew = _obj_dt_GRtran[0].AvaiableQuantity.toString();
                    String Create_User = datauser;
                    String Typediff = '1';
                    String Reason = 'KittingOutside';

                    //cap nhat so luong ton kho
                    _call_api_kittingouside.TBL_Posdiffrence_Add2(GRTranID,QtyOld, QtyNew, Create_User, Typediff, Reason).then((value5) {
                      if(value5 == true)
                      {
                        _call_api_kittingouside.procKitting_check_kitting_outside_update_thieu_combine(_pullistid2,soluong_old,_obj_dt_GRtran[0].AvaiableQuantity.toString(), _userid,flagcombine).then((value4) {
                          if (value4 == '0') {
                            thongbaoNG(context, "NG");
                            txtBarcode.text = '';
                            bacodeid.requestFocus();
                          }
                          else if (value4 == 'het')
                          {
                            print('truong hop so luong partcard - so luong codebox = 0');
                            //add item into table
                            String _ID = lastID.toString();
                            String _barcode = txtBarcode.text.trim();
                            String _soluong =_obj_dt_GRtran[0].AvaiableQuantity.toString();
                            //doi tuong obj
                            Viewcombine p =Viewcombine(int.parse(_ID), _soluong, _barcode);
                            //list -> data
                            AddLst.add(p);
                            lastID++;

                            //cap nhat ton kho duoc day len dau
                            //_call_api_kittingouside.TBL_Posdiffrence_Add2(GRTranID,QtyOld, QtyNew, Create_User, Typediff, Reason).then((value5) {});
                            thongbaoOK("Thanh Cong!");
                            reset();
                          }
                          else
                          {
                            //add item into table
                            String _ID = lastID.toString();
                            String _barcode = txtBarcode.text.trim();
                            String _soluong =
                            _obj_dt_GRtran[0].AvaiableQuantity.toString();
                            //doi tuong obj
                            Viewcombine p =Viewcombine(int.parse(_ID), _soluong, _barcode);
                            //list -> data
                            AddLst.add(p);
                            lastID++;

                            //update bang kho
                            //TBL_Posdiffrence_Add
                            //cap nhat so luong ton kho dua len dau
                            //_call_api_kittingouside.TBL_Posdiffrence_Add2(GRTranID,QtyOld, QtyNew, Create_User, Typediff, Reason).then((value5) {});
                            print('van chua scan het');
                            print(value4);
                            txtBarcode.text = '';
                            if (double.parse(value4.toString()) > 0) {
                              //van chua scan het

                              setState(() {
                                lblTotal = value4;
                                lblcombine = 'Yes';
                                display = '1';
                              });

                              txtAct_Qty.text = value4.toString();
                              bacodeid.requestFocus();
                            }
                            else
                            {
                              //scan du
                              thongbaoOK("Thanh cong!");
                              reset();
                            }
                          }
                        });
                      }
                      else
                      {
                        thongbaoNG(context, "NG, update ton kho!");
                        txtBarcode.text = '';
                        bacodeid.requestFocus();
                      }
                    });
                  }
                  else
                  {
                    // so luong stock card > so luong con lai cua partcard
                    //tru so luong stock card trong kho  ==> quan ly ton kho
                    print('so luong stock card > so luong con lai cua partcard');
                    String soluong_old = txtAct_Qty.text.toString();
                    String soluong =_obj_dt_GRtran[0].AvaiableQuantity.toString();
                    String _userid = datauser;
                    String flagcombine = 'combine';

                    //update bang kho
                    //TBL_Posdiffrence_Add
                    String GRTranID = _obj_dt_GRtran[0].GRTranID.toString();
                    /*String QtyOld = soluong;
                      String QtyNew = _obj_dt_GRtran[0].AvaiableQuantity.toString();*/
                    String QtyOld =_obj_dt_GRtran[0].AvaiableQuantity.toString();
                    String QtyNew = txtAct_Qty.text.toString();
                    String Create_User = datauser;
                    String Typediff = '1';
                    String Reason = 'KittingOutside';
                    //cap nhat so luong ton kho
                    // truong hop nay no phai tru so luong con lai cua partcard ==> so luong chuan trong kho
                    _call_api_kittingouside.TBL_Posdiffrence_Add2(GRTranID,QtyOld, QtyNew, Create_User, Typediff, Reason).then((value5) {
                      if(value5 == true)
                      {
                        _call_api_kittingouside.procKitting_check_kitting_outside_update_combine(_pullistid2,soluong_old,soluong,_userid,flagcombine).then((value5) {
                          if (value5 == '1') {
                            thongbaoOK("Thanh Cong!");
                            reset();
                          }
                          else
                          {
                            thongbaoNG(context, "NG!");
                            txtBarcode.text = '';
                            bacodeid.requestFocus();
                          }
                        });
                      }
                      else
                      {
                        thongbaoNG(context, "NG, update ton kho!");
                        txtBarcode.text = '';
                        bacodeid.requestFocus();
                      }
                    });
                  }
                }
                else
                {
                  //lan dau tien kitting so sanh bang GR tran
                  //kitting lan dau chua combine
                  print('kitting lan dau chua combine');
                  if (double.parse(_obj_dt_GRtran[0].AvaiableQuantity.toString()) <=double.parse(sltong)) {
                    print('vao 1');
                    //cap nhat so luong ton kho
                    String GRTranID = _obj_dt_GRtran[0].GRTranID.toString();
                    String QtyOld = soluong;
                    String QtyNew = _obj_dt_GRtran[0].AvaiableQuantity.toString();
                    String Create_User = datauser;
                    String Typediff = '1';
                    String Reason = 'KittingOutside';
                    _call_api_kittingouside.TBL_Posdiffrence_Add2(GRTranID,QtyOld, QtyNew, Create_User, Typediff, Reason).then((value7) async {
                        if(value7 == true)
                        {
                          _call_api_kittingouside.procKitting_check_kitting_outside_update_thieu2(_pullistid2,_obj_dt_GRtran[0].AvaiableQuantity.toString(),_userid).then((value6) {
                            if (value6 == '0')
                            {
                              thongbaoNG(context, "Kitting NG=check!!!");
                              txtBarcode.text = '';
                              bacodeid.requestFocus();
                            }
                            else if (value6 == 'het')
                            {
                              print('truong hop so luong partcard - so luong codebox = 0');
                              thongbaoOK("Thanh Cong!");
                              reset();
                            }
                            else
                            {
                              //select 1,@slconlai as slconlai   ==> tra ra so luong con lai
                              // truong hop hang combine
                              // String GRTranID = _obj_dt_GRtran[0].GRTranID.toString();
                              // String QtyOld = soluong;
                              // String QtyNew =_obj_dt_GRtran[0].AvaiableQuantity.toString();
                              // String Create_User = datauser;
                              // String Typediff = '1';
                              // String Reason = 'KittingOutside';

                              //add item into table
                              String _ID = lastID.toString();
                              String _barcode = txtBarcode.text.trim();
                              String _soluong =
                              _obj_dt_GRtran[0].AvaiableQuantity.toString();
                              //doi tuong obj
                              Viewcombine p =
                              Viewcombine(int.parse(_ID), _soluong, _barcode);
                              //list -> data
                              AddLst.add(p);
                              lastID++;

                              //cap nhat so luong ton kho
                              //_call_api_kittingouside.TBL_Posdiffrence_Add2(GRTranID,QtyOld, QtyNew, Create_User, Typediff, Reason).then((value7) async {});

                              thongbaoCombine(context,"Partcard van chua du so luong, ban phai scan tiep!");
                              setState(() {
                                lblTotal = value6;
                                lblcombine = 'Yes';
                                display = '1';
                              });
                              txtBarcode.text = '';
                              txtAct_Qty.text = value6.toString();
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
                  else
                  {
                    print('vao 2');
                    //truong hop normal  ==> khong phai hang thieu
                    //update bang kho
                    String GRTranID = _obj_dt_GRtran[0].GRTranID.toString();
                    String QtyOld = _obj_dt_GRtran[0].AvaiableQuantity.toString(); //soluong;
                    String QtyNew = txtAct_Qty.text.toString(); //_obj_dt_GRtran[0].AvaiableQuantity.toString();
                    String Create_User = datauser;
                    String Typediff = '1';
                    String Reason = 'KittingOutside';
                    //cap nhat so luong ton kho
                    _call_api_kittingouside.TBL_Posdiffrence_Add2(GRTranID,QtyOld, QtyNew, Create_User, Typediff, Reason).then((value5) {
                        if(value5 ==  true)
                        {
                          _call_api_kittingouside.procKitting_check_kitting_outside_update(_pullistid2, soluong, _userid).then((value8) {
                            if (value8 == '1') {
                              // chuyen cap nhat kho len dau
                              thongbaoOK("Thanh Cong!");
                              reset();
                            }
                            else
                            {
                              thongbaoNG(context, "NG, update Mater outside");
                              txtBarcode.text = '';
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
              } else {
                thongbaoNG(context, "So luong Partcard da het!");
                txtBarcode.text = '';
                bacodeid.requestFocus();
              }
            } else {
              thongbaoNG(context, "Khong co du lieu");
              txtBarcode.text = '';
              bacodeid.requestFocus();
            }
          }
        }
        else
        {
          thongbaoNG(context, "Barcode khong dung, sai dinh dang");
          txtBarcode.text = '';
          bacodeid.requestFocus();
        }
      }
      else
      {
        thongbaoNG(context, "Ban phai scan code box!");
        txtBarcode.text = "";
        txtBarcode.text = "";
        partcardid.requestFocus();
      }
    } catch (e) {
      thongbaoNG(context, e.toString());
    }
  }

  void thongbaoOK(String thongbao) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.green,
            content: Text(
              '${thongbao}',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          );
        });
  }

  void thongbaoCombine(BuildContext context, String thongbao) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.yellow,
            content: Text(
              '${thongbao}',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          );
        });
  }

  void thongbaoNG(BuildContext context, String thongbao) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.red,
            content: Text(
              '${thongbao}',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          );
        });
  }

  void button_clickNG(String soluong, String sltong, String _userid,
      BuildContext context, String value) {
    if (double.parse(soluong) < double.parse(sltong)) {
      //truong hop hang thieu
      print('truong hop hang thieu');
      _call_api_kittingouside
          .procKitting_check_kitting_outside_update_thieu(
              _pullistid2, soluong, _userid)
          .then((value1) {
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
        } else {
          //select 1,@slconlai as slconlai
          if (value == 'err_time_out') {
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
          } else {
            //hang NG ==> tru kho
            Update_Qty_export_NG(soluong, _userid, context);
          }
        }
      });
    } else {
      //truong hop normal
      print('truong hop normal');
      _call_api_kittingouside
          .procKitting_check_kitting_outside_update(
              _pullistid2, soluong, _userid)
          .then((value2) {
        if (value2 == '1') {
          //hang NG ==> Co tru kho
          Update_Qty_export_NG(soluong, _userid, context);
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

  void Update_Qty_export_NG(
      String soluong, String _userid, BuildContext context) {
    _call_api_kittingouside.Update_Kitting_EportNG(
            _pullistid2, soluong, _userid)
        .then((value9) {
      if (value9 == '1') {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.green,
                content: Text(
                  'Kitting export hang NG Thanh cong!',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              );
            });
        reset();
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.red,
                content: Text(
                  'Kitting NG!',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              );
            });
        reset();
      }
    });
  }

  void reset() {
    setState(() {
      txtPartCard.text = '';
      txtAct_Qty.text = '';
      txtBarcode.text = '';
      partcardid.requestFocus();

      lblcombine = '';
      lblTotal = '';
      _groupValue = "Normal";

      _pullistid2 = '';
      _material2 = '';
      _deliverydate2 = '';
      _plant2 = '';
      _line2 = '';
      _qty2 = '';

      display = '0';
      AddLst = [];

      lastID = 1;
    });
  }

  Widget createTable(BuildContext context, AsyncSnapshot snapshot) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          //height: MediaQuery.of(context).size.height * 0.3,
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: DataTable(
                columns: const [
                  DataColumn(
                    label: Text("ID"),
                  ),
                  DataColumn(
                    label: Text("Qty"),
                  ),
                  DataColumn(
                    label: Text("Barcode"),
                  ),
                ],
                rows: AddLst.map(
                  (p) => DataRow(cells: [
                    DataCell(
                      Text(p.ID.toString()),
                    ),
                    DataCell(
                      Text(p.Qty),
                    ),
                    DataCell(
                      Text(p.Barcode),
                    ),
                  ]),
                ).toList(),
              ),
            );
          })),
    );
  }

  Widget createTable_null(BuildContext context, AsyncSnapshot snapshot) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
          //height: MediaQuery.of(context).size.height * 0.25,
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
                    label: Text("ID"),
                  ),
                  DataColumn(
                    label: Text("Qty"),
                  ),
                  DataColumn(
                    label: Text("Barcode"),
                  ),
                ],
                rows: const <DataRow>[
                  DataRow(
                    cells: <DataCell>[
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
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
