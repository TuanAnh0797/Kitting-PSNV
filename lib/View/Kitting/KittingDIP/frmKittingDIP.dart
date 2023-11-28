import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../../../Controller/Kitting/KittingDIP/api_kittingDIP.dart';
import 'MenuKittingDIP.dart';

import 'package:flutter_datawedge/models/scan_result.dart';
import 'package:flutter_datawedge/flutter_datawedge.dart';
import 'dart:io';

/*void main() {
  runApp(new KittingFA());
}*/

class KittingDIP extends StatelessWidget {

  const KittingDIP({Key? key, required this.UserID}) : super(key: key);
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

class dt_objTB {
  String Barcode, Qty;
  dt_objTB(this.Barcode,this.Qty);
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

  List<dt_objTB> _objTB = <dt_objTB>[
    //ViewTable(1, "code", "0"),
    //ViewTable(2, "John", "Anderson"),
  ];

  Class_KittingDIP _call_api_kittingdip =  new Class_KittingDIP();

  var txtPartCard = new TextEditingController();
  var txtCode = new TextEditingController();
  var txtAct_Qty = new TextEditingController();

  var focusNode = FocusNode();  //gia tri focus
  final FocusNode partcardid = FocusNode();
  late FocusNode grboxid = FocusNode();
  late FocusNode actualqtyid = FocusNode();

  //bool txtPartCardEnabled = true;
  //bool txtCodeEnabled = true;
  //bool txtAct_QtyEnabled = true;

  String display = '';

  bool check_codeGR_List = false;
  String ProductDate='';
  String _Plant='';
  String Material='';
  String Model='';
  String Line='';
  String Time='';
  String Sloc='';
  String UploadNo='';
  String sloc_issue ='';

  String _material='';
  String lblQtyActual ='';
  String lblQty='';
  String _quantity = '';
  String _Sloc_Qty='';

  String _str_barcode = '';
  String _str_barcode2 = '';
  String _strValue = '';
  String _str_Qty ='';

  String str_barcode = '';
  String str_barcode2 = '';
  String strValue = '';

  String str_Qty ='';

  String stt = "0";


  //txtPartCard

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
          .listen((result) => setState(() {
        if(partcardid.hasFocus)
        {
          //print('abc');
          txtPartCard.text = result.data;
          Partcardid_function(result.data, context);
        }
        else if(grboxid.hasFocus)
        {
          txtCode.text = result.data;
          Grboxid_function(result.data, context);
        }
        else if(actualqtyid.hasFocus)
        {
             txtAct_Qty.text = result.data;
             Actualid_function(result.data, context);
        }
      } ));
    }
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    partcardid.dispose();
    grboxid.dispose();
    actualqtyid.dispose();
    super.dispose();

    onScanResultListener.cancel();
  }

  Widget showgridview() {
    return new FutureBuilder<String>(builder: (context, snapshot) {
      // if(snapshot.hasData){return new Text(display);}    //does not display updated text
      //f (display != null) {
      if (display == '1') {
        print('show grivew :${display}');
        //print(' vao OK');

        return createTable(context, snapshot);
      } else {
        print('show grivew : ${display}');
        //print('=>NG');
        //return new Text("no data yet!");
        return createTable_null(context, snapshot);
      }
    }, future: null,);
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
    return
      Scaffold(
          appBar: AppBar(title: Text('Kitting DIP'),),
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
                    TextField(
                      controller: txtCode,
                      focusNode: grboxid,
                      readOnly: true,
                      showCursor: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'GR Box',
                        hintText: '',
                      ),
                      onSubmitted: (value)
                      {
                        //Grboxid_function(value, context);
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
                            readOnly: true,
                            showCursor: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Act Qty',
                              hintText: '',
                            ),
                            onSubmitted:(value) {
                              //Actualid_function(value, context);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                          height: 50.0,
                        ),
                        SizedBox(
                            width: 90.0,
                            height: 50.0,
                            child: lblQtyActual == ''? Card(child: Text('0',style: TextStyle(fontSize: 25,color: Colors.blue, fontWeight: FontWeight.bold),)):
                            Card(child: Text('${lblQtyActual}',style: TextStyle(fontSize: 25,color: Colors.blue, fontWeight: FontWeight.bold),))
                        ),
                        Text(' / ',style: TextStyle(fontSize: 30,color: Colors.blue, fontWeight: FontWeight.bold),),
                        SizedBox(
                            width: 90.0,
                            height: 50.0,
                            child: lblQty == ''? Card(child: Text('0',style: TextStyle(fontSize: 25,color: Colors.blue, fontWeight: FontWeight.bold),)):
                            Card(child: Text('${lblQty}',style: TextStyle(fontSize: 25,color: Colors.blue, fontWeight: FontWeight.bold),))
                        )
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
                              //Navigator.push(context, new MaterialPageRoute(builder: (context) => new MenuKittingDIP(UserID: datauser)));
                              //Update so luong bang tranGR neu nhu GR => voi hang thieu
                              if(str_barcode == "")  //if (objTB.Rows.Count == 0)
                                  {
                                // quay ve trang truoc
                                reset();
                                Navigator.push(context, new MaterialPageRoute(builder: (context) => new MenuKittingDIP(UserID: datauser)));
                              }
                              else
                              {
                                //update lai so luong bang tranGR //xoa so luong da GR
                                //if (objKitting.tblGrTrans_Delete_Temp(str_barcode) == true)
                                String BarcodeArr = str_barcode2.toString();
                                _call_api_kittingdip.tblGrTrans_Delete_Temp(BarcodeArr).then((return4) {
                                  if(return4 ==  true)
                                  {
                                    //print('da xoa thanh cong!');
                                    // quay ve trang truoc
                                    reset();
                                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new MenuKittingDIP(UserID: datauser)));
                                  }
                                  else
                                  {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text('Xoa NG!'),
                                          );
                                        });
                                    print('Xoa NG!');
                                  }
                                });
                              }

                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 15.0),
                          child: ElevatedButton(
                            child: Text('Submit'),
                            onPressed: () {
                              //truong hop hang thieu
                              if(double.parse(lblQty.toString()) != double.parse(lblQtyActual.toString()) )
                              {
                                setState(() {stt='10';});
                                showAlertDialog_shortage(context);
                              }//truong hop so luong du
                              else
                              {
                                setState(() {
                                  stt='0';
                                });
                                update_kitting(context);
                              }

                            },
                          ),
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
                    Divider(),
                    showgridview(),

                  ],
                ),
              ),

            ],
          )
      );

  }

  void Actualid_function(String value, BuildContext context) {
    try
    {
      if(value != '')
      {
        if(Material == _material)
        {
          if(double.parse(txtAct_Qty.text.toString()) <= 0)
          {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('Nhap so luong'),
                  );
                });
            txtAct_Qty.text = "";
            actualqtyid.requestFocus();
          }
          else if (double.parse(_Sloc_Qty.toString()) > double.parse(txtAct_Qty.text.toString()))
          {
            //thuc hien lenh
            //_Sloc_Qty la so luong con trong bang GRTran duoc lay ra
            String Barcode=txtCode.text.toString();
            String GetQuantity = txtAct_Qty.text.toString();
            //_call_api_kittingdip.procGRTran_update(Barcode, GetQuantity).then((value) {
            _call_api_kittingdip.procGRTran_update_post(Barcode, GetQuantity).then((value) {
              if(value == true)
              {
                //AddRow(txtCode.Text.Trim(), float.Parse(txtAct_Qty.Text));
                //lblQtyActual.Text = (float.Parse(lblQtyActual.Text) + float.Parse(txtAct_Qty.Text)).ToString();
                //txtCode.Text = "";
                //txtAct_Qty.Text = "0";
                //txtCode.Focus();
                setState(() {
                  dt_objTB p = dt_objTB(Barcode,GetQuantity);
                  _objTB.add(p);
                  lblQtyActual =(double.parse(lblQtyActual.toString()) + double.parse(txtAct_Qty.toString())).toString();
                });

                txtCode.text="";
                txtAct_Qty.text="0";
                grboxid.requestFocus();
              }
              else
              {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text('Khong kitting duoc thung nay'),
                      );
                    });
                txtCode.text='';
                grboxid.requestFocus();
              }
            });

          }
          else
          {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('So luong trong thung hang chi con = ${_Sloc_Qty}'),
                  );
                });
            txtAct_Qty.text = _Sloc_Qty;
            actualqtyid.requestFocus();
          }

        }
        else
        {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text('Part card và mã GR khong khop'),
                );
              });
          txtPartCard.text='';
          txtCode.text = '';
          partcardid.requestFocus();
        }
      }
      else
      {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Ban chua nhap so luong'),
              );
            });
        //txtAct_Qty.text='';
        actualqtyid.requestFocus();
      }
    }
    catch(e)
    {
      thongbaoNG(context, e.toString());
    }
  }

  void Grboxid_function(String value, BuildContext context) {
    try
    {
      if(value != '')
      {
        String remainder ='';
        //pending
        //VF003;K221223004;1;01/02/2023;P221223004;0001;K4AC09B00007;7680;7680;1;2200000160;00001
        var chuoi2 = txtCode.text.toString();
        List<String>? itemList2;
        itemList2 = chuoi2.split(";");
        print(chuoi2);
        print(itemList2[0].toString());
        print('Materia 1 :${Material}');

        _material = itemList2[6].toString();
        print ('material : ${_material}');
        String Barcode = txtCode.text.toString();
        if(Material == _material)
        {
          //if (check_codeGR_List() == false)  //Box nay da duoc ban trong list kitting.\n Scan box khac
          if(_objTB.isEmpty)
          {
            //table null khong check
            function_kitting(context, remainder);
          }
          else
          {
            for(int i =0; i < _objTB.length;i++)
            {
              print(_objTB[i].Barcode.toString());
              if(_objTB[i].Barcode.toString() == Barcode)
              {
                check_codeGR_List = true;
                break;
              }
            }
            if(check_codeGR_List == true)
            {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.red,
                      content: Text('Box nay da duoc ban trong list kitting.\n Scan box khac!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
                    );
                  });
              txtCode.text = "";
              grboxid.requestFocus();
            }
            else
            {
              //print('scan tiep');
              function_kitting(context, remainder);
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
                  content: Text('2 MA PART CARD KHONG TRUNG NHAU!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
                );
              });
          txtCode.text = "";
          grboxid.requestFocus();
        }
      }
      else
      {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.red,
                content: Text('Ban phai scan code box!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
              );
            });
        txtCode.text = "";
        grboxid.requestFocus();
      }
    }
    catch(e)
    {
      thongbaoNG(context, e.toString());
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
                content: Text('du lieu null!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
              );
            });
        partcardid.requestFocus();
      }
      else
      {
        var chuoi = txtPartCard.text.toString();
        List<String>? itemList;
        itemList = chuoi.split(";");

        //print('leng partcard:');
        //print(itemList[0].toString());
        //print(itemList.length);

        ProductDate=itemList[6].toString();
        _Plant=itemList[7].toString();
        Material=itemList[1].toString();
        Model=itemList[0].toString();
        Line=itemList[2].toString();
        Time=itemList[8].toString();
        Sloc=itemList[5].toString();
        UploadNo=itemList[10].toString();
        sloc_issue = itemList[5].toString();

        if (itemList != null && itemList.length == 14)
        {
          //var output = chuoi[chuoi.length - 3];
          var _checkitting_dip = chuoi.substring(chuoi.length - 3,chuoi.length);
          print(_checkitting_dip);
          if (_checkitting_dip == "DIP") {
            //kiem tra xem duoc kititng dip chua
            // kiem tra trong bang tblKitting_Trans_PartCard_Temp
            String BarcodePartcard = txtPartCard.text.toString();
            //_call_api_kittingdip.Check_Partcard_kittingTrans(BarcodePartcard).then((value) {
            _call_api_kittingdip.Check_Partcard_kittingTrans_post(BarcodePartcard).then((value) {
              if (value == '0')
              {
                //chua duoc kitting
                //Check_exit_Pullist = _kitting_partcard.DataKittingDIP_getByPartCard_new
                //kiem tra checking trong bang mater
                //print(ProductDate);
                //print(Plant);
                //print(Material);
                //print(Model);
                //print(Line);
                //print(Time);
                //print(Sloc);
                //print(UploadNo);
                String Plant = _Plant;
                //_call_api_kittingdip.procDataKittingDIP_getByPartCard_new(ProductDate, Plant, Material, Model, Line, Time, Sloc, UploadNo).then((value2) {
                _call_api_kittingdip.procDataKittingDIP_getByPartCard_new_post(ProductDate, Plant, Material, Model, Line, Time, Sloc, UploadNo).then((value2) {
                  if(value2 == '-1')
                  {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.red,
                            content: Text('Ma nay da duoc kitting!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                          );
                        });
                    txtPartCard.text = "";
                    partcardid.requestFocus();
                  }
                  else if(value2 == '-2')
                  {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.red,
                            content: Text('Khong ton ma nay trong Pullist!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
                          );
                        });
                    txtPartCard.text = "";
                    partcardid.requestFocus();
                  }
                  else
                  {
                    print('OK pending');
                    //pending
                    print(itemList![3].toString());
                    setState(() {
                      _quantity = itemList![3].toString();
                      txtAct_Qty.text = _quantity;
                      lblQty = _quantity;
                      //txtCodeEnabled = true;
                    });
                    print(lblQty);
                    txtCode.text="";
                    grboxid.requestFocus();
                  }
                });
              }
              else
              {
                //da duoc kitting roi
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.red,
                        content: Text('Part card nay da duoc su dung!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
                      );
                    });
                txtPartCard.text="";
                partcardid.requestFocus();
              }
            });

          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.red,
                    content: Text('NG, Format partcard!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
                  );
                });
            txtPartCard.text="";
            partcardid.requestFocus();
          }
        }
        else
        {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.red,
                  content: Text('NG, Format partcard!', style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
                );
              });

          txtPartCard.text = "";
          partcardid.requestFocus();
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

  void function_kitting(BuildContext context, String remainder) {
    String Barcode = txtCode.text.toString();
    String SLOC = Sloc;
    print('giaitri sloc: ${SLOC}');
    print(Barcode);
    //_call_api_kittingdip.GrTran_ConfirmBarcode(Barcode, Material, SLOC).then((value3) {
    _call_api_kittingdip.GrTran_ConfirmBarcode_post(Barcode, Material, SLOC).then((value3) {
      if(value3 == '-3')
      {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.red,
                content: Text('Khong phai thung le.',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
              );
            });
        txtCode.text = "";
        grboxid.requestFocus();
      }
      else if(value3 == '0')
      {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.red,
                content: Text('KHONG PHAI LOT MIN',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
              );
            });
        txtCode.text = "";
        grboxid.requestFocus();
      }
      else if(value3 == '-2')
      {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.red,
                content: Text('Thung hang nay chua duoc luu kho',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
              );
            });
        txtCode.text = "";
        grboxid.requestFocus();
      }
      else if(value3 == '-4')
      {
        //Ban co muon MO KHOA khong?
        showAlertDialog_unlock(context,Barcode);
        //print('vao truong hop 4');
        txtCode.text = "";
        grboxid.requestFocus();
      }
      else
      {
        //result == "-1" ==>  result = Qty  (truong hop nay QTY > 0)
        print("vao truong hop -1");
        var qty = value3.toString();
        print(qty);
        txtAct_Qty.text = qty;
        //_Sloc_Qty = qty;
        print(double.parse(lblQty.toString()));
        if(lblQtyActual =='')
        {
          lblQtyActual = '0';
        }
        print(double.parse(lblQtyActual.toString()));
        remainder = (double.parse(lblQty.toString()) - double.parse(lblQtyActual.toString())).toString();
        print('phan con lai: ${remainder}');
        if(double.parse(remainder) > double.parse(qty))
        {
          setState(() {
            lblQtyActual = (double.parse(lblQtyActual.toString()) + double.parse(qty.toString())).toString();
            _Sloc_Qty = qty;
          });
          //print('vao a');
          //print(lblQtyActual);
        }
        else
        {
          setState(() {
            lblQtyActual = (double.parse(lblQtyActual.toString()) + double.parse(remainder.toString())).toString();
            _Sloc_Qty = qty;
          });
          //print('vao b');
          txtAct_Qty.text = remainder;
        }
        //thuc hien kitting
        String GetQuantity = txtAct_Qty.text.toString();
        //_call_api_kittingdip.procGRTran_update(Barcode,GetQuantity).then((value) {
        _call_api_kittingdip.procGRTran_update_post(Barcode,GetQuantity).then((value) {
          String _getdate = 'getdate()';
          print(_getdate);

          setState(() {
            //(,,'21022577;2300000442;1;07/05/2023;4500268207;11;PNPG3964009ZA/V2;120;120;1;05/07/2023-DP;00001',50,0,2023-07-10 17:01:20.964903),
            _strValue += "(,,'" + txtCode.text.toString() + "'," + txtAct_Qty.text.toString() + ",0,"+_getdate+"),";
            //'21022577;2300000442;1;07/05/2023;4500268207;11;PNPG3964009ZA/V2;120;120;1;05/07/2023-DP;00001',
            _str_barcode += "'" + txtCode.text.toString() + "',";
            _str_barcode2 += txtCode.text.toString() + "|";
            _str_Qty +=txtAct_Qty.text.toString() + "|";
            print ('chuoi barcode:');
            //print(_strValue);
            //print(_str_barcode);
            //remove dau , cuoi cung
            //strValue = strValue.Remove(strValue.Length - 1, 1);
            //str_barcode = str_barcode.Remove(str_barcode.Length - 1, 1);
            strValue = _strValue.substring(0, _strValue.length - 1);
            //(,,'21022577;2300000442;1;07/05/2023;4500268207;11;PNPG3964009ZA/V2;120;120;1;05/07/2023-DP;00001',50,0,2023-07-10 17:13:49.818132)
            str_barcode = _str_barcode.substring(0, _str_barcode.length - 1);
            str_barcode2 = _str_barcode2.substring(0, _str_barcode2.length - 1);
            str_Qty = _str_Qty.substring(0, _str_Qty.length - 1);
            //'21022577;2300000442;1;07/05/2023;4500268207;11;PNPG3964009ZA/V2;120;120;1;05/07/2023-DP;00001'
          });
          print(strValue);
          print(str_barcode);

          String barcode = txtCode.text.trim();
          String soluong = txtAct_Qty.text.trim();
          //doi tuong obj
          dt_objTB p = dt_objTB(barcode,soluong);
          //list -> data
          _objTB.add(p);


          if(value ==  true)
          {
            //AddRow(txtCode.Text.Trim(), float.Parse(txtAct_Qty.Text));
            if(double.parse(lblQty.toString()) == double.parse(lblQtyActual.toString()) )
            {
              /*showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('Da lay du so luong kitting!'),
                  );
                });*/
              //button1_Click(sender, e);
              //update kitting khi scan du so luong tren partcard
              setState(() {
                stt='0';
                display = '1';
              });

              update_kitting(context);

            }
            else
            {
              setState(() {
                stt='10';
                display = '0';
              });
              //truong hop kitting chua het partcard, ban tiep cac box khac
              //truong hop hang thieu
              //truong hop hang thieu muon kitting phai bam nut submit
              //sang du so luong tu dong bao kitting thanh cong!
              txtCode.text="";
              grboxid.requestFocus();
            }
          }
          else
          {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('NG,Khong kitting duoc thung nay!'),
                  );
                });
            txtCode.text = "";
            grboxid.requestFocus();
          }
        });
      }
    });
  }

  showAlertDialog_unlock(BuildContext context, String Barcode) {
    // set up the buttons
    Widget continueButton = TextButton(
      child: Text("unlock"),
      onPressed: () {
        //Navigator.of(context).pop();
        //xu ly su kien o day

        //print('beint duoc dua len ${Barcode}');
        //_call_api_kittingdip.ulbarcodekitting(Barcode).then((value5) {
        _call_api_kittingdip.ulbarcodekitting_post(Barcode).then((value5) {
          if(value5 == true)
          {
            setState(() {
              display ='0';
            });
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.green,
                    content: Text('MO KHOA thanh cong. Ban hay scan lai thung hang nay!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
                  );
                });
            //txtCode.text = "";
            //grboxid.requestFocus();
          }
          else
          {
            //unlock NG
            //MessageBox.Show("MO KHOA that bai.");
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.red,
                    content: Text('MO KHOA that bai.!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
                  );
                });
            //txtCode.text = "";
            //grboxid.requestFocus();
          }
        });
        Navigator.of(context, rootNavigator: true).pop(true); // dismisses only the dialog and returns true
        /*showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.green,
                content: Text('MO KHOA thanh cong. Ban hay scan lai thung hang nay!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
              );
            });*/
      },
    );
    Widget cancelButton = TextButton(
      child: Text("NO"),
      onPressed: () {
        //xu ly du lieu o day
        //Navigator.of(context).pop();
        txtCode.text = "";
        grboxid.requestFocus();
        Navigator.of(context, rootNavigator: true).pop(false); // dismisses only the dialog and returns false
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Ma nay dang duoc Kitting. Ban co muon MO KHOA khong?"),
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

  void update_kitting(BuildContext context) {
    String Status = stt;
    String Quantity = lblQtyActual.toString();
    //String QtyPlan = lblQty.toString();
    String UserID = datauser;//"2012757";
    String BarcodePartcard = txtPartCard.text.trim().toString();
    //String ValueArr = strValue;
    //String ListBarcode = str_barcode;
    String BarcodeCarton = '';

    //truong hop hang thieu => lay gia tri dau tien cua list box
    if(Status == '10')
    {
      BarcodeCarton = _objTB[0].Barcode.toString();
    }
    else
    {
      BarcodeCarton = txtCode.text.trim().toString();
    }
    //print('barcode2');
    //print(BarcodeCarton);
    //thuc hien viec kitting
    String Partcode = Material;
    String Issue_sloc=  sloc_issue;
    String RepLoc = Sloc;
    String DeliveryDate = ProductDate;
    String TypeKitting='4';
    String Plant = _Plant;
    String BarcodeArr= str_barcode2;
    String QuantityArr= str_Qty;
    /*print('======strored: procKitting_trans_temp_DIP');
    print(Partcode);
    print(Quantity);
    print(Issue_sloc);
    print(RepLoc);
    print(DeliveryDate);
    print(BarcodeCarton);
    print(BarcodePartcard);
    print(TypeKitting);
    print(Status);
    print(UserID);
    print(Plant);
    print(BarcodeArr);
    print(QuantityArr);
    print(Model);
    print(Line);
    print(Time);
    print(UploadNo);*/
    //_call_api_kittingdip.procKitting_trans_temp_DIP(Partcode, Quantity, Issue_sloc, RepLoc, DeliveryDate, BarcodeCarton, BarcodePartcard, TypeKitting, Status, UserID, Plant, BarcodeArr, QuantityArr, Model, Line, Time, UploadNo).then((value) {
    _call_api_kittingdip.procKitting_trans_temp_DIP_post(Partcode, Quantity, Issue_sloc, RepLoc, DeliveryDate, BarcodeCarton, BarcodePartcard, TypeKitting, Status, UserID, Plant, BarcodeArr, QuantityArr, Model, Line, Time, UploadNo).then((value) {
      /* print('===gia tri ket qua o day');
      print(value);*/
      if(value == true)
      {
        if(Status =='0')
        {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.green,
                  content: Text('Da lay du so luong kitting! Kitting thanh cong!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
                );
              });
        }
        else   //Status =='10'
            {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.green,
                  content: Text('Kitting hang thieu thanh cong!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) , ),
                );
              });
        }
        //load lai du lieu
        reset();

      }
      else
      {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.red,
                content: Text('NG,Khong the kitting!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
              );
            });

      }

    });

  }

  void reset()
  {
    setState(() {
      txtCode.text='';
      txtAct_Qty.text='';
      txtPartCard.text='';
      partcardid.requestFocus();

      check_codeGR_List = false;
      ProductDate='';
      _Plant='';
      Material='';
      Model='';
      Line='';
      Time='';
      Sloc='';
      UploadNo='';
      sloc_issue ='';
      _material='';
      lblQtyActual ='';
      lblQty='';
      _quantity = '';
      _Sloc_Qty='';
      _str_barcode = '';
      _str_barcode2 = '';
      _strValue = '';
      _str_Qty ='';
      str_barcode = '';
      str_barcode2 = '';
      strValue = '';
      str_Qty ='';
      stt = "0";
      display = '0';
      _objTB = [];

    });
  }

  showAlertDialog_shortage(BuildContext context) {
    // set up the buttons
    Widget continueButton = TextButton(
      child: Text("YES"),
      onPressed: () {
        update_kitting(context);
        Navigator.of(context, rootNavigator: true).pop(true); // dismisses only the dialog and returns true
      },
    );
    Widget cancelButton = TextButton(
      child: Text("NO"),
      onPressed: () {
        //Navigator.of(context).pop();
        txtCode.text = "";
        grboxid.requestFocus();
        Navigator.of(context, rootNavigator: true).pop(false); // dismisses only the dialog and returns false
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Ma nay chua du so luong theo ke hoach ban co muon kitting?"),
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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          //height: MediaQuery.of(context).size.height * 0.3,
          child:LayoutBuilder(builder: (context, constraints) {
            if(_objTB.length > 0)
            {
              return SingleChildScrollView(
                /*scrollDirection: Axis.vertical,*/
                //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: DataTable(
                  columns: [
                    DataColumn(
                      label: Text("Barcode"),
                    ),
                    DataColumn(
                      label: Text("Qty"),
                    ),
                  ],
                  rows: _objTB.map(
                        (p) => DataRow(cells: [
                      DataCell(
                        Text(p.Barcode),
                      ),
                      DataCell(
                        Text(p.Qty),
                      ),
                    ]),
                  ).toList(),
                ),
              );
            }
            else
            {
              return SingleChildScrollView(
                /*scrollDirection: Axis.vertical,*/
                //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: DataTable(
                    columns: [
                      DataColumn(
                        label: Text("Barcode"),
                      ),
                      DataColumn(
                        label: Text("Qty"),
                      ),
                    ],
                    rows: const <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('')),
                          DataCell(Text('')),
                        ],
                      ),]
                ),
              );
            }
          })
      ),
    );
  }

  Widget createTable_null(BuildContext context, AsyncSnapshot snapshot) {
    return SingleChildScrollView(
      /*scrollDirection: Axis.vertical,*/
      //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: DataTable(
          columns: [
            DataColumn(
              label: Text("Barcode"),
            ),
            DataColumn(
              label: Text("Qty"),
            ),
          ],
          rows: const <DataRow>[
            DataRow(
              cells: <DataCell>[
                DataCell(Text('')),
                DataCell(Text('')),
              ],
            ),]
      ),
    );
  }


}