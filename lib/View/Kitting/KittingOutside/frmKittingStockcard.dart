import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../../../Controller/Kitting/KittingOutside/api_kittingStockCard.dart';
import 'MenuKittingOutside.dart';

import 'package:flutter_datawedge/models/scan_result.dart';
import 'package:flutter_datawedge/flutter_datawedge.dart';
import 'dart:io';

/*void main() {
  runApp(new KittingFA());
}*/

class KittingStockcard extends StatelessWidget {
  const KittingStockcard({Key? key, required this.UserID}) : super(key: key);
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

  //Class_KittingDIP _call_api_kittingdip =  new Class_KittingDIP();
  ClassKittingStockcard _call_api_kittingstokcard = new ClassKittingStockcard();

  var txtPartCard = new TextEditingController();
  var txtAct_Qty = new TextEditingController();
  var txtReploc = new TextEditingController();
  //var txtTotal_Qty = new TextEditingController();

  var focusNode = FocusNode(); //gia tri focus
  final FocusNode partcardid = FocusNode();
  late FocusNode actualqtyid = FocusNode();
  late FocusNode replocid = FocusNode();

  String type_stockcard = "";

  String lblTotal = '';
  String lblcombine = '';

  String vender = '';
  String DA = '';
  String DeliveryDate = '';
  String PONo = '';
  String PoNo_item = '';
  String material = '';
  String Qty = '';
  String is_sloc = '';
  String rep_sloc = '';
  String barcode = '';
  String flagtype = '';
  String barcodeID = '';

  //bool txtPartCardEnabled = true;
  //bool txtCodeEnabled = true;
  //bool txtAct_QtyEnabled = true;

  //txtPartCard

  @override
  // Method that call only once to initiate the default app.
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initScanner();
    });
  }

  void initScanner() {
    if (Platform.isAndroid) {
      fdw = FlutterDataWedge(profileName: 'FlutterDataWedge');
      onScanResultListener = fdw.onScanResult.listen((result) => setState(() {
            if (partcardid.hasFocus) {
              //print('abc');
              txtPartCard.text = result.data;
              partcardid_function(result.data, context);
            }
            /*else if(replocid.hasFocus)
        {
          txtReploc.text = result.data;
          button_clickOK(result.data, context);
        }*/
          }));
    }

    //print('Logger: initScanner ${replocid.hasFocus}');
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    partcardid.dispose();
    replocid.dispose();
    actualqtyid.dispose();
    super.dispose();

    onScanResultListener.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(const Duration(),
    //     () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
    return Scaffold(
        appBar: AppBar(
          title: Text('Kitting Stock Card'),
        ),
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
                      onSubmitted: (value) async {
                        //partcardid_function(value, context);
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
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Act Qty',
                              hintText: '',
                            ),
                            onSubmitted: (value) {
                              if (value != '') {
                                if (value != "0") {
                                  txtReploc..text = "";
                                  replocid.requestFocus();
                                } else {
                                  thongbao_NG(context, "NG! So luong = 0");
                                  txtAct_Qty.text = '';
                                  actualqtyid.requestFocus();
                                }
                              } else {
                                thongbao_NG(context, "Ban chua nhap so luong");
                                //txtAct_Qty.text='';
                                actualqtyid.requestFocus();
                              }
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
                            /* child: TextField(
                                controller: txtTotal_Qty,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),*/
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
                      controller: txtReploc,
                      focusNode: replocid,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Reploc',
                        hintText: '',
                      ),
                      onSubmitted: (value) {
                        button_clickOK(value, context);
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
                        const SizedBox(
                          width: 20.0,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 15.0),
                          child: ElevatedButton(
                            child: Text('OK'),
                            onPressed: () {
                              button_clickOK(
                                  txtReploc.text.toString(), context);
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
          ),
        ));
  }

  void partcardid_function(String value, BuildContext context) async {
    try {
      if (value == "") {
        thongbao_NG(context, "du lieu null!");
        partcardid.requestFocus();
      } else {
        var chuoi = txtPartCard.text.toString();
        List<String>? itemList;
        itemList = chuoi.split(";");
        //print('leng partcard:');
        //print(itemList[0].toString());
        //print(itemList.length);

        var _PK_SMT = chuoi.substring(chuoi.length - 6, chuoi.length);
        var _checkPart_8kytu = chuoi.substring(chuoi.length - 1, chuoi.length);
        //print(_PK_SMT);
        //print(_checkPart_8kytu);

        //kiem tra xem partcard da duoc scan hay chua???
        String _barcode = txtPartCard.text.toString();
        //print(_barcode);

        //type_stockcard = ( await _call_api_kittingstokcard.procKitting_check_stockcard_urgent(_barcode)!);
        // if(type_stockcard == "1")
        // {
        // }
        // else
        // {
        // }
        _call_api_kittingstokcard
            .procKitting_check_stockcard_urgent(_barcode)
            .then((value1) async {
          if (value1 == "1") {
            //chua duoc scan
            //VF001;K230207002;1;02/07/2023;P230207002;0001;L0AD01A00024;18480;18480;1;S230003;00001
            //phieu kho khong DA  ==> print stock card auto GR (12 ky tu)
            //DYNAPAC;K210811027;1;08/11/2021;P210811027;0001;PNPN1476ZA/V1;556;556;1;2100000601;00001
            //phieu kho co DA  ==> nha cung cap in   (12 ky tu)
            //21039480;2100000166;4;08/09/2021;4500230527;25;H20463700BP;340;34;10;CIC-09-08-2021;00007
            if (itemList != null && itemList.length == 12) {
              //print('phieu kho 12 kytu');
              vender = itemList[0].toString();
              DA = itemList[1].toString();
              DeliveryDate = itemList[3].toString();
              PONo = itemList[4].toString();
              PoNo_item = itemList[5].toString();
              material = itemList[6].toString();
              Qty = itemList[7].toString();
              barcode = txtPartCard.text.toString();
              txtAct_Qty.text = Qty;
              //txtAct_Qty.selection = TextSelection(baseOffset: 0, extentOffset: txtAct_Qty.text.length);
              //actualqtyid.requestFocus();

              txtReploc.text = "";
              // Now, after the widget is rebuilt, request focus

              setState(() {
                flagtype = "1";
                lblTotal = Qty;
                replocid.requestFocus();
              });

              print('Logger: initScanner ${replocid.hasFocus}');


              return;
            }

            //K210809001;VB002;ZD3EPA502D17;VC01;2190;2;08/09/2021;S
            //2300000092;VE114;PNPK3717014PA/V1;VR01;1142;2000;03/15/2023;S
            //1.Stock card DA & QM(Local
            //phieu kho QM   (8 ky tu)
            //K210809001;VB002;ZD3EPA502D17;VC01;2190;2;08/09/2021;S  ==> check o dau???  ==> check trong bang (from tblDATotal where DANo='K210809001' and Material='ZD3EPA502D17')
            //DA;Vender;Material;plan;sloc;Qty;Pstdate;S
            //21080901069;VR01;1210;C2HBCY000157;6720;08/09/2021;VB012;91027927;PK_SMT      (9ky tu)
            //barcode.BCData = (dr["BarcodeID"] + ";" + dr["Plant"] + ";" + dr["Sloc"] + ";" + dr["Material"] + ";" + dr["Quantity"] + "
            //5.Stock card OVS for SMT store (Print by Mobile printer) using to print panacim label  check==> [EDISystem].[dbo].[tblTestTool]
            //202108060018;VC01;2210;PNLB2059ZA-IG;7008;VF020;2100000134;PK_SMT      (8ky tu) (thieu truong ngay)
            else if (_PK_SMT == "PK_SMT") {
              print('phieu kho dang PK_SMT');
              if (itemList != null && itemList.length == 9) {
                vender = itemList[6].toString();
                DA = itemList[0].toString();
                DeliveryDate = itemList[5].toString();
                material = itemList[3].toString();
                Qty = itemList[4].toString();
                barcode = txtPartCard.text.toString();

                setState(() {
                  flagtype = "3";
                  lblTotal = Qty;
                });
                txtAct_Qty.text = Qty;
                //txtAct_Qty.selection = TextSelection(baseOffset: 0, extentOffset: txtAct_Qty.text.length);
                //actualqtyid.requestFocus();
                txtReploc.text = "";
                replocid.requestFocus();
              } else {
                //arr_PartCard.Length == 8 (ky tu)
                //hang mobine printer
                //202108060018;VC01;2210;PNLB2059ZA-IG;7008;VF020;2100000134;PK_SMT      (8ky tu) (thieu truong ngay)
                vender = itemList![5].toString();
                DA = itemList[0].toString();
                //DeliveryDate = arrList_PartCard[6].ToString().Trim();
                material = itemList[3].toString();
                Qty = itemList[4].toString();
                barcode = txtPartCard.text.toString();

                setState(() {
                  flagtype = "4";
                  lblTotal = Qty;
                });
                txtAct_Qty.text = Qty;
                //txtAct_Qty.selection = TextSelection(baseOffset: 0, extentOffset: txtAct_Qty.text.length);
                //actualqtyid.requestFocus();
                txtReploc.text = "";
                replocid.requestFocus();
              }
            } else if (itemList != null && itemList.length == 8) {
              if (_checkPart_8kytu == "S") {
                //phieu kho Stock card DA & QM
                vender = itemList![1].toString();
                DA = itemList[0].toString();
                DeliveryDate = itemList[6].toString();
                material = itemList[2].toString();
                Qty = itemList[5].toString();

                barcode = txtPartCard.text.toString();
                setState(() {
                  flagtype = "2";
                  lblTotal = Qty;
                });
                txtAct_Qty.text = Qty;
                //txtAct_Qty.selection = TextSelection(baseOffset: 0, extentOffset: txtAct_Qty.text.length);
                //actualqtyid.requestFocus();
                txtReploc.text = "";
                replocid.requestFocus();
              } else {
                thongbao_NG(context, "Stock card khong dung dinh dang!");
                txtPartCard.text = '';
                partcardid.requestFocus();
              }
            } else if (itemList != null && itemList.length == 3) {
              //bar code in tay cho PMG va FE   (3 ky tu)
              //8100PSN04473*;VB020;ZM9SANTO10173K108     //invoice;vender;mahang
              vender = itemList![1].toString();
              //DA = arrList_PartCard[0].ToString().Trim();
              //DeliveryDate = arrList_PartCard[5].ToString().Trim();
              material = itemList[2].toString();
              //Qty = arrList_PartCard[4].ToString().Trim();
              barcode = txtPartCard.text.toString();

              setState(() {
                flagtype = "5";
                lblTotal = "0";
              });

              txtAct_Qty.text = Qty;
              //txtAct_Qty.selection = TextSelection(baseOffset: 0, extentOffset: txtAct_Qty.text.length);
              //actualqtyid.requestFocus();
              txtReploc.text = "";
              replocid.requestFocus();
            }

            txtReploc.text = "";
            replocid.requestFocus();
          } else {
            if (value != 'err_time_out') {
              thongbao_NG(
                  context, "Loi API: procKitting_check_stockcard_urgent");
              txtPartCard.text = '';
              partcardid.requestFocus();
            } else {
              thongbao_NG(context, "Connect time out!");
              txtPartCard.text = '';
              partcardid.requestFocus();
            }
          }
        });
      }
    } catch (e) {
      thongbao_NG(context, e.toString());
    }
  }

  void button_clickOK(String value, BuildContext context) {
    if (value != '') {
      if (txtAct_Qty.text == "" || txtPartCard.text == "") {
        thongbao_NG(context, "Data is null");
        replocid.requestFocus();
      } else {
        var chuoi2 = txtPartCard.text.toString();
        List<String>? itemList2;
        itemList2 = chuoi2.split(";");
        String barcodeID = itemList2[0].toString();

        String qty_act = txtAct_Qty.text.toString();
        String reploc = txtReploc.text.toString();
        String userkitting = datauser;

        if(reploc.length > 4)
        {
          thongbao_NG(context, "Sloc qua 4 ky tu!");
          txtReploc.text="";
          replocid.requestFocus();
        }
        else
        {
          if (int.parse(qty_act) > int.parse(lblTotal)) {
            thongbao_NG(context, "So luong input > so luong phieu kho!");
            txtAct_Qty.text = "";
            actualqtyid.requestFocus();
          }
          else
          {
            _call_api_kittingstokcard
                .procKitting_kitting_stockcard2(
                vender,
                DA,
                DeliveryDate,
                PONo,
                PoNo_item,
                material,
                qty_act,
                barcode,
                reploc,
                userkitting,
                flagtype,
                barcodeID)
                .then((value) {
              if (value == '1') {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.green,
                        content: Text(
                          "Thanh cong!",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    });
                reset();
              } else {
                thongbao_NG(context, "NG! Lien He IT check thong tin!");
                txtReploc.text = "";
                replocid.requestFocus();
              }
            });
          }
        }

      }
    } else {
      thongbao_NG(context, "RepSloc khong co du lieu!");
      txtReploc.text = "";
      replocid.requestFocus();
    }
  }

  void thongbao_NG(BuildContext context, String thongbao) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.red,
            content: Text(
              '$thongbao',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          );
        });
  }

  void reset() {
    setState(() {
      txtPartCard.text = "";
      txtAct_Qty.text = "";
      txtReploc.text = "";

      partcardid.requestFocus();

      lblTotal = '';
      lblcombine = '';
      vender = '';
      DA = '';
      DeliveryDate = '';
      PONo = '';
      PoNo_item = '';
      material = '';
      Qty = '';
      is_sloc = '';
      rep_sloc = '';
      barcode = '';
      flagtype = '';
      barcodeID = '';
    });
  }
}
