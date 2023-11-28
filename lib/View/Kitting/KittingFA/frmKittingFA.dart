import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../../../Controller/Kitting/KittingFA/api_kittingFA.dart';
import 'MenuKittingFA.dart';

//libary focus
import 'package:flutter_datawedge/models/scan_result.dart';
import 'package:flutter_datawedge/flutter_datawedge.dart';
import 'dart:io';

/*void main() {
  runApp(new KittingFA());
}*/

class KittingFA extends StatelessWidget {
  const KittingFA({Key? key, required this.UserID}) : super(key: key);
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

class ViewTable {
  int ID;
  String Barcode, Qty;
  ViewTable(this.ID, this.Qty, this.Barcode);
}

class ViewKitting {
  String Partcode, Qty,Pos,Time,Sloc,Model,Line,Deliverydate,Status;
  ViewKitting(this.Partcode, this.Qty, this.Pos, this.Time, this.Sloc, this.Model, this.Line, this.Deliverydate, this.Status);
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

  List<ViewTable> AddLst = <ViewTable>[
    //ViewTable(1, "code", "0"),
    //ViewTable(2, "John", "Anderson"),
  ];
  var lastID = 1;



  List<ViewKitting> ViewLst = <ViewKitting>[];


  String display = '';
  var _Barcode = new TextEditingController();
  var _GRbox = new TextEditingController();
  var _ActualQty = new TextEditingController();

  KittingTemp _objKittingTemp = KittingTemp();
  SelectTypeKitting _objlistkitting = SelectTypeKitting();
  Getqtykitting _objgetqty_hangthieu = Getqtykitting();
  CheckCodeKitting _objcheck_code_kiting = CheckCodeKitting();
  UnlockBarcodekiting _objunlock_barcode_kitting = UnlockBarcodekiting();
  KitingTranTemp _objkitting_trantemp = KitingTranTemp();
  UpkittingPlan _objkitting_plan = UpkittingPlan();

  SelectViewKitting _objviewkitting = SelectViewKitting();
  Api_tblGrTrans_Delete_Temp _obj_delete_temp = Api_tblGrTrans_Delete_Temp();


  var focusNode = FocusNode();  //gia tri focus
  final FocusNode setfocus = FocusNode();
  late FocusNode grboxid = FocusNode();
  late FocusNode actualqtyid = FocusNode();

  //InsertLabelGR _objLableNG = InsertLabelGR();

  String Model='';
  String Partcode='';
  String Line='';
  String Time='';
  String DeliveryDate='';
  String Plant='';
  String CATEGORY='';
  String Issue_sloc='';
  String TypeKitting='';

  String lblQtyActual = '';
  String lblQty = '';
  String ModelQty='';
  String _quantity='';

  String _str_barcode = '';
  String _str_barcode2 = '';
  String _strValue = '';

  String str_barcode = '';
  String str_barcode2 = '';
  String strValue = '';

  String stt = "0";

  bool View_plant = false;
  bool isChecked = false;
  //String note_checkbox = '';

  int _currentSortColumn = 0;
  //bool _isAscending = true;
  bool _isAscending = false;
  String thongbao='';

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
    super.initState();

    initScanner();
  }

  void initScanner() {
    if (Platform.isAndroid) {
      fdw = FlutterDataWedge(profileName: 'FlutterDataWedge');
      onScanResultListener = fdw.onScanResult
          .listen((result) => setState(() {
        if(setfocus.hasFocus)
        {
          //print('abc');
          _Barcode.text = result.data;
          Partcardid_function(result.data, context);
        }else if(grboxid.hasFocus)
        {
          _GRbox.text = result.data;
          GRid_function(result.data, context);
        }
       /* else if(actualqtyid.hasFocus)
        {
          _ActualQty.text = result.data;
        }*/

      } ));
    }
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    //bacodeid.dispose();
    grboxid.dispose();
    actualqtyid.dispose();
    super.dispose();

    //reduce ram focus
    onScanResultListener.cancel();
  }

  @override
  Widget build(BuildContext context) {
    //hideinputtextfield();
    return
      Scaffold(
          appBar: AppBar(title: Text('Kitting_FA type : ${thongbao} '),),
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
                      autofocus: true,   //khong thay uu tien focus
                      controller: _Barcode,
                      focusNode: setfocus,
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
                      controller: _GRbox,
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
                        //GRid_function(value, context);
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
                            focusNode: actualqtyid,
                            controller: _ActualQty,
                            readOnly: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Act Qty',
                              hintText: '',
                            ),
                            onSubmitted:(value) {

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
                      children: <Widget>[
                        SizedBox(width: 10,),
                        //CheckboxListTile(
                        Checkbox(
                          //value: View_plant,
                          value: isChecked,
                          onChanged: (bool? value) async {
                            setState(() {
                              isChecked = value!;
                            });

                            if(isChecked == true)
                            {
                              if(_Barcode.text.toString() == "")
                              {
                                print('gia tri bacode null');
                                setState(() {
                                  ViewLst = [];
                                });
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.red,
                                        content: Text('gia tri bacode null!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                                      );
                                    });
                                setfocus.requestFocus();
                              }
                              else
                              {
                                print('show list 2');
                                print(isChecked);
                                setState(() {
                                  AddLst = [];
                                });

                                var chuoi = _Barcode.text.toString();
                                List<String>? itemList;
                                itemList = chuoi.split(";");
                                if(itemList.length == 14)
                                {
                                  //view plan = true => view list kitting
                                  String PIC =datauser;//"2009847";    //pic duoc lay theo user dang nhap thi mơi show duoc ra lít kitting theo lít
                                  String Issue_Sloc="a";
                                  String Partcode="a";
                                  String Model="a";
                                  String Line="a";
                                  String Time="a";
                                  String _DeliveryDate= DeliveryDate;
                                  String TypeKit= TypeKitting;
                                  String _Plant=Plant;
                                  String Category="a";
                                  print(_DeliveryDate);
                                  print(_Plant);
                                  print(TypeKit);
                                  print(PIC);
                                  //_objviewkitting.fetchViewKitting(PIC, Issue_Sloc, Partcode, Model, Line, Time, _DeliveryDate, TypeKit, _Plant, Category).then((return3) {
                                  _objviewkitting.fetchViewKitting_post(PIC, Issue_Sloc, Partcode, Model, Line, Time, _DeliveryDate, TypeKit, _Plant, Category).then((return3) {
                                    if(return3!.isEmpty)
                                    {
                                      //print(value2);
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              backgroundColor: Colors.red,
                                              content: Text('List kitting da duoc scan het!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                                            );
                                          });
                                    }
                                    else
                                    {
                                      //add vao bang list kitting gom cac cot duoc loc
                                      String _Partcode = '';
                                      String _Qty = '';
                                      String _Pos = '';
                                      String _Time = '';
                                      String _Sloc = '';
                                      String _Model = '';
                                      String _Line = '';
                                      String _Deliverydate = '';
                                      String _Status = '';

                                      if(TypeKit == "0")
                                      {
                                        for(int i = 0; i< return3.length; i++)
                                        {
                                          _Partcode = return3[i].Partcode.toString();
                                          _Qty = return3[i].Qty.toString();
                                          _Pos = return3[i].Pos.toString();
                                          _Time = return3[i].Time.toString();
                                          _Sloc = return3[i].Sloc.toString();
                                          _Model = return3[i].Model.toString();
                                          _Line = return3[i].Line.toString();
                                          _Deliverydate = return3[i].Deliverydate.toString();
                                          _Status = return3[i].Status.toString();

                                          //ViewKitting rowkitting = ViewKitting(_Partcode,_Qty,_Pos,_Time,_Sloc,_Model,_Line,_Deliverydate,_Status);
                                          //ViewLst.add(rowkitting);
                                          ViewKitting rowkitting = ViewKitting(return3[i].Partcode.toString(),return3[i].Qty.toString(),return3[i].Pos.toString(),return3[i].Time.toString(),return3[i].Sloc.toString(),_Model = return3[i].Model.toString(),return3[i].Line.toString(),return3[i].Deliverydate.toString(),return3[i].Status.toString());
                                          ViewLst.add(rowkitting);
                                        }
                                        setState(() {
                                          display ='1'; //assign any string value from result to display variable.
                                        });
                                      }
                                      else if(TypeKit == "1")
                                      {
                                        for(int i = 0; i< return3.length; i++)
                                        {
                                          /*_Partcode = return3[i].Partcode.toString();
                                      _Qty = return3[i].Qty.toString();
                                      _Pos = return3[i].Pos.toString();
                                      _Time = return3[i].Time.toString();
                                      _Sloc = return3[i].Sloc.toString();
                                      _Model = return3[i].Model.toString();
                                      _Line = return3[i].Line.toString();
                                      _Deliverydate = return3[i].Deliverydate.toString();
                                      _Status = return3[i].Status.toString();*/
                                          //print(_Partcode);
                                          //print(return3[i].Partcode.toString());
                                          //ViewKitting rowkitting = ViewKitting(_Partcode,_Qty,_Pos,_Time,_Sloc,_Model,_Line,_Deliverydate,_Status);
                                          ViewKitting rowkitting = ViewKitting(return3[i].Partcode.toString(),return3[i].Qty.toString(),return3[i].Pos.toString(),return3[i].Time.toString(),return3[i].Sloc.toString(),_Model = return3[i].Model.toString(),return3[i].Line.toString(),return3[i].Deliverydate.toString(),return3[i].Status.toString());
                                          ViewLst.add(rowkitting);
                                        }
                                        //test
                                        setState(() {
                                          display ='1'; //assign any string value from result to display variable.
                                        });
                                      }
                                      else if(TypeKit == "2")
                                      {
                                        for(int i = 0; i< return3.length; i++)
                                        {
                                          /*_Partcode = return3[i].Partcode.toString();
                                      _Qty = return3[i].Qty.toString();
                                      _Pos = return3[i].Pos.toString();
                                      _Time = return3[i].Time.toString();
                                      _Sloc = return3[i].Sloc.toString();
                                      _Model = return3[i].Model.toString();
                                      _Line = return3[i].Line.toString();
                                      _Deliverydate = return3[i].Deliverydate.toString();
                                      _Status = return3[i].Status.toString();*/

                                          ViewKitting rowkitting = ViewKitting(return3[i].Partcode.toString(),return3[i].Qty.toString(),return3[i].Pos.toString(),return3[i].Time.toString(),return3[i].Sloc.toString(),_Model = return3[i].Model.toString(),return3[i].Line.toString(),return3[i].Deliverydate.toString(),return3[i].Status.toString());
                                          ViewLst.add(rowkitting);
                                          //ViewKitting rowkitting = ViewKitting(_Partcode,_Qty,_Pos,_Time,_Sloc,_Model,_Line,_Deliverydate,_Status);
                                          //ViewLst.add(rowkitting);
                                        }
                                        setState(() {
                                          display ='1'; //assign any string value from result to display variable.
                                        });
                                      }
                                      else if(TypeKit == "8")
                                      {
                                        for(int i = 0; i< return3.length; i++)
                                        {
                                          /* _Partcode = return3[i].Partcode.toString();
                                      _Qty = return3[i].Qty.toString();
                                      _Pos = '';//return3[i].Pos.toString();  //truong hop nay khong the them vi tri duoc==> MCS khong dung chuc nang nay
                                      _Time = return3[i].Time.toString();
                                      _Sloc = return3[i].Sloc.toString();
                                      _Model = return3[i].Model.toString();
                                      _Line = return3[i].Line.toString();
                                      _Deliverydate = return3[i].Deliverydate.toString();
                                      _Status = return3[i].Status.toString();*/

                                          ViewKitting rowkitting = ViewKitting(return3[i].Partcode.toString(),return3[i].Qty.toString(),return3[i].Pos.toString(),return3[i].Time.toString(),return3[i].Sloc.toString(),_Model = return3[i].Model.toString(),return3[i].Line.toString(),return3[i].Deliverydate.toString(),return3[i].Status.toString());
                                          ViewLst.add(rowkitting);
                                          //ViewKitting rowkitting = ViewKitting(_Partcode,_Qty,_Pos,_Time,_Sloc,_Model,_Line,_Deliverydate,_Status);
                                          //ViewLst.add(rowkitting);
                                        }
                                        setState(() {
                                          display ='1'; //assign any string value from result to display variable.
                                        });
                                      }
                                      else
                                      {
                                        for(int i = 0; i< return3.length; i++)
                                        {
                                          /*_Partcode = return3[i].Partcode.toString();
                                      _Qty = return3[i].Qty.toString();
                                      _Pos = return3[i].Pos.toString();
                                      _Time = return3[i].Time.toString();
                                      _Sloc = return3[i].Sloc.toString();
                                      _Model = return3[i].Model.toString();
                                      _Line = return3[i].Line.toString();
                                      _Deliverydate = return3[i].Deliverydate.toString();
                                      _Status = return3[i].Status.toString();*/

                                          ViewKitting rowkitting = ViewKitting(return3[i].Partcode.toString(),return3[i].Qty.toString(),return3[i].Pos.toString(),return3[i].Time.toString(),return3[i].Sloc.toString(),_Model = return3[i].Model.toString(),return3[i].Line.toString(),return3[i].Deliverydate.toString(),return3[i].Status.toString());
                                          ViewLst.add(rowkitting);
                                          //ViewKitting rowkitting = ViewKitting(_Partcode,_Qty,_Pos,_Time,_Sloc,_Model,_Line,_Deliverydate,_Status);
                                          //ViewLst.add(rowkitting);
                                        }
                                        setState(() {
                                          display ='1'; //assign any string value from result to display variable.
                                        });
                                      }
                                    }
                                  });

                                }
                                else
                                {
                                  //nothing
                                  //print('Sai dinh dang barcode');
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.red,
                                          content: Text('NG,Sai dinh dang barcode!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                                        );
                                      });
                                  _Barcode.text="";
                                  setfocus.requestFocus();
                                  //hideinputtextfield();
                                }

                              }


                            }
                            else
                            {
                              setState(() {
                                ViewLst = [];
                                display ='0';
                              });
                            }

                            //});
                          },
                        ),
                        SizedBox(
                            width: 150.0,
                            height: 30.0,
                            child: isChecked == false? Card(child: Text('View Plant Kitting',style: TextStyle(fontSize: 18,color: Colors.blue, fontWeight: FontWeight.bold),)):
                            Card(child: Text('View list kitting',style: TextStyle(fontSize: 18,color: Colors.blue, fontWeight: FontWeight.bold),))
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
                              //Update so luong bang tranGR neu nhu GR => voi hang thieu
                              if(str_barcode == "")  //if (objTB.Rows.Count == 0)
                                  {
                                // quay ve trang truoc
                                reset();
                                Navigator.push(context, new MaterialPageRoute(builder: (context) => new MenuKittingFA(UserID: datauser)));
                              }
                              else
                              {
                                //update lai so luong bang tranGR //xoa so luong da GR
                                //if (objKitting.tblGrTrans_Delete_Temp(str_barcode) == true)
                                String BarcodeArr = str_barcode2.toString();
                                _obj_delete_temp.tblGrTrans_Delete_Temp(BarcodeArr).then((return4) {
                                  if(return4 ==  true)
                                  {
                                    //print('da xoa thanh cong!');
                                    // quay ve trang truoc
                                    reset();
                                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new MenuKittingFA(UserID: datauser)));
                                  }
                                  else
                                  {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.red,
                                            content: Text('Xoa NG!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
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
                              if(double.parse(lblQty.toString()) != double.parse(lblQtyActual.toString()) )
                              {
                                setState(() {stt='10';});
                                showAlertDialog_shortage(context);
                              } //truong hop so luong du
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

  void GRid_function(String value, BuildContext context) {
    try
    {
      if(value == "")
      {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.red,
                content: Text('NG,Qty null!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
              );
            });
        grboxid.requestFocus();
        //hideinputtextfield();
      }
      else
      {
        String remainder ='';
        //VL-SE30XLA-V4;PNPG3294026ZA/V1; 1M;111;DP-25A5-1C;1140;07/06/2023;06:00;1;VR01;DP;DP;0;P
        // ma nha cung cap hoac phieu kho
        //V21022612;2300000111;20;03/20/2023;4500263230;3;PNPG3294026ZA/V1;260;260;1;PANA230320-R;00001
        var chuoi2 = _GRbox.text.toString();
        List<String>? itemList2;
        itemList2 = chuoi2.split(";");
        String material2 = itemList2[6].toString();
        String SLOC ="1120"; //stored khong dung den sloc  ****=> khong duoc de trong se bi loi
        String Barcode = _GRbox.text.toString();
        if (Partcode == material2)
        {
          if(AddLst.isEmpty)
          {
            //print('The list is empty ==> OK khong check');
            function_kitting(itemList2, SLOC, context, remainder,Barcode);
          }else
          {
            //print('da scan box ==> check box xem duoc scan chua');
            //print(AddLst.length);
            bool _checkbox = false;
            for(int i =0; i < AddLst.length;i++)
            {
              print(AddLst[i].Barcode.toString());
              if(AddLst[i].Barcode.toString() == Barcode)
              {
                _checkbox = true;
                break;
              }
            }
            if(_checkbox == true)
            {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.red,
                      content: Text('Box nay da duoc ban trong list kitting.\n Scan box khac!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                    );
                  });
              _GRbox.text = "";
              grboxid.requestFocus();
              //hideinputtextfield();
            }
            else
            {
              //print('scan tiep');
              function_kitting(itemList2, SLOC, context, remainder,Barcode);
            }
          }
          //function_kitting(itemList2, SLOC, context, remainder,Barcode);
        }
        else
        {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.red,
                  content: Text('NG,2 MA PART CARD KHONG TRUNG NHAU!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                );
              });
          _GRbox.text = "";
          grboxid.requestFocus();
          //hideinputtextfield();
        }
        //actualqtyid.requestFocus();
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
                content: Text('NG, du lieu null!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
              );
            });
        setfocus.requestFocus();
        //hideinputtextfield();
      }
      else
      {
        var chuoi = _Barcode.text.toString();
        List<String>? itemList;
        itemList = chuoi.split(";");

        //print('leng partcard:');
        //print(itemList[0].toString());
        //print(itemList.length);
        if (itemList != null && itemList.length == 14)
        {
          var output = chuoi[chuoi.length - 1];
          //print('Last character : $output');
          if(output == 'P')
          {
            //KX-TGD322EB-V4;HHR-55AAABGE;1A1;396;DECT-DB6-1A;1152;07/03/2023;13:12;1;VR01;DECTPHONE;DECTPHONE;0;P
            //partcard
            String TypeKit = itemList[8].toString();
            Model = itemList[0].toString();
            Partcode= itemList[1].toString();
            Line= itemList[2].toString();
            Time= itemList[7].toString();
            DeliveryDate= itemList[6].toString();
            Plant= itemList[9].toString();
            CATEGORY= itemList[11].toString();

            Issue_sloc = itemList[5].toString();
            TypeKitting = itemList[8].toString();

            //check xem da ton tai partcard nay trong kitting_Trans chua
            var BarcodePartcard = _Barcode.text.trim().toString();
            //print(BarcodePartcard);
            //kiem tra co trong bang kitting tran temp co chua?
            //_objKittingTemp.CheckKittingTemp(BarcodePartcard).then((value1) {
            _objKittingTemp.CheckKittingTemp_post(BarcodePartcard).then((value1) {
              if (value1 == true)
              {
                print('vao day');
                print(value1);  // chua duoc kitting
                if(TypeKit == "1")
                {
                  //Kitting1Time
                  print("1 time");
                  setState(() {
                    thongbao = "1time";
                  });
                  //_objlistkitting.fetchListKitting(Model, Partcode, Line, Time, DeliveryDate, TypeKit, Plant, CATEGORY).then((value2) {
                  _objlistkitting.fetchListKitting_post(Model, Partcode, Line, Time, DeliveryDate, TypeKit, Plant, CATEGORY).then((value2) {
                    if(value2!.isEmpty)
                    {
                      //if(View_plant == true)
                      if(isChecked == true)
                      {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.red,
                                content: Text('Ban can click again view plant .\n De show list chua kitting!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                              );
                            });
                        setState(() {
                          isChecked == false;
                        });
                        _GRbox.text = "";
                        grboxid.requestFocus();
                        //hideinputtextfield();
                        //setfocus.requestFocus();
                      }
                      else
                      {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.red,
                                content: Text('NG, Part card nay da duoc kitting!', style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
                              );
                            });
                        _Barcode.text = "";
                        setfocus.requestFocus();
                      }

                      //pending mai lam not cho nay

                    }
                    else
                    {
                      print(value2);
                      //String mahang = value2[0].Partcode.toString();
                      print('model quantity');
                      print(value2[0].Model_Quantity.toString());
                      ModelQty = value2[0].Model_Quantity.toString();
                      String _status = value2[0].Status.toString();
                      if(_status == "10")
                      {
                        //get __quantity
                        //_objgetqty_hangthieu.fetchqtykitting(Model, Partcode, Line, Time, DeliveryDate, TypeKit).then((value3) {
                        _objgetqty_hangthieu.fetchqtykitting_post(Model, Partcode, Line, Time, DeliveryDate, TypeKit).then((value3) {
                          if(value3 != '')
                          {
                            _quantity = value3.toString();
                            _ActualQty.text = _quantity.toString();
                            setState(() {
                              lblQty = _quantity.toString();
                            });
                            print(lblQty);
                            //lblQty = _quantity.toString();

                            _GRbox.text = "";
                            grboxid.requestFocus();
                            //hideinputtextfield();
                          }
                          else
                          {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.red,
                                    content: Text('NG, Qty hang thieu null, Kiem tra lai!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                                  );
                                });
                            _Barcode.text = "";
                            setfocus.requestFocus();
                            //hideinputtextfield();
                          }
                        });
                      }
                      else
                      {
                        _quantity = itemList![3].toString();
                        //print(_quantity);
                        _ActualQty.text = _quantity.toString();
                        setState(() {
                          lblQty = _quantity.toString();
                        });
                        //print(lblQty);
                        //lblQty = _quantity.toString();

                        _GRbox.text = "";
                        grboxid.requestFocus();
                        //hideinputtextfield();
                      }

                    }
                  });
                }
                else if(TypeKit == "0")
                {
                  print("n time");
                  setState(() {
                    thongbao = "ntime";
                  });
                  //ProcKittingNTime_PartCard_category
                  _objlistkitting.fetchkitting_NTime(Model, Partcode, Line, Time, DeliveryDate, Plant, CATEGORY, TypeKit).then((value2){
                    if(value2.isEmpty)
                    {
                      //print(value2);
                      if(isChecked == true)
                      {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.red,
                                content: Text('Ban can click again view plant .\n De show list chua kitting!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                              );
                            });
                        setState(() {
                          isChecked == false;
                        });
                        _GRbox.text = "";
                        grboxid.requestFocus();
                        //hideinputtextfield();

                        //setfocus.requestFocus();
                      }
                      else
                      {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.red,
                                content: Text('NG, Part card nay da duoc kitting!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                              );
                            });
                        _Barcode.text = "";
                        setfocus.requestFocus();
                        //hideinputtextfield();
                      }

                    }
                    else
                    {
                      print(value2);
                      //String mahang = value2[0].Partcode.toString();
                      print('model quantity');
                      print(value2[0].Model_Quantity.toString());
                      ModelQty = value2[0].Model_Quantity.toString();
                      String _status = value2[0].Status.toString();
                      if(_status == "10")
                      {
                        //get __quantity
                        //_objgetqty_hangthieu.fetchqtykitting(Model, Partcode, Line, Time, DeliveryDate, TypeKit).then((value3) {
                        _objgetqty_hangthieu.fetchqtykitting_post(Model, Partcode, Line, Time, DeliveryDate, TypeKit).then((value3) {
                          if(value3 != '')
                          {
                            _quantity = value3.toString();
                            _ActualQty.text = _quantity.toString();
                            setState(() {
                              lblQty = _quantity.toString();
                            });
                            print(lblQty);
                            //lblQty = _quantity.toString();

                            _GRbox.text = "";
                            grboxid.requestFocus();
                            //hideinputtextfield();
                          }
                          else
                          {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.red,
                                    content: Text('NG, Qty null, check again!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                                  );
                                });
                          }
                        });
                      }
                      else
                      {
                        _quantity = itemList![3].toString();
                        //print(_quantity);
                        _ActualQty.text = _quantity.toString();
                        setState(() {
                          lblQty = _quantity.toString();
                        });
                        //print(lblQty);
                        //lblQty = _quantity.toString();

                        _GRbox.text = "";
                        grboxid.requestFocus();
                        //hideinputtextfield();

                      }

                    }
                  });
                }
                else if(TypeKit == "8")
                {
                  print("XHGopModel");
                  setState(() {
                    thongbao = "Gop Model";
                  });
                  //ProcKitting_XHGopModel_PartdCard_NOTime_Category
                  _objlistkitting.fetchkitting_XHGopModel(Model, Partcode, Line, Time, DeliveryDate, Plant, CATEGORY, TypeKit).then((value2){
                    if(value2.isEmpty)
                    {
                      //print(value2);
                      if(isChecked == true)
                      {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.red,
                                content: Text('Ban can click again view plant .\n De show list chua kitting!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                              );
                            });
                        setState(() {
                          isChecked == false;
                        });
                        _GRbox.text = "";
                        grboxid.requestFocus();
                        //setfocus.requestFocus();
                      }
                      else
                      {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.red,
                                content: Text('NG, Part card nay da duoc kitting!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                              );
                            });
                        _Barcode.text = "";
                        setfocus.requestFocus();
                      }

                    }
                    else
                    {
                      print(value2);
                      //String mahang = value2[0].Partcode.toString();
                      print('model quantity');
                      print(value2[0].Model_Quantity.toString());
                      ModelQty = value2[0].Model_Quantity.toString();
                      String _status = value2[0].Status.toString();
                      if(_status == "10")
                      {
                        //get __quantity
                        _objgetqty_hangthieu.fetchqtykitting(Model, Partcode, Line, Time, DeliveryDate, TypeKit).then((value3) {
                          if(value3 != '')
                          {
                            _quantity = value3.toString();
                            _ActualQty.text = _quantity.toString();
                            setState(() {
                              lblQty = _quantity.toString();
                            });
                            print(lblQty);
                            //lblQty = _quantity.toString();

                            _GRbox.text = "";
                            grboxid.requestFocus();
                            //hideinputtextfield();
                          }
                          else
                          {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.red,
                                    content: Text('NG, Qty null, check again!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                                  );
                                });
                          }
                        });
                      }
                      else
                      {
                        _quantity = itemList![3].toString();
                        //print(_quantity);
                        _ActualQty.text = _quantity.toString();
                        setState(() {
                          lblQty = _quantity.toString();
                        });
                        //print(lblQty);
                        //lblQty = _quantity.toString();

                        _GRbox.text = "";
                        grboxid.requestFocus();
                        //hideinputtextfield();

                      }

                    }
                  });
                }
                else if(TypeKit == "2")
                {
                  print("prepareNtiem");
                  setState(() {
                    thongbao = "Preparation NTime";
                  });
                  //ProcKittingPrepareNTime_PartCard_category
                  _objlistkitting.fetchkitting_PrepareNTime(Model, Partcode, Line, Time, DeliveryDate, Plant, CATEGORY, TypeKit).then((value2){
                    if(value2.isEmpty)
                    {
                      //print(value2);
                      if(isChecked == true)
                      {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.red,
                                content: Text('Ban can click again view plant .\n De show list chua kitting!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                              );
                            });
                        setState(() {
                          isChecked == false;
                        });
                        _GRbox.text = "";
                        grboxid.requestFocus();
                        //setfocus.requestFocus();
                        //hideinputtextfield();
                      }
                      else
                      {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.red,
                                content: Text('NG, Part card nay da duoc kitting!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                              );
                            });
                        _Barcode.text = "";
                        setfocus.requestFocus();
                        //hideinputtextfield();
                      }
                    }
                    else
                    {
                      print(value2);
                      //String mahang = value2[0].Partcode.toString();
                      print('model quantity');
                      print(value2[0].Model_Quantity.toString());
                      ModelQty = value2[0].Model_Quantity.toString();
                      String _status = value2[0].Status.toString();
                      if(_status == "10")
                      {
                        //get __quantity
                        _objgetqty_hangthieu.fetchqtykitting(Model, Partcode, Line, Time, DeliveryDate, TypeKit).then((value3) {
                          if(value3 != '')
                          {
                            _quantity = value3.toString();
                            _ActualQty.text = _quantity.toString();
                            setState(() {
                              lblQty = _quantity.toString();
                            });
                            print(lblQty);
                            //lblQty = _quantity.toString();

                            _GRbox.text = "";
                            grboxid.requestFocus();
                            //hideinputtextfield();
                          }
                          else
                          {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.red,
                                    content: Text('NG, Qty null, check again!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                                  );
                                });
                          }
                        });
                      }
                      else
                      {
                        _quantity = itemList![3].toString();
                        //print(_quantity);
                        _ActualQty.text = _quantity.toString();
                        setState(() {
                          lblQty = _quantity.toString();
                        });
                        //print(lblQty);
                        //lblQty = _quantity.toString();

                        _GRbox.text = "";
                        grboxid.requestFocus();
                        //hideinputtextfield();

                      }

                    }
                  });
                }
                else
                {
                  print("prepare1tiem");
                  setState(() {
                    thongbao = "Preparation 1Time";
                  });
                  //default:   ProcKittingPrepare1Time_PartCard_NOTime_category
                  _objlistkitting.fetchkitting_Prepare1Time(Model, Partcode, Line, Time, DeliveryDate, Plant, CATEGORY, TypeKit).then((value2){
                    if(value2.isEmpty)
                    {
                      //print(value2);
                      if(isChecked == true)
                      {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.red,
                                content: Text('Ban can click again view plant .\n De show list chua kitting!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                              );
                            });
                        setState(() {
                          isChecked == false;
                        });
                        _GRbox.text = "";
                        grboxid.requestFocus();
                        //setfocus.requestFocus();
                        //hideinputtextfield();
                      }
                      else
                      {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.red,
                                content: Text('NG, Part card nay da duoc kitting!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                              );
                            });
                        _Barcode.text = "";
                        setfocus.requestFocus();
                        //hideinputtextfield();
                      }
                    }
                    else
                    {
                      print(value2);
                      //String mahang = value2[0].Partcode.toString();
                      print('model quantity');
                      print(value2[0].Model_Quantity.toString());
                      ModelQty = value2[0].Model_Quantity.toString();
                      String _status = value2[0].Status.toString();
                      if(_status == "10")
                      {
                        //get __quantity
                        //_objgetqty_hangthieu.fetchqtykitting(Model, Partcode, Line, Time, DeliveryDate, TypeKit).then((value3) {
                        _objgetqty_hangthieu.fetchqtykitting_post(Model, Partcode, Line, Time, DeliveryDate, TypeKit).then((value3) {
                          if(value3 != '')
                          {
                            _quantity = value3.toString();
                            _ActualQty.text = _quantity.toString();
                            setState(() {
                              lblQty = _quantity.toString();
                            });
                            print(lblQty);
                            //lblQty = _quantity.toString();

                            _GRbox.text = "";
                            grboxid.requestFocus();
                            //hideinputtextfield();
                          }
                          else
                          {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.red,
                                    content: Text('NG, Qty null, check again!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                                  );
                                });
                          }
                        });
                      }
                      else
                      {
                        _quantity = itemList![3].toString();
                        //print(_quantity);
                        _ActualQty.text = _quantity.toString();
                        setState(() {
                          lblQty = _quantity.toString();
                        });
                        //print(lblQty);
                        //lblQty = _quantity.toString();

                        _GRbox.text = "";
                        grboxid.requestFocus();
                        //hideinputtextfield();

                      }

                    }
                  });
                }

              }
              else
              {
                if(isChecked == true)
                {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.red,
                          content: Text('Ban can click again view plant .\n De show list chua kitting!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                        );
                      });
                  setState(() {
                    isChecked == false;
                  });
                  _GRbox.text = "";
                  grboxid.requestFocus();
                  //hideinputtextfield();
                }
                else
                {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.red,
                          content: Text('Part card nay da duoc su dung. \n Hay in lai PartCard hang thieu!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                        );
                      });
                  _Barcode.text = "";
                  setfocus.requestFocus();
                  //hideinputtextfield();
                }

              }
            });
          }
          else
          {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.red,
                    content: Text('NG, Khong phai Part card!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                  );
                });
            _Barcode.text = "";
            setfocus.requestFocus();
            //hideinputtextfield();
          }
        }
        else
        {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.red,
                  content: Text('NG, Format partcard!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                );
              });
          _Barcode.text = "";
          setfocus.requestFocus();
          //hideinputtextfield();
        }

      }
    }
    catch (e)
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

  void hideinputtextfield() {
    Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
  }

  Widget createTable(BuildContext context, AsyncSnapshot snapshot) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          //height: MediaQuery.of(context).size.height * 0.3,
          child:LayoutBuilder(builder: (context, constraints) {
            if(isChecked == false){
              //if(View_plant == false){
              return SingleChildScrollView(
                /*scrollDirection: Axis.vertical,*/
                //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: DataTable(
                  columns: [
                    DataColumn(
                      label: Text("ID"),
                    ),
                    DataColumn(
                      label: Text("Barcode"),
                    ),
                    DataColumn(
                      label: Text("Qty"),
                    ),
                  ],
                  rows: AddLst.map(
                        (p) => DataRow(cells: [
                      DataCell(
                        Text(p.ID.toString()),
                      ),
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
            }else{
              if(ViewLst.length>0){
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      sortColumnIndex: _currentSortColumn,
                      sortAscending: _isAscending,
                      headingRowColor: MaterialStateProperty.all(Colors.amber[200]),
                      columns: [
                        DataColumn(
                          label: Text("Partcode"),
                        ),
                        DataColumn(
                          label: Text("Qty"),
                        ),
                        DataColumn(
                          label: Text("Pos"),
                        ),
                        DataColumn(
                          label: Text("Time"),
                        ),
                        DataColumn(
                          label: Text("Sloc"),
                        ),
                        DataColumn(
                          label: Text("Model"),
                        ),
                        DataColumn(
                          label: Text("Line"),
                        ),
                        DataColumn(
                          label: Text("Deliverydate"),
                        ),
                        DataColumn(
                            label: Text("Status"),
                            // Sorting function
                            onSort: (columnIndex, _) {
                              setState(() {
                                _currentSortColumn = columnIndex;
                                if (_isAscending == true) {
                                  _isAscending = false;
                                  // sort the product list in Ascending, order by Price
                                  ViewLst.sort((a, b) =>
                                      a.Status.compareTo(b.Status));
                                } else {
                                  _isAscending = true;
                                  // sort the product list in Descending, order by Price
                                  ViewLst.sort((a, b) =>
                                      a.Status.compareTo(b.Status));
                                }
                              });
                            }
                        ),
                      ],
                      rows: ViewLst.map(
                            (p) => DataRow(
                            color: MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                                  // All rows will have the same selected color.
                                  /*if (states.contains(MaterialState.selected)) {
                                                    return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                                                  }*/
                                  if(p.Status.toString() == "10")
                                  {
                                    return Colors.red;
                                  }else
                                  {
                                    return Colors.white;
                                    //return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                                  }
                                  // Even rows will have a grey color.
                                  /*if (index.isEven) {
                                                    return Colors.grey.withOpacity(0.3);
                                                  }*/
                                  return null; // Use default value for other states and odd rows.
                                }),

                            cells: [
                              DataCell(
                                Text(p.Partcode.toString()),
                              ),
                              DataCell(
                                Text(p.Qty.toString()),
                              ),
                              DataCell(
                                Text(p.Pos.toString()),
                              ),
                              DataCell(
                                Text(p.Time.toString()),
                              ),
                              DataCell(
                                Text(p.Sloc.toString()),
                              ),
                              DataCell(
                                Text(p.Model.toString()),
                              ),
                              DataCell(
                                Text(p.Line.toString()),
                              ),
                              DataCell(
                                Text(p.Deliverydate.toString()),
                              ),
                              DataCell(
                                Text(p.Status.toString()),
                              ),
                            ]),
                      ).toList(),
                    ),
                  ),
                );
              }else{
                return Text("123");}
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
                      label: Text("ID"),
                    ),
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
        ));
  }

  void function_kitting(List<String> itemList2, String SLOC, BuildContext context, String remainder, String Barcode) {
    print('2 ma trung nhau');
    //kiem tra box duoc ban trong list kitting chua?
    //String Barcode = _GRbox.text.toString();
    String Marterial = itemList2[6].toString();//material2;  ==> su truong hang hang prepare 1 lan
    print(Barcode);
    print('${Material}');
    print(SLOC);
    print(itemList2[6].toString());
    print(Partcode);
    print(TypeKitting);  //=3
    //get
    //_objcheck_code_kiting.fetchcheckkitting(Barcode, Marterial, SLOC).then((value4) {
    //post
    _objcheck_code_kiting.fetchcheckkitting_post(Barcode, Marterial, SLOC).then((value4) {
      if(value4 == '-2')
      {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.red,
                content: Text('NG, Thung hang nay chua duoc luu \n Hoac thung hang nay da het!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
              );
            });
        _GRbox.text = "";
        grboxid.requestFocus();
      }
      else if(value4 == '0')
      {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.red,
                content: Text('NG, KHONG PHAI LOT MIN!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
              );
            });
        _GRbox.text = "";
        grboxid.requestFocus();
      }
      else if(value4 == '-3')
      {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.red,
                content: Text('NG, Khong phai thung le!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
              );
            });
        _GRbox.text = "";
        grboxid.requestFocus();
      }
      else if(value4 == '-4')
      {
        //Ban co muon MO KHOA khong?
        showAlertDialog(context,Barcode);
        //print('vao truong hop 4');
        _GRbox.text = "";
        grboxid.requestFocus();
      }
      else
      {
        //result == "-1" ==>  result = Qty  (truong hop nay QTY > 0)
        print("vao truong hop -1");
        var qty = value4.toString();
        print(qty);
        _ActualQty.text = qty;
        //remainder = float.Parse(lblQty.Text) - float.Parse(lblQtyActual.Text);
        //print(double.parse(lblQty.toString()));
        if(lblQtyActual == '')
        {
          lblQtyActual = "0";
        }
        //print(double.parse(lblQtyActual.toString()));
        remainder = (double.parse(lblQty.toString()) - double.parse(lblQtyActual.toString())).toString();
        print('phan con lai: ${remainder}');

        if(double.parse(remainder) > double.parse(qty))
        {
          setState(() {
            lblQtyActual = (double.parse(lblQtyActual.toString()) + double.parse(qty.toString())).toString();
          });
          //print('vao a');
          //print(lblQtyActual);
        }
        else
        {
          setState(() {
            lblQtyActual = (double.parse(lblQtyActual.toString()) + double.parse(remainder.toString())).toString();
          });
          //print('vao b');
          _ActualQty.text = remainder;
        }
        //thuc hien kitting
        String GetQuantity = _ActualQty.text.toString();
        //print(Barcode);
        //print(GetQuantity);
        //use post
        _objkitting_trantemp.Updatetrantemp_post(Barcode, GetQuantity).then((return1) {
          //_objkitting_trantemp.Updatetrantemp(Barcode, GetQuantity).then((return1) {
          //add list value + list barcode o day
          //strValue += "(,,'" + dr["Barcode"].ToString() + "'," + dr["Qty"].ToString() + ",0,getdate()),";
          //str_barcode += "'" + dr["Barcode"].ToString() + "',";
          final getdate = DateTime.now();
          //print(getdate);   //2023-07-10 17:01:20.964903
          //String _getdate = DateFormat('yyyy-MM-dd').format(getdate);
          String _getdate = 'getdate()';
          print(_getdate);

          setState(() {
            //(,,'21022577;2300000442;1;07/05/2023;4500268207;11;PNPG3964009ZA/V2;120;120;1;05/07/2023-DP;00001',50,0,2023-07-10 17:01:20.964903),
            _strValue += "(,,'" + _GRbox.text.toString() + "'," + _ActualQty.text.toString() + ",0,"+_getdate+"),";
            //'21022577;2300000442;1;07/05/2023;4500268207;11;PNPG3964009ZA/V2;120;120;1;05/07/2023-DP;00001',
            _str_barcode += "'" + _GRbox.text.toString() + "',";
            _str_barcode2 += _GRbox.text.toString() + "|";
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
            //'21022577;2300000442;1;07/05/2023;4500268207;11;PNPG3964009ZA/V2;120;120;1;05/07/2023-DP;00001'
          });

          print(strValue);
          print(str_barcode);

          //add item into table
          String ID = lastID.toString();
          String barcode = _GRbox.text.trim();
          String soluong = _ActualQty.text.trim();
          //doi tuong obj
          ViewTable p = ViewTable(int.parse(ID), soluong, barcode);
          //list -> data
          AddLst.add(p);
          lastID++;
          if(return1 ==  true)
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
              _GRbox.text="";
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
                    content: Text('NG,Khong kitting duoc thung nay!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                  );
                });
            _GRbox.text = "";
            grboxid.requestFocus();
          }
        });
      }
    });
  }

  void update_kitting(BuildContext context) {
    String Status = stt;
    String Quantity = lblQtyActual.toString();
    String QtyPlan = lblQty.toString();
    String UserID = datauser;//"2012757";
    String BarcodePartcard = _Barcode.text.trim().toString();
    String ValueArr = strValue;
    String ListBarcode = str_barcode;
    String BarcodeCarton = '';

    print(Partcode);
    print (Quantity);
    print(QtyPlan);
    print(Model);
    print(Time);
    print(Issue_sloc);
    print(DeliveryDate);
    print(BarcodeCarton);
    print(BarcodePartcard);
    print(TypeKitting);
    print(Status);
    print(UserID);
    print(Plant);
    print(ValueArr);
    print(ModelQty);
    print(ListBarcode);

    //truong hop hang thieu => lay gia tri dau tien cua list box
    if(Status == '10')
    {
      BarcodeCarton = AddLst[0].Barcode.toString();
    }
    else
    {
      BarcodeCarton = _GRbox.text.trim().toString();
    }
    //print('barcode2');
    //print(BarcodeCarton);
    //_objkitting_plan.kittingplan(Partcode, Quantity, QtyPlan, Model, Line, Time, Issue_sloc, DeliveryDate, BarcodeCarton,
    //    BarcodePartcard, TypeKitting, Status, UserID, Plant, ValueArr, ModelQty, ListBarcode).then((return2) {
    //post
    _objkitting_plan.kittingplan_post(Partcode, Quantity, QtyPlan, Model, Line, Time, Issue_sloc, DeliveryDate, BarcodeCarton,
        BarcodePartcard, TypeKitting, Status, UserID, Plant, ValueArr, ModelQty, ListBarcode).then((return2) {
      print(return2);
      if(return2 == true)
      {
        if(Status =='0')
        {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.green,
                  content: Text('Da lay du so luong kitting! Kitting thanh cong!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
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
                  content: Text('Kitting hang thieu thanh cong!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
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

  showAlertDialog_shortage(BuildContext context) {
    // set up the buttons
    Widget continueButton = TextButton(
      child: Text("YES"),
      onPressed: () {

        update_kitting(context);

        Navigator.of(context, rootNavigator: true).pop(true); // dismisses only the dialog and returns true
        /*  showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Kitting thanh cong!'),
              );
            });*/
      },
    );
    Widget cancelButton = TextButton(
      child: Text("NO"),
      onPressed: () {
        //Navigator.of(context).pop();
        _GRbox.text = "";
        grboxid.requestFocus();
        Navigator.of(context, rootNavigator: true)
            .pop(false); // dismisses only the dialog and returns false
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Thong Bao"),
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

  showAlertDialog(BuildContext context, String Barcode) {
    // set up the buttons
    Widget continueButton = TextButton(
      child: Text("unlock"),
      onPressed: () {
        //Navigator.of(context).pop();
        //xu ly su kien o day

        //print('beint duoc dua len ${Barcode}');
        //_objunlock_barcode_kitting.ulbarcodekitting(Barcode).then((value5) {
        _objunlock_barcode_kitting.ulbarcodekitting_post(Barcode).then((value5) {
          //if(value5 == 'true')
          if(value5 == true)
          {
            setState(() {
              display ='0'; //assign any string value from result to display variable.
            });
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.green,
                    content: Text('MO KHOA thanh cong. Ban hay scan lai thung hang nay!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                  );
                });
            //_GRbox.text = "";
            //grboxid.requestFocus();
          }else
          {
            //unlock NG
            //MessageBox.Show("MO KHOA that bai.");
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.red,
                    content: Text('MO KHOA that bai.!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                  );
                });
          }
        });
        Navigator.of(context, rootNavigator: true).pop(true); // dismisses only the dialog and returns true
        /* showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.green,
                content: Text('MO KHOA thanh cong. Ban hay scan lai thung hang nay!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
              );
            });*/
      },
    );
    Widget cancelButton = TextButton(
      child: Text("NO"),
      onPressed: () {
        //xu ly du lieu o day
        //Navigator.of(context).pop();
        _GRbox.text = "";
        grboxid.requestFocus();
        Navigator.of(context, rootNavigator: true).pop(false); // dismisses only the dialog and returns false
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Thong Bao!"),
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

  reset()
  {
    setState(() {
      _GRbox.text='';
      _Barcode.text = '';
      _ActualQty.text='';
      setfocus.requestFocus();
      ModelQty = '0';
      lblQty = '0';
      lblQtyActual = '0';
      stt = '0';
      str_barcode='';
      _str_barcode='';
      str_barcode2='';
      _str_barcode2='';
      strValue='';
      _strValue='';
      View_plant = false;
      isChecked = false;

      lastID = 1;
      AddLst= []; //reset table null
      ViewLst=[]; //reset table null

      display ='0';
      thongbao='';
    });
    //hideinputtextfield();

  }

}