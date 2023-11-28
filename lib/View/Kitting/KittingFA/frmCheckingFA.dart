import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../Controller/Kitting/KittingFA/api_checkingFA.dart';
import '../../../Model/Kitting/KittingFA/Class_checkingFA.dart';
import 'MenuKittingFA.dart';

//libary focus
import 'package:flutter_datawedge/models/scan_result.dart';
import 'package:flutter_datawedge/flutter_datawedge.dart';
import 'dart:io';
/*void main()
{
  runApp(new CheckingFA());
}*/

class CheckingFA extends StatelessWidget {

  const CheckingFA({Key? key, required this.UserID}) : super(key: key);
  final String UserID;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)  {

    return new MaterialApp(
      home: new ExampleWidget(datauser: UserID,),
      debugShowCheckedModeBanner: false,
      //home: new ExampleWidget(),
    );
  }
}

class dt_kittingTran {
  String Partcode, Status,Quantity,Model,Line,Time,Issue_Sloc,DeliveryDate,BarcodeCarton,BarcodePartcard,TypeKitting,StatusDelay,SttCheck;
  dt_kittingTran(this.Partcode, this.Status, this.Quantity,this.Model,this.Line, this.Time, this.Issue_Sloc, this.DeliveryDate, this.BarcodeCarton,this.BarcodePartcard,this.TypeKitting,this.StatusDelay,this.SttCheck);
}

class dt_notYetKitting{
  String Partcode,Time,Position,PIC,Model,Line,Issue_Sloc,Deliverydate;
  int Status;
  double quantity;
  dt_notYetKitting(this.Partcode,this.quantity,this.Time,this.Position,this.PIC,this.Model,this.Line,this.Status,this.Issue_Sloc,this.Deliverydate);
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
  bool statussort = false;
  //bool _showCircle = true;

  //bien focus
  late StreamSubscription<ScanResult> onScanResultListener;
  late FlutterDataWedge fdw;


  List<dt_kittingTran> _obj_dt_kittingtran = <dt_kittingTran>[];
  List<dt_notYetKitting> _obj_dt_notYetKitting = <dt_notYetKitting>[];

  List<Get_KittingTran_Partcard_All> _obj_dt_showall = List.empty();

  GetKittingTrans _callapi_trantemp = new GetKittingTrans();

  //List<Supply_NTime_Delivery> _obj_dt_temp_Ntime = <Supply_NTime_Delivery>[];
  //List<Supply_1Time_Delivery>  _obj_dt_temp_1time =  List.empty();

  var txtCode = new TextEditingController();
  bool txtcodeEnabled = true;
  var txtTrays = new TextEditingController();
  var txtQuantity = new TextEditingController();

  var focusNode = FocusNode();  //gia tri focus
  final FocusNode listrid = FocusNode();
  late FocusNode codeboxid = FocusNode();
  late FocusNode qtyid = FocusNode();

  int count_dt_temp = 0;
  bool _check_shortage = false;
  String _typecheck ='';
  bool blnScan = false;
  String Check_delay = "0";
  bool ckbListNotYetKitting = false;
  bool ckbshowall = false;
  bool ckbshowall_yesno = false;

  bool _checkpartcard_Supply = false;
  bool _checkingpartcard_had_scan = false;
  bool _check_Supply_Full = true;

  String TypeKitting='';
  String Deliverydate='';
  String Model='';
  String Line='';
  String Time='';
  String Category='';
  String Category_JT='';
  String Plant='';

  //int _currentSortColumn = 11;
  int _currentSortColumn = 0;
  bool _isAscending = true;
  //bool _isAscending = false;

  String display = '';
  int _index = 0;
  int _count = 0;
  String thongbao='';

  @override
  // Method that call only once to initiate the default app.
  void initState() {
    //Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
    super.initState();
    initScanner();
  }
  void initScanner() {
    if (Platform.isAndroid) {
      fdw = FlutterDataWedge(profileName: 'FlutterDataWedge');
      onScanResultListener = fdw.onScanResult
          .listen((result) => setState(() {
        if(codeboxid.hasFocus)
        {
            //print('abc');
            txtTrays.text = result.data;
            codebox_function(result.data, context);
        }else if(listrid.hasFocus)
        {
          txtCode.text = result.data;
          ListR_function(result.data, context);
        }

      } ));
    }
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    listrid.dispose();
    codeboxid.dispose();
    qtyid.dispose();
    super.dispose();
    //reduce ram focus
    onScanResultListener.cancel();
  }

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

  @override
  Widget build(BuildContext context) {
    //Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
    return Scaffold(
      appBar: AppBar(title: Text("Checking FA type : ${thongbao}",)),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.send),
        onPressed: () {
          setState(() {
            reset();
          });
        },
      ),
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20), //, vertical: 15
            child: TextField(

              autofocus: true,
              controller: txtCode,
              focusNode: listrid,
              //keyboardType: TextInputType.none,
              readOnly: true,
              showCursor: true,
              //readOnly: true,
              //enabled: txtcodeEnabled,//true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'List R',
                hintText: '',
              ),
              onSubmitted: (value)
              {
                //ListR_function(value, context);

              },
            ),
          ),
          /*const SizedBox(
            height: 5.0,
          ),*/
          Container(
            /* margin: EdgeInsets.all(10),*/
            /* margin: const EdgeInsets.only(top: 10.0),*/
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
            child:
                TextField(
                  controller: txtTrays,
                  focusNode: codeboxid,
                  readOnly: true,
                  showCursor: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Code Box',
                    hintText: '',
                  ),
                  /*onTapOutside: (event) {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                  },*/
                  onSubmitted: (value)
                  {
                    //codebox_function(value, context);

                  },
                ),
                //SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 5.0),



          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 70.0,
                    height: 50.0,
                    child: TextField(
                      controller: txtQuantity,
                      focusNode: qtyid,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Qty',
                        hintText: '',
                      ),
                      onSubmitted: (value)
                      {
                        //truong hop nay hoi user==> vi trong code thay cac truong khong lien quan *****
                      },
                    ),
                  ),

                  SizedBox(
                    child: Container(
                      width: 120.0,
                      height: 50.0,
                      //color: Colors.red,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: CheckboxListTile(
                          title: const Text("List No Kitting",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                          value: this.ckbListNotYetKitting,
                          onChanged: (bool? value) {
                            setState(() {
                              ckbListNotYetKitting = value!;
                            });

                            if(ckbListNotYetKitting == true)
                            {
                              //print('vao truong hop show list');
                              //print(ckbListNotYetKitting);
                              //print(_check_Supply_Full);
                              //if(blnScan == true)
                              if(txtCode.text != '')
                              {
                                setState(() {
                                  //ckbListNotYetKitting = true;
                                  _obj_dt_kittingtran = [];  //reset ve null
                                  _obj_dt_showall = [];
                                });

                                String Partcode ="";
                                String DeliveryDate = Deliverydate;
                                String TypeKit = TypeKitting;
                                String CATEGORY = Category;
                                String _Time = Time;
                                //print('vao blnScan == true');
                                //print(DeliveryDate);
                                //print(TypeKit);
                                //print(CATEGORY);
                                //print(CATEGORY);

                                if(TypeKit =="0")
                                {
                                  //n time
                                  dt_notyes_kitting(Partcode, DeliveryDate, TypeKit, CATEGORY, context, _Time);
                                }
                                else if(TypeKit =="1")
                                {
                                  //1 time
                                  dt_notyes_kitting(Partcode, DeliveryDate, TypeKit, CATEGORY, context, _Time);
                                }
                                else if(TypeKit =="8")
                                {
                                  //XHGopModel
                                  dt_notyes_kitting(Partcode, DeliveryDate, TypeKit, CATEGORY, context, _Time);
                                }
                                else if(TypeKit =="2")
                                {
                                  //PrepareNTime
                                  dt_notyes_kitting(Partcode, DeliveryDate, TypeKit, CATEGORY, context, _Time);
                                }
                                else
                                {
                                  //Prepare1Time
                                  dt_notyes_kitting(Partcode, DeliveryDate, TypeKit, CATEGORY, context, _Time);
                                }
                              }
                              else
                              {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.red,
                                        content: Text('Ban hay scan de show list check_kitting!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),  //MessageBox.Show("Ban phai scan ma code");
                                      );
                                    });

                                setState(() {
                                  //ckbListNotYetKitting = false;
                                  _obj_dt_notYetKitting = [];  // reset ve null
                                  _obj_dt_showall = [];
                                });
                                listrid.requestFocus();
                                //hideinputtextfield();
                                //print('vao blnScan == false');
                              }

                            }
                            else
                            {
                              //reset();
                              setState(() {
                                //ckbListNotYetKitting = false;
                                _obj_dt_notYetKitting = [];  // reset ve null
                                _obj_dt_kittingtran = [];
                              });

                              //txtcodeEnabled=true;
                              txtCode.text = "";
                              txtCode.text = "";
                              listrid.requestFocus();
                              //hideinputtextfield();
                            }

                          },
                        ),
                      )
                    ),
                  ),
                  SizedBox(
                      child: Container(
                        width: 110.0,
                        height: 50.0,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: CheckboxListTile(
                            title: const Text("List All",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                            value: this.ckbshowall,
                            onChanged: (bool? value) async {
                              setState(() {
                                ckbshowall = value!;
                              });

                              if(ckbshowall == true)
                              {
                                //print('vao truong hop show all');
                                //print(ckbshowall);

                                if(txtCode.text != '')
                                {
                                  setState(() {
                                    _obj_dt_notYetKitting =[];
                                    _obj_dt_kittingtran = [];  //reset ve null
                                  });

                                  _obj_dt_showall = ( await _callapi_trantemp.get_dt_kittingTran_all(TypeKitting,Deliverydate,Model,Line,Time,Category,Category_JT))!;
                                  if(_obj_dt_showall.length > 0)
                                  {
                                    setState(() {
                                      ckbshowall_yesno = true;
                                      display = '1';
                                    });

                                  }
                                  else
                                  {
                                    setState(() {
                                      ckbshowall_yesno = false;
                                      display = '1';
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
                                          content: Text('Ban hay scan de show all!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),  //MessageBox.Show("Ban phai scan ma code");
                                        );
                                      });
                                  txtCode.text = "";
                                  listrid.requestFocus();
                                }

                              }
                              else
                              {
                                //reset();
                                //print ('vao 111');
                                //reset();
                                setState(() {
                                  _obj_dt_showall = [];
                                  _obj_dt_notYetKitting = [];  // reset ve null
                                  _obj_dt_kittingtran = [];

                                  ckbshowall_yesno = false;
                                });

                                //txtcodeEnabled=true;
                                txtCode.text = "";
                                txtQuantity.text="";
                                listrid.requestFocus();
                                //hideinputtextfield();

                              }

                            },
                          ),
                        ),
                      )

                  ),
                ],
              )
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: ElevatedButton(
                  child: Text('Home'),
                  onPressed: () {
                    if(_check_Supply_Full == false)
                    {
                      //bo cap nhat  ==> //Update_sttchecking
                      // back home  ==> luon  **** test thu doan nay***** giam thao tac


                      //part list chua duoc scan het=> ban co muon Are you exit?
                      //showAlertDialog_exit(context);

                      // back home
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => new MenuKittingFA(UserID: datauser)));

                    }
                    else
                    {
                      // back home
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => new MenuKittingFA(UserID: datauser)));
                    }
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                child: ElevatedButton(
                  child: Text('Confirm'),
                  onPressed: () {
                    if(txtCode.text == "")
                    {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('Ban chua nhap du du lieu!'),  //MessageBox.Show("Partcard da duoc scan");
                            );
                          });
                      listrid.requestFocus();
                      //hideinputtextfield();
                    }
                    else
                    {
                      //check xem da scan du list hay chua?
                      if(_check_Supply_Full ==  false)
                      {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text('ban chua scan code box id!'),  //MessageBox.Show("Partcard da duoc scan");
                              );
                            });
                        codeboxid.requestFocus();
                        //hideinputtextfield();
                      }
                      else
                      {
                        // da checking day du part list
                        if(_check_shortage == false)
                        {
                          update_checking(context);
                        }
                        else
                        {
                          //truong hang thieu
                          showAlertDialog_update_shortage(context);
                        }
                      }

                    }
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
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
    );
  }

  void ListR_function(String value, BuildContext context) {
    try
    {
      if(value != '')
      {
        //VL-SE35XLA-V4; 3M;07/18/2023;06:00;1;VR01;DP;DP;R
        var chuoi = txtCode.text.toString();
        List<String>? itemList;
        itemList = chuoi.split(";");
        print(chuoi);

        if (itemList != null && itemList.length == 9)
        {
          var output = chuoi[chuoi.length - 1];
          print(output);
          if(output == 'R')
          {
            blnScan = true;  // bien de chan su kien check box  khi dang scan
            _typecheck = itemList[4].toString();
            TypeKitting = itemList[4].toString();
            Deliverydate = itemList[2].toString();
            Model = itemList[0].toString();
            Line = itemList[1].toString();
            Time = itemList[3].toString();
            Category = itemList[6].toString();
            Category_JT = itemList[7].toString();


            Plant = itemList[5].toString();
            print('toi day');
            print(TypeKitting);
            print(Deliverydate);
            print(Model);
            print(Line);
            print(Time);
            print(Category);
            print(Category_JT);
            //thongbao
            if(_typecheck == "0")
            {
              setState(() {
                thongbao = "ntime";
              });
            }
            else if(_typecheck == "1")
            {
              setState(() {
                thongbao = "1time";
              });
            }
            else if(_typecheck == "2")
            {
              setState(() {
                thongbao = "Preparation NTime";
              });
            }
            else if(_typecheck == "8")
            {
              setState(() {
                thongbao = "Gop Model";
              });
            }
            else
            {
              setState(() {
                thongbao = "Preparation 1Time";
              });
            }

            _callapi_trantemp.fetchkittingtrans(TypeKitting, Deliverydate, Model, Line, Time, Category, Category_JT).then((value) async {
              if(value.isEmpty)
              {
                //print(value);
                if(ckbListNotYetKitting == true)
                {
                  //truong hop show list da duoc checking het!
                  /*showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.red,
                            content: Text('List da checking het!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold), ),
                          );
                        });
                    ckbListNotYetKitting = false;
                    txtCode.text = "";
                    listrid.requestFocus();*/
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.red,
                          content: Text('List da checking het.\n Ban tick lai de show list chua kitting!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                        );
                      });
                  setState(() {
                    ckbListNotYetKitting = false;
                  });

                  txtTrays.text ="";
                  codeboxid.requestFocus();
                  //hideinputtextfield();

                }
                else
                {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.red,
                          content: Text('NG, Ma List nay khong the kiem tra!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                        );
                      });
                  txtCode.text = "";
                  listrid.requestFocus();
                  //hideinputtextfield();
                }

              }
              else
              {
                //truong hop list da duoc kitting buoc 1  // add list table

                //add item into table
                String _Partcode = '';
                String _Status = '';
                String _Quantity ='';
                String _Model='';
                String _Line='';
                String _Time='';
                String _Issue_Sloc='';
                String _DeliveryDate='';
                String _BarcodeCarton='';
                String _BarcodePartcard='';
                String _TypeKitting='';
                String _StatusDelay='';
                String _SttCheck='';

                for(var i=0; i< value.length; i++)
                {
                  //print(i);
                  _Partcode= value[i].Partcode.toString();
                  _Status=value[i].Status.toString();
                  _Quantity=value[i].Quantity.toString();
                  _Model=value[i].Model.toString();
                  _Line =value[i].Line.toString();
                  _Time=value[i].Time.toString();
                  _Issue_Sloc=value[i].Issue_Sloc.toString();
                  _DeliveryDate=value[i].DeliveryDate.toString();
                  _BarcodeCarton=value[i].BarcodeCarton.toString();
                  _BarcodePartcard=value[i].BarcodePartcard.toString();
                  _TypeKitting=value[i].TypeKitting.toString();
                  _StatusDelay=value[i].StatusDelay.toString();
                  _SttCheck=value[i].SttCheck.toString();
                  //print (_Partcode);

                  dt_kittingTran p = dt_kittingTran(value[i].Partcode.toString(),value[i].Status.toString(),value[i].Quantity.toString(),value[i].Model.toString(),value[i].Line.toString(),
                      value[i].Time.toString(),value[i].Issue_Sloc.toString(),value[i].DeliveryDate.toString(),value[i].BarcodeCarton.toString(),value[i].BarcodePartcard.toString(),
                      value[i].TypeKitting.toString(),value[i].StatusDelay.toString(),value[i].SttCheck.toString());
                  _obj_dt_kittingtran.add(p);

                  if(_StatusDelay == "1")
                  {
                    Check_delay = "1";
                  }

                }
                //show gridview
                setState(() {
                  display ='1';
                });

                //Check_delay()  // check ma hang delay
                if(Check_delay == "1")
                {
                  //*********truong hop nay teset sau *********
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.red,
                          content: Text('Model nay bi tam hoan.\nKhong the kiem tra',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                        );
                      });
                  txtCode.text= "";
                  listrid.requestFocus();
                  _check_shortage = false;
                  //hideinputtextfield();
                }
                else
                {
                  String Barcode = txtCode.text.toString();
                  print('type check');
                  print(_typecheck);
                  switch(_typecheck)
                  {
                    case "0":
                      print('n time');
                      String type_check = "0";
                      String name_stored = "Supply_NTime_Delivery";
                      textcode_Data(Barcode, type_check, name_stored, context);
                      break;
                    case "1":
                    /* _obj_dt_temp_1time = await _callapi_trantemp.fetchtrantemp(Barcode);
                            print('alo');
                            print(_obj_dt_temp_1time);*/
                      String type_check = "1";
                      String name_stored = "Supply_1Time_Delivery";
                      textcode_Data(Barcode, type_check, name_stored, context);
                      print('1 time');
                      break;
                    case "2":
                      String type_check = "2";
                      String name_stored = "Supply_PreparetionNTime";
                      textcode_Data(Barcode, type_check, name_stored, context);
                      print('Preparation NTime');
                      break;
                    case "8":
                      String type_check = "8";
                      String name_stored = "Supply_XHGopModel_Delivery";
                      textcode_Data(Barcode, type_check, name_stored, context);
                      print('Gop Model');
                      break;
                    default:
                      String type_check = "3";
                      String name_stored = "Supply_Preparetion_Delivery";
                      textcode_Data(Barcode, type_check, name_stored, context);
                      print('kitting other');
                      break;
                  }
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
                    content: Text('NG, Format List barcode!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                  );
                });
            blnScan = false;
            txtCode.text="";
            listrid.requestFocus();
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
                  content: Text('NG, Format List barcode!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold), ),
                );
              });
          blnScan = false;
          txtCode.text="";
          listrid.requestFocus();
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
                content: Text('NG, du lieu null!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
              );
            });
        blnScan = false;
        listrid.requestFocus();
        //hideinputtextfield();
      }
    }
    catch(e)
    {
      thongbaoNG(context, e.toString());
    }
  }

  void codebox_function(String value, BuildContext context) {
    try
    {
      if(value != '')
      {
        var barcode_tray = txtTrays.text.toString();
        var barcode_list = txtCode.text.toString();
        List<String>? itemList2;
        itemList2 = barcode_tray.split(";");
        print(itemList2.length);

        //print(barcode_tray);

        //set lai gia tri count supply full
        setState(() {
          _count = 0;
        });

        //print(_obj_dt_kittingtran.length);
        //print(barcode_tray);
        print('vao day');
        print(_obj_dt_kittingtran.length);

        for(int t=0;t< _obj_dt_kittingtran.length; t++)
        {
          //print(t);
          //print(_obj_dt_kittingtran[t].BarcodePartcard);
          //print(barcode_tray);
          if(barcode_tray == _obj_dt_kittingtran[t].BarcodePartcard.toString())
          {
            // print('---------');
            //print(t);
            //print(_obj_dt_kittingtran[t].BarcodePartcard.toString());
            _checkpartcard_Supply = true;
            _index = t;
            //break;
          }
        }
        //check part card da duoc kitting buoc 1 hay chua?
        print('part da duoc kitting chua  (vong 1): ${_checkpartcard_Supply}');
        print('gia trin index = so dong can lay gia tri:');
        print (_index);

        if(_checkpartcard_Supply ==  true)
        {
          //check xem partcad da duoc ban checking buoc 2 hay chua?
          for(int row=0;row< _obj_dt_kittingtran.length; row++)
          {
            //private int Supply_int(string _partcode)
            if(_obj_dt_kittingtran[_index].SttCheck != "1" )
            {
              //chua duoc ban checking buoc 2
              _checkingpartcard_had_scan = true;
              //break;
            }
            else
            {
              //ma da scan checking buoc 2
              _checkingpartcard_had_scan = false;
            }
          }

          print('Parcard da duoc checking buoc 2 hay chua : ${_checkingpartcard_had_scan}');
          if(_checkingpartcard_had_scan == true)
          {
            //chua duoc checking het
            //dt_kittingTran.Rows[Supply_int(txtTrays.Text.Trim())]["SttCheck"] = "1";   //set lai gia tri partcard duoc ban checking
            //set_value_Listview();    // set lai mau cua bang ban checking  -> test ok-> test lai voi user
            print('gia tri _index truoc: ${_index}');
            //_obj_dt_kittingtran[_index].SttCheck = "1";  //Pending ngay mai***
            setState(() {
              _obj_dt_kittingtran[_index].SttCheck = '1';
              display = '1'; //update ma vua checking
              //_index = _index+1;
            });

            //update luon trang thai checking
            //pendingcheck  updatesttcheck
            String Update_user = datauser;

            _callapi_trantemp.Update_sttchecking(barcode_tray,barcode_list,Update_user).then((value) async => {
              if(value == true)
                {
                  //nothing
                }
              else{}
            });

            //Supply_Full()
            for (int i = 0; i < _obj_dt_kittingtran.length; i++)
            {
              print('bat dau');
              print(_obj_dt_kittingtran[i].SttCheck);
              if (_obj_dt_kittingtran[i].SttCheck != '1')
              {
                //if(listView1.Items[i].BackColor ==Color.Green)
                _check_Supply_Full = false;
                //break;
              }
              else
              {
                setState(() {
                  _count = _count+1;
                });
              }
            }
            print("gia tri ccount: ${_count}");   //uid=10230(com.example.fosstest) 1.ui identical 1 line  ==> gia tri update : SttCheck
            print(_count);
            //set gia tri supply full
            if(_count == _obj_dt_kittingtran.length)
            {
              print('full checking OK');
              _check_Supply_Full = true;
            }
            else
            {
              print('list not checking full');
              _check_Supply_Full = false;
            }

            print('Part list da duoc scan du het chua: ${_check_Supply_Full}');
            if(_check_Supply_Full == true)     // check xem part list da duoc checking du chua?
                {
              //pending123
              /*setState(() {
          display = '1'; //update ma vua checking
        });*/
              //MessageBox.Show("Da check du list kitting", "Thong bao");
              //btconfirm_Click(sender, e);
              print(_check_shortage);
              if(_check_shortage == false)
              {
                print('truong hop hang da kitting du');
                //truong hop hang da kitting du
                //bool kq = _supply1.tblKitting_Trans_PartCard_Temp_Update_New(
                //Reservation_Code = barcode list

                update_checking(context);

              }
              else
              {
                print('vao truong hop hang thieu!');
                //truong hang thieu
                showAlertDialog_update_shortage(context);
              }

            }
            else      // chua du scan tiep?
                {
              //print('gia tri _index tiep theo: ${_index}');
              //pending123
              txtTrays.text="";
              codeboxid.requestFocus();
              //hideKeyboard(context,"codeboxid");
              //Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
              //FocusScope.of(context).requestFocus(codeboxid);
              //hideinputtextfield();
            }
          }
          else
          {
            //_checkingpartcard_had_scan == false  ==> da duoc checking het
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.red,
                    content: Text('NG, Ma da duoc Scan!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),  //MessageBox.Show("Partcard da duoc scan");
                  );
                });
            txtTrays.text="";
            codeboxid.requestFocus();
            //hideinputtextfield();
          }
          //--------------------------------------------

        }
        else
        {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.red,
                  content: Text('NG, Ma nay chua duoc checking buoc 1, or NG format!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),  //MessageBox.Show("Partcard kitting khong ton tai");  //Ma nay khong ton tai
                );
              });
          txtTrays.text="";
          codeboxid.requestFocus();
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
                content: Text('NG, Quyet thung hang!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),  //MessageBox.Show("Ban phai scan ma code");  //Quyet thung hang.  //Scan barcode Trays!
              );
            });
        codeboxid.requestFocus();
        //hideinputtextfield();
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

  void hideinputtextfield() {
    Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
  }

  void hideKeyboard(BuildContext context, String nameid) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    print('gia tri focus');
    print(nameid);
    if(nameid == 'codeboxid')
    {
      txtTrays.text="";
      txtTrays.selection= TextSelection(baseOffset: 0, extentOffset: txtTrays.text.length);
      //Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
      //codeboxid.requestFocus();
      //hideinputtextfield();
      /*if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
        FocusManager.instance.primaryFocus?.unfocus();
      }*/
    }
  }

  Widget createTable(BuildContext context, AsyncSnapshot snapshot) {
    return  SingleChildScrollView(
      /* scrollDirection: Axis.vertical,*/
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        //height: MediaQuery.of(context).size.height * 0.3,
        child:LayoutBuilder(builder: (context, constraints) {
          //if check box o day hang thieu hoac khong thieu
          //if( _check_shortage ==  true)
          if( ckbListNotYetKitting == true)
          {
            return SingleChildScrollView(
              /*scrollDirection: Axis.horizontal,*/
              scrollDirection: Axis.vertical,
              //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(
                      label: Text("Partcode"),
                    ),
                    DataColumn(
                      label: Text("Quantity"),
                    ),
                    DataColumn(
                      label: Text("Time"),
                    ),
                    DataColumn(
                      label: Text("Position"),
                    ),
                    DataColumn(
                      label: Text("PIC"),
                    ),
                    DataColumn(
                      label: Text("Model"),
                    ),
                    DataColumn(
                      label: Text("Line"),
                    ),
                    DataColumn(
                      label: Text("Status"),
                    ),
                    DataColumn(
                      label: Text("Issue_Sloc"),
                    ),
                    DataColumn(
                      label: Text("Deliverydate"),
                    ),

                  ],   //_obj_dt_kittingtran
                  rows: _obj_dt_notYetKitting.map(
                        (p) => DataRow(cells: [
                      DataCell(
                        Text(p.Partcode),
                      ),
                      DataCell(
                        Text(p.quantity.toString()),
                      ),
                      DataCell(
                        Text(p.Time),
                      ),
                      DataCell(
                        Text(p.Position),
                      ),
                      DataCell(
                        Text(p.PIC),
                      ),
                      DataCell(
                        Text(p.Model),
                      ),
                      DataCell(
                        Text(p.Line),
                      ),
                      DataCell(
                        Text(p.Status.toString()),
                      ),
                      DataCell(
                        Text(p.Issue_Sloc),
                      ),
                      DataCell(
                        Text(p.Deliverydate),
                      ),
                    ]),
                  ).toList(),
                ),
              ),
            );
          }
          else if(ckbshowall_yesno == true)
          {
            //show all
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  sortColumnIndex: _currentSortColumn,
                  sortAscending: _isAscending,
                  headingRowColor: MaterialStateProperty.all(Colors.amber[200]),
                  columns: [
                    DataColumn(
                        label: Text("SttCheck"),
                        onSort: (columnIndex, _) {
                          setState(() {
                            _currentSortColumn = columnIndex;
                            if (_isAscending == true) {
                              _isAscending = false;
                              // sort the product list in Ascending, order by Price
                              _obj_dt_showall.sort((a, b) =>
                                  a.SttCheck.compareTo(b.SttCheck));
                            } else {
                              _isAscending = true;
                              // sort the product list in Descending, order by Price
                              _obj_dt_showall.sort((a, b) =>
                                  a.SttCheck.compareTo(b.SttCheck));
                            }
                          });
                        }
                    ),
                    DataColumn(
                      label: Text("Partcode"),
                    ),
                    DataColumn(
                      label: Text("Qty"),
                    ),
                    DataColumn(
                      label: Text("Time"),
                    ),
                    DataColumn(
                      label: Text("Model"),
                    ),
                    DataColumn(
                      label: Text("Line"),
                    ),
                    DataColumn(
                      label: Text("Status"),
                    ),
                    DataColumn(
                      label: Text("TypeKitting"),
                    ),

                  ],   //_obj_dt_kittingtran
                  rows: _obj_dt_showall.map(
                        (p) => DataRow(
                        color: MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                              // All rows will have the same selected color.
                              /*if (states.contains(MaterialState.selected)) {
                                                         return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                                                       }*/
                              if(p.SttCheck.toString() == "1")
                              {
                                return Colors.green;
                              }else
                              {
                                //return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                                return Colors.white;
                              }
                              // Even rows will have a grey color.
                              /*if (index.isEven) {
                                                         return Colors.grey.withOpacity(0.3);
                                                       }*/
                              return null; // Use default value for other states and odd rows.
                            }),
                        cells: [
                          DataCell(
                            Text(p.SttCheck.toString()),
                          ),
                          DataCell(
                            Text(p.Partcode.toString()),
                          ),
                          DataCell(
                            Text(p.Quantity.toString()),
                          ),
                          DataCell(
                            Text(p.Time),
                          ),
                          DataCell(
                            Text(p.Model),
                          ),
                          DataCell(
                            Text(p.Line),
                          ),
                          DataCell(
                            Text(p.Status.toString()),
                          ),
                          DataCell(
                            Text(p.TypeKitting),
                          ),

                        ]),
                  ).toList(),
                ),
              ),
            );
          }
          else
          {
            return HorizontalDataTable(
              leftHandSideColumnWidth: 150,
              rightHandSideColumnWidth: 950,
              isFixedHeader: true,
              headerWidgets:_getTitleWidget(),
              leftSideItemBuilder: _generateFirstColumnRow,
              rightSideItemBuilder: _generateRightHandSideColumnRow,
              itemCount: _obj_dt_kittingtran.length,
              rowSeparatorWidget: const Divider(
                color: Colors.black38,
                height: 1.0,
                thickness: 0.0,
              ),


            );

          }


        }),
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
                      label: Text("Partcode"),
                    ),
                    DataColumn(
                      label: Text("Qty"),
                    ),
                    DataColumn(
                      label: Text("Time"),
                    ),
                    DataColumn(
                      label: Text("Model"),
                    ),
                    DataColumn(
                      label: Text("Line"),
                    ),
                    DataColumn(
                      label: Text("Status"),
                    ),
                    DataColumn(
                      label: Text("Issue_Sloc"),
                    ),
                    DataColumn(
                      label: Text("Deliverydate"),
                    ),
                    DataColumn(
                      label: Text("BarcodeCarton"),
                    ),
                    DataColumn(
                      label: Text("BarcodePartcard"),
                    ),
                    DataColumn(
                      label: Text("TypeKitting"),
                    ),
                    DataColumn(
                      label: Text("SttCheck"),
                    ),
                  ],
                  rows: const <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  void dt_notyes_kitting(String Partcode, String DeliveryDate, String TypeKit, String CATEGORY, BuildContext context, String _Time) {
    if(TypeKit == "0")
    {
      _callapi_trantemp.Select_KittingByType_Ntime(Model, Partcode, Line, Time, DeliveryDate, TypeKit, Plant, CATEGORY).then((value5) {
        if(value5.isEmpty)
        {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.red,
                  content: Text('Ntime, Du lieu Null!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),  //MessageBox.Show("Ban phai scan ma code");
                );
              });
        }
        else
        {
          //print(value5);
          //print('vao Ntime');
          //notyes
          for(int i=0;i<value5.length;i++)
          {
            print(value5[i].Partcode);
            print(value5[i].Quantity);
            print(_Time);
            print(value5[i].Position);
            print(value5[i].PIC);
            print(value5[i].Model);
            print(value5[i].Line);
            print(value5[i].Status);
            print(value5[i].Issue_sloc);
            print(value5[i].Deliverydate);

            dt_notYetKitting p = dt_notYetKitting(value5[i].Partcode,value5[i].Quantity,_Time,value5[i].Position,value5[i].PIC,value5[i].Model,value5[i].Line,value5[i].Status,value5[i].Issue_sloc,value5[i].Deliverydate);
            _obj_dt_notYetKitting.add(p);
          }
          setState(() {
            display = '1';
          });
        }
      });
    }
    else if(TypeKit == "1")
    {
      _callapi_trantemp.Select_KittingByType_1time(Model, Partcode, Line, Time, DeliveryDate, TypeKit, Plant, CATEGORY).then((value5) {
        if(value5.isEmpty)
        {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.red,
                  content: Text('Can not find Data!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),  //MessageBox.Show("Ban phai scan ma code");
                );
              });
        }
        else
        {
          //print(value5);
          //print('vao 1time');
          //notyes
          for(int i=0;i<value5.length;i++)
          {
            print(value5[i].Partcode);
            print(value5[i].quantity);
            print(_Time);
            print(value5[i].Position);
            print(value5[i].PIC);
            print(value5[i].Model);
            print(value5[i].Line);
            print(value5[i].Status);
            print(value5[i].Issue_Sloc);
            print(value5[i].Deliverydate);

            dt_notYetKitting p = dt_notYetKitting(value5[i].Partcode,value5[i].quantity,_Time,value5[i].Position,value5[i].PIC,value5[i].Model,value5[i].Line,value5[i].Status,value5[i].Issue_Sloc,value5[i].Deliverydate);
            _obj_dt_notYetKitting.add(p);
          }
          setState(() {
            display = '1';
          });
        }
      });
    }
    else if(TypeKit == "8")
    {
      _callapi_trantemp.Select_KittingByType_XHGopModel(Model, Partcode, Line, Time, DeliveryDate, TypeKit, Plant, CATEGORY).then((value5) {
        if(value5.isEmpty)
        {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.red,
                  content: Text('Can not find Data!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold), ),  //MessageBox.Show("Ban phai scan ma code");
                );
              });
        }
        else
        {
          print(value5);
          print('vao XHGopModel');
          //notyes
          for(int i=0;i<value5.length;i++)
          {
            print(value5[i].Partcode);
            print(value5[i].quantity);
            print(_Time);
            print(value5[i].Position);
            print(value5[i].PIC);
            print(value5[i].Model);
            print(value5[i].Line);
            print(value5[i].Status);
            print(value5[i].Issue_Sloc);
            print(value5[i].Deliverydate);

            dt_notYetKitting p = dt_notYetKitting(value5[i].Partcode,value5[i].quantity,_Time,value5[i].Position,value5[i].PIC,value5[i].Model,value5[i].Line,value5[i].Status,value5[i].Issue_Sloc,value5[i].Deliverydate);
            _obj_dt_notYetKitting.add(p);
          }
          setState(() {
            display = '1';
          });
        }
      });
    }
    else if(TypeKit == "2")
    {
      _callapi_trantemp.Select_KittingByType_PrepareNTime(Model, Partcode, Line, Time, DeliveryDate, TypeKit, Plant, CATEGORY).then((value5) {
        if(value5.isEmpty)
        {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.red,
                  content: Text('Can not find Data!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold), ),  //MessageBox.Show("Ban phai scan ma code");
                );
              });
        }
        else
        {
          print(value5);
          print('vao PrepareNTime');
          for(int i=0;i<value5.length;i++)
          {
            print(value5[i].Partcode);
            print(value5[i].Quantity);
            print(_Time);
            print(value5[i].Position);
            print(value5[i].PIC);
            print(value5[i].Model);
            print(value5[i].Line);
            print(value5[i].Status);
            print(value5[i].Issue_Sloc);
            print(value5[i].Deliverydate);

            dt_notYetKitting p = dt_notYetKitting(value5[i].Partcode,value5[i].Quantity,_Time,value5[i].Position,value5[i].PIC,value5[i].Model,value5[i].Line,value5[i].Status,value5[i].Issue_Sloc,value5[i].Deliverydate);
            _obj_dt_notYetKitting.add(p);
          }
          setState(() {
            display = '1';
          });
        }
      });
    }
    else
    {
      //default:   PrepareN1ime
      _callapi_trantemp.Select_KittingByType_Prepare1time(Model, Partcode, Line, Time, DeliveryDate, TypeKit, Plant, CATEGORY).then((value5) {
        if(value5.isEmpty)
        {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.red,
                  content: Text('Can not find Data!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),  //MessageBox.Show("Ban phai scan ma code");
                );
              });
        }
        else
        {
          print(value5);
          print('vao PrepareN1ime');
          //notyes
          for(int i=0;i<value5.length;i++)
          {
            print(value5[i].Partcode);
            print(value5[i].quantity);
            print(_Time);
            print(value5[i].Position);
            print(value5[i].PIC);
            print(value5[i].Model);
            print(value5[i].Line);
            print(value5[i].Status);
            print(value5[i].Issue_Sloc);
            print(value5[i].Deliverydate);

            dt_notYetKitting p = dt_notYetKitting(value5[i].Partcode,value5[i].quantity,_Time,value5[i].Position,value5[i].PIC,value5[i].Model,value5[i].Line,value5[i].Status,value5[i].Issue_Sloc,value5[i].Deliverydate);
            _obj_dt_notYetKitting.add(p);
          }
          setState(() {
            display = '1';
          });
        }
      });
    }
  }

  void textcode_Data(String Barcode, String type_check, String name_stored, BuildContext context) {
    if(type_check == "0")
    {
      //ntime
      _callapi_trantemp.fetchtrantemp_NTime(Barcode,type_check,name_stored).then((value2) async{
        print('======//value//====');
        if(value2!.isEmpty)
        {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.red,
                  content: Text('Ntime, Gia tri dt_temp null!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                );
              });
        }
        else
        {
          print('so luong ban ghi tran');
          print(_obj_dt_kittingtran.length);
          print('so luong dt temp');
          count_dt_temp = value2.length;
          print (count_dt_temp);

          //int check = Check_Shortage();  // check hang thieu  //_check_shortage
          if(_obj_dt_kittingtran.length == 0)
          {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.red,
                    content: Text('Partcode khong the checking!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                  );
                });
            _check_shortage = false;
            txtCode.text ="";
            listrid.requestFocus();
            //hideinputtextfield();
            // dataGrid1.DataSource = null;   ===> ***** set sau
          }
          else   //_obj_dt_kittingtran.length > 0
              {
            for(int k=0; k< _obj_dt_kittingtran.length; k++)
            {
              if(_obj_dt_kittingtran[k].Status == 10)
              {
                _check_shortage = true;   //int check = Check_Shortage();
                break; //thoat khoi vong lap
              }
            }

            if(count_dt_temp == _obj_dt_kittingtran.length && _check_shortage == true )  //
                {
              print("Model nay kitting dang thieu => so luong 2 bang = nhau");
              //This Model not enough qty.\nDo you wan checking?
              //"Model nay kitting dang thieu"
              showAlertDialog_shortage (context);

            }
            else if(count_dt_temp == _obj_dt_kittingtran.length && _check_shortage == false)
            {
              print("khong phai hang thieu => so luong 2 bang = nhau");
              //chu y truong hop N time
              //truong hop OK
              _callapi_trantemp.fetchsumqty(Model, Line, Deliverydate, TypeKitting, Time, Plant).then((value3) {
                if(value3.isEmpty)
                {
                  //nothing
                }
                else
                {
                  print('so luong qty:');
                  print(value3[0].Quantity.toString());
                  txtQuantity.text = value3[0].Quantity.toString();
                  codeboxid.requestFocus();
                  //hideinputtextfield();
                  //txtCode.Enabled = false;

                  //txtcodeEnabled = false;

                }

              });
            }
            else
            {
              //This Model not enough qty.\nDo you wan checking?
              //chu y truong hop N time
              print("so luong 2 bang khong = nhau  ==> This Model not enough qty.Do you wan checking?");
              showAlertDialog_shortage(context);

            }


          }

        }
      });
    }
    else if(type_check == "1")
    {
      //1time
      _callapi_trantemp.fetchtrantemp_1Time(Barcode,type_check,name_stored).then((value2) async{
        print('======//value//====');
        if(value2.isEmpty)
        {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.red,
                  content: Text('1time, Gia tri dt_temp null!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                );
              });
        }
        else
        {
          print('so luong ban ghi tran');
          print(_obj_dt_kittingtran.length);
          print('so luong dt temp');
          count_dt_temp = value2.length;
          print (count_dt_temp);

          //int check = Check_Shortage();  // check hang thieu  //_check_shortage
          if(_obj_dt_kittingtran.length == 0)
          {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.red,
                    content: Text('Partcode khong the Checking!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                  );
                });
            _check_shortage = false;
            txtCode.text ="";
            listrid.requestFocus();
            // dataGrid1.DataSource = null;   ===> ***** set sau
          }
          else   //_obj_dt_kittingtran.length > 0
              {
            for(int k=0; k< _obj_dt_kittingtran.length; k++)
            {
              if(_obj_dt_kittingtran[k].Status == 10)
              {
                _check_shortage = true;   //int check = Check_Shortage();
                break; //thoat khoi vong lap
              }
            }

            if(count_dt_temp == _obj_dt_kittingtran.length && _check_shortage == true )  //
                {
              print("Model nay kitting dang thieu => so luong 2 bang = nhau");
              //This Model not enough qty.\nDo you wan checking?
              //"Model nay kitting dang thieu"
              showAlertDialog_shortage (context);

            }
            else if(count_dt_temp == _obj_dt_kittingtran.length && _check_shortage == false)
            {
              print("khong phai hang thieu => so luong 2 bang = nhau");
              //chu y truong hop N time
              //truong hop OK
              _callapi_trantemp.fetchsumqty(Model, Line, Deliverydate, TypeKitting, Time, Plant).then((value3) {
                if(value3.isEmpty)
                {
                  //nothing
                }
                else
                {
                  print('so luong qty:');
                  print(value3[0].Quantity.toString());
                  txtQuantity.text = value3[0].Quantity.toString();
                  codeboxid.requestFocus();
                  //txtCode.Enabled = false;

                  //txtcodeEnabled = false;

                }

              });
            }
            else
            {
              //This Model not enough qty.\nDo you wan checking?
              //chu y truong hop N time
              print("so luong 2 bang khong = nhau  ==> This Model not enough qty.Do you wan checking?");
              showAlertDialog_shortage(context);

            }


          }

        }
      });
    }
    else if(type_check == "2")
    {
      //prepare ntime
      _callapi_trantemp.fetchtrantemp_PreTime(Barcode,type_check,name_stored).then((value2) async{
        print('======//value//====');
        if(value2.isEmpty)
        {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.red,
                  content: Text('prepare ntime, Gia tri dt_temp null!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                );
              });
        }
        else
        {
          print('so luong ban ghi tran');
          print(_obj_dt_kittingtran.length);
          print('so luong dt temp');
          count_dt_temp = value2.length;
          print (count_dt_temp);

          //int check = Check_Shortage();  // check hang thieu  //_check_shortage
          if(_obj_dt_kittingtran.length == 0)
          {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.red,
                    content: Text('Partcode khong the Checking!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                  );
                });
            _check_shortage = false;
            txtCode.text ="";
            listrid.requestFocus();
            // dataGrid1.DataSource = null;   ===> ***** set sau
          }
          else   //_obj_dt_kittingtran.length > 0
              {
            for(int k=0; k< _obj_dt_kittingtran.length; k++)
            {
              if(_obj_dt_kittingtran[k].Status == 10)
              {
                _check_shortage = true;   //int check = Check_Shortage();
                break; //thoat khoi vong lap
              }
            }

            if(count_dt_temp == _obj_dt_kittingtran.length && _check_shortage == true )  //
                {
              print("Model nay kitting dang thieu => so luong 2 bang = nhau");
              //This Model not enough qty.\nDo you wan checking?
              //"Model nay kitting dang thieu"
              showAlertDialog_shortage (context);

            }
            else if(count_dt_temp == _obj_dt_kittingtran.length && _check_shortage == false)
            {
              print("khong phai hang thieu => so luong 2 bang = nhau");
              //chu y truong hop N time
              //truong hop OK
              _callapi_trantemp.fetchsumqty(Model, Line, Deliverydate, TypeKitting, Time, Plant).then((value3) {
                if(value3.isEmpty)
                {
                  //nothing
                }
                else
                {
                  print('so luong qty:');
                  print(value3[0].Quantity.toString());
                  txtQuantity.text = value3[0].Quantity.toString();
                  codeboxid.requestFocus();
                  //txtCode.Enabled = false;

                  //txtcodeEnabled = false;

                }

              });
            }
            else
            {
              //This Model not enough qty.\nDo you wan checking?
              //chu y truong hop N time
              print("so luong 2 bang khong = nhau  ==> This Model not enough qty.Do you wan checking?");
              showAlertDialog_shortage(context);

            }


          }

        }
      });
    }
    else if(type_check == "8")
    {
      //GopModel
      _callapi_trantemp.fetchtrantemp_XHGopModel(Barcode,type_check,name_stored).then((value2) async{
        print('======//value//====');
        if(value2.isEmpty)
        {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.red,
                  content: Text('GopModel, Gia tri dt_temp null!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                );
              });
        }
        else
        {
          print('so luong ban ghi tran');
          print(_obj_dt_kittingtran.length);
          print('so luong dt temp');
          count_dt_temp = value2.length;
          print (count_dt_temp);

          //int check = Check_Shortage();  // check hang thieu  //_check_shortage
          if(_obj_dt_kittingtran.length == 0)
          {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.red,
                    content: Text('Partcode khong the Checking!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                  );
                });
            _check_shortage = false;
            txtCode.text ="";
            listrid.requestFocus();
            // dataGrid1.DataSource = null;   ===> ***** set sau
          }
          else   //_obj_dt_kittingtran.length > 0
              {
            for(int k=0; k< _obj_dt_kittingtran.length; k++)
            {
              if(_obj_dt_kittingtran[k].Status == 10)
              {
                _check_shortage = true;   //int check = Check_Shortage();
                break; //thoat khoi vong lap
              }
            }

            if(count_dt_temp == _obj_dt_kittingtran.length && _check_shortage == true )  //
                {
              print("Model nay kitting dang thieu => so luong 2 bang = nhau");
              //This Model not enough qty.\nDo you wan checking?
              //"Model nay kitting dang thieu"
              showAlertDialog_shortage (context);

            }
            else if(count_dt_temp == _obj_dt_kittingtran.length && _check_shortage == false)
            {
              print("khong phai hang thieu => so luong 2 bang = nhau");
              //chu y truong hop N time
              //truong hop OK
              _callapi_trantemp.fetchsumqty(Model, Line, Deliverydate, TypeKitting, Time, Plant).then((value3) {
                if(value3.isEmpty)
                {
                  //nothing
                }
                else
                {
                  print('so luong qty:');
                  print(value3[0].Quantity.toString());
                  txtQuantity.text = value3[0].Quantity.toString();
                  codeboxid.requestFocus();
                  //txtCode.Enabled = false;

                  //txtcodeEnabled = false;

                }

              });
            }
            else
            {
              //This Model not enough qty.\nDo you wan checking?
              //chu y truong hop N time
              print("so luong 2 bang khong = nhau  ==> This Model not enough qty.Do you wan checking?");
              showAlertDialog_shortage(context);

            }


          }

        }
      });
    }
    else
    {
      //default:  Supply_Preparetion_Delivery Typekitting=3
      _callapi_trantemp.fetchtrantemp_Preparetion(Barcode,type_check,name_stored).then((value2) async{
        print('======//value//====');
        if(value2.isEmpty)
        {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.red,
                  content: Text('default, Gia tri dt_temp null!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                );
              });
        }
        else
        {
          print('so luong ban ghi tran');
          print(_obj_dt_kittingtran.length);
          print('so luong dt temp');
          count_dt_temp = value2.length;
          print (count_dt_temp);

          //int check = Check_Shortage();  // check hang thieu  //_check_shortage
          if(_obj_dt_kittingtran.length == 0)
          {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.red,
                    content: Text('Partcode khong the Checking!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                  );
                });
            _check_shortage = false;
            txtCode.text ="";
            listrid.requestFocus();
            // dataGrid1.DataSource = null;   ===> ***** set sau
          }
          else   //_obj_dt_kittingtran.length > 0
              {
            for(int k=0; k< _obj_dt_kittingtran.length; k++)
            {
              if(_obj_dt_kittingtran[k].Status == 10)
              {
                _check_shortage = true;   //int check = Check_Shortage();
                break; //thoat khoi vong lap
              }
            }

            if(count_dt_temp == _obj_dt_kittingtran.length && _check_shortage == true )  //
                {
              print("Model nay kitting dang thieu => so luong 2 bang = nhau");
              //This Model not enough qty.\nDo you wan checking?
              //"Model nay kitting dang thieu"
              showAlertDialog_shortage (context);

            }
            else if(count_dt_temp == _obj_dt_kittingtran.length && _check_shortage == false)
            {
              print("khong phai hang thieu => so luong 2 bang = nhau");
              //chu y truong hop N time
              //truong hop OK
              _callapi_trantemp.fetchsumqty(Model, Line, Deliverydate, TypeKitting, Time, Plant).then((value3) {
                if(value3.isEmpty)
                {
                  //nothing
                }
                else
                {
                  print('so luong qty:');
                  print(value3[0].Quantity.toString());
                  txtQuantity.text = value3[0].Quantity.toString();
                  codeboxid.requestFocus();
                  //txtCode.Enabled = false;

                  //txtcodeEnabled = false;

                }

              });
            }
            else
            {
              //This Model not enough qty.\nDo you wan checking?
              //chu y truong hop N time
              print("so luong 2 bang khong = nhau  ==> This Model not enough qty.Do you wan checking?");
              showAlertDialog_shortage(context);

            }


          }

        }
      });
    }
  }

  void showOKDialog(BuildContext context, String errorMessage, String type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(type),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void thongbao_thanhcong(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.green,
            content: Text('Checking success!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),  //MessageBox.Show("Partcard da duoc scan");
          );
        });
  }

  void update_checking(BuildContext context) {
    String DeliveriDate = Deliverydate.toString();
    String Reservation_Code = txtCode.text.toString();
    String Update_user = datauser;
    print('===update check ing ===');
    print(DeliveriDate);
    print (Reservation_Code);
    print(Update_user);

    Openpeding();
    _callapi_trantemp.UpdateChecking(TypeKitting, DeliveriDate, Model, Line, Time, Category, Category_JT, Reservation_Code, Update_user).then((value4) {
      if(value4 ==  true)
      {
        Closepending();
        thongbao_thanhcong(context);
        //showOKDialog(context, "Checking success!", "Thông báo");
        reset();
      }
      else
      {
        // Code cu khong quan tam gia tri tra ve, ket qua deu thanh cong het //*************** loi truong hop loi se check lai
        Closepending();
        thongbao_thanhcong(context);
        //showOKDialog(context, "Checking success!", "Thông báo");
        reset();
      }
    });
  }

  void reset() {
    //hideinputtextfield();
    setState(() {
      //txtcodeEnabled = true;
      txtCode.text="";
      listrid.requestFocus();
      //FocusScope.of(context).requestFocus(listrid);

      txtTrays.text="";
      txtQuantity.text="";
      //dataGrid1.DataSource = null;
      _obj_dt_kittingtran = [];
      //dt_notYetKitting = null;
      _obj_dt_notYetKitting = [];
      _check_shortage = false;
      _typecheck = "-1";
      //ckbListNotYetKitting.Checked = false;
      ckbListNotYetKitting = false;
      blnScan = false;     //=

      // cac bien su kien code box scan
      _checkpartcard_Supply = false;   // bien check partcard duoc ban kiting buoc 1 chua?
      _checkingpartcard_had_scan = false;  //bien check xem duoc checking o buoc 2 chua?
      _check_Supply_Full = true;

      display = '0';
      thongbao = '';
      _index = 0;
      _count = 0;

      _obj_dt_showall = [];
    });
  }

  showAlertDialog_exit(BuildContext context) {
    // truong hop checking hang thieu
    Widget continueButton = TextButton(
      child: Text("YES"),
      onPressed: () {
        for( int i=0; i < _obj_dt_kittingtran.length; i++)
        {
          String BarcodePartcard = _obj_dt_kittingtran[i].BarcodePartcard;
          String Update_user = datauser;
          String Reservation_Code = txtCode.text.toString();
          String SttCheck = _obj_dt_kittingtran[i].SttCheck;
          _callapi_trantemp.UpdateTranTempExit(Reservation_Code, BarcodePartcard, Update_user, SttCheck).then((value6) {
            //true hay false ==> update xong deu quay lai   ****
          });
        }
        //bo doan code update ==> SttCheck=1 ==> xu ly o stored : tblKitting_Trans_PartCard_Temp_Update_Optimal_Mobine
        // ==> khong bo duoc lien quan toi update checking theo user
        //Navigator.of(context, rootNavigator: true).pop(true); // dismisses only the dialog and returns true
        Navigator.push(context, new MaterialPageRoute(builder: (context) => new MenuKittingFA(UserID: datauser)));
        Navigator.of(context, rootNavigator: true).pop(true);
      },
    );
    Widget cancelButton = TextButton(
      child: Text("NO"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true)
            .pop(false); // dismisses only the dialog and returns false
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Thong bao"),
      content: Text("Ban muon thoat checking?"),
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

  showAlertDialog_shortage(BuildContext context) {
    // truong hop checking hang thieu
    Widget continueButton = TextButton(
      child: Text("YES"),
      onPressed: () {
        _check_shortage = true;
        //set_value_listview();   ==> show bang kitting tran temp
        _callapi_trantemp.fetchsumqty(Model, Line, Deliverydate, TypeKitting, Time, Plant).then((value3) {
          if(value3.isEmpty)
          {
            //nothing
          }
          else
          {
            print('so luong qty:');
            print(value3[0].Quantity.toString());
            txtQuantity.text = value3[0].Quantity.toString();
            codeboxid.requestFocus();
            //hideinputtextfield();
            //txtCode.Enabled = false;
            //txtcodeEnabled = false;
          }

        });

        //update_kitting(context);

        Navigator.of(context, rootNavigator: true).pop(true); // dismisses only the dialog and returns true
      },
    );
    Widget cancelButton = TextButton(
      child: Text("NO"),
      onPressed: () {
        //Navigator.of(context).pop();
        txtCode.text="";
        listrid.requestFocus();
        //hideinputtextfield();
        Navigator.of(context, rootNavigator: true)
            .pop(false); // dismisses only the dialog and returns false
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Thong bao"),
      content: Text("Model nay khong du so luong.\nBan van muon tiep tuc?"),
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

  showAlertDialog_update_shortage(BuildContext context) {
    // truong hop checking hang thieu
    Widget continueButton = TextButton(
      child: Text("YES"),
      onPressed: () {
        //update_checking(context);
        //Openpeding();
        Navigator.of(context, rootNavigator: true).pop(true);
        update_checking(context);
        //Closepending();
        // dismisses only the dialog and returns true
      },
    );
    Widget cancelButton = TextButton(
      child: Text("NO"),
      onPressed: () {
        //Navigator.of(context).pop();
        //txtcodeEnabled = true;
        txtCode.text="";
        listrid.requestFocus();
        //listView1.Clear();
        //Design_table();
        _obj_dt_kittingtran = [];
        txtQuantity.text = "";
        _check_shortage = false;

        //hideinputtextfield();

        Navigator.of(context, rootNavigator: true)
            .pop(false); // dismisses only the dialog and returns false
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Thong bao"),
      content: Text("Model nay khong du so luong.\nBan van muon tiep tuc?"),
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


  List<Widget> _getTitleWidget() {
    if(statussort){
      return [
        _getTitleItemWidgetdesc('Partcode',150),
        _getTitleItemWidget('Qty',50),
        _getTitleItemWidget('Time',50),
        _getTitleItemWidget('Model',100),
        _getTitleItemWidget('Line',50),
        _getTitleItemWidget('Status',50),
        _getTitleItemWidget('Issue_Sloc',100),
        _getTitleItemWidget('Deliverydate',100),
        _getTitleItemWidget('BarcodeCarton',200),
        _getTitleItemWidget('BarcodePartcard',200),
        _getTitleItemWidget('TypeKitting',50),
      ];
    }
    else{
      return [
        _getTitleItemWidgetasc('Partcode',150),
        _getTitleItemWidget('Qty',50),
        _getTitleItemWidget('Time',50),
        _getTitleItemWidget('Model',100),
        _getTitleItemWidget('Line',50),
        _getTitleItemWidget('Status',50),
        _getTitleItemWidget('Issue_Sloc',100),
        _getTitleItemWidget('Deliverydate',100),
        _getTitleItemWidget('BarcodeCarton',200),
        _getTitleItemWidget('BarcodePartcard',200),
        _getTitleItemWidget('TypeKitting',50),
      ];
    }
  }
//_obj_dt_kittingtran
  Widget _getTitleItemWidgetasc(String label, double width) {
    return Container(
      color: Colors.orange[100],
      width: width,
      height: 40,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Center(
        child: TextButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(MdiIcons.sortAscending,color: Colors.black),
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black)),
            ],
          ),
          onPressed: (){
            sortAscending();
          },
        ),
      ),
    );
  }
  Widget _getTitleItemWidgetdesc(String label, double width) {
    return Container(
      color: Colors.orange[100],
      width: width,
      height: 40,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Center(
        child: TextButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(MdiIcons.sortDescending,color: Colors.black),
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black)),
            ],
          ),
          onPressed: (){
            sortDesc();
          },
        ),
      ),
    );
  }
  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      color: Colors.orange[100],
      width: width,
      height: 40,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Center(child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15))),
    );
  }
  Widget _generateFirstColumnRow(BuildContext context, int index) {
    if(_obj_dt_kittingtran[index].SttCheck.toString() == '1')
    {
      return Container(
        color: Colors.green,
        width: 150,
        height: 30,
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        alignment: Alignment.centerLeft,
        child: Center(child: Text(_obj_dt_kittingtran[index].Partcode)),
      );
    }
    else
    {
      return Container(

        width: 150,
        height: 30,
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        alignment: Alignment.centerLeft,
        child: Center(child: Text(_obj_dt_kittingtran[index].Partcode)),
      );
    }

  }
  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    if(_obj_dt_kittingtran[index].SttCheck.toString() == '1')
    {
      return Row(
        //
        children: <Widget>[
          Container(
            color: Colors.green,
            width: 50,
            height: 30,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Center(child: Text(_obj_dt_kittingtran[index].Quantity)),
          ),
          Container(
            color: Colors.green,
            width: 50,
            height: 30,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Center(child:  Text(_obj_dt_kittingtran[index].Time)),

          ),
          Container(
            color: Colors.green,
            width: 100,
            height: 30,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Center(child: Text(_obj_dt_kittingtran[index].Model)),
          ),
          Container(
            color: Colors.green,
            width: 50,
            height: 30,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Center(child: Text(_obj_dt_kittingtran[index].Line)),
          ),
          Container(
            color: Colors.green,
            width: 50,
            height: 30,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Center(child: Text(_obj_dt_kittingtran[index].Status)),
          ),
          Container(
            color: Colors.green,
            width: 100,
            height: 30,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Center(child: Text(_obj_dt_kittingtran[index].Issue_Sloc)),
          ),
          Container(
            color: Colors.green,
            width: 100,
            height: 30,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Center(child: Text(_obj_dt_kittingtran[index].DeliveryDate)),
          ),
          Container(
            color: Colors.green,
            width: 200,
            height: 30,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Center(child: Text(_obj_dt_kittingtran[index].BarcodeCarton)),
          ),
          Container(
            color: Colors.green,
            width: 200,
            height: 30,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Center(child: Text(_obj_dt_kittingtran[index].BarcodePartcard)),
          ),
          Container(
            color: Colors.green,
            width: 50,
            height: 30,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Center(child: Text(_obj_dt_kittingtran[index].TypeKitting)),
          ),
        ],
      );
    }
    else
    {
      return Row(
        //
        children: <Widget>[
          Container(
            width: 50,
            height: 30,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Center(child: Text(_obj_dt_kittingtran[index].Quantity)),
          ),
          Container(
            width: 50,
            height: 30,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Center(child:  Text(_obj_dt_kittingtran[index].Time)),

          ),
          Container(
            width: 100,
            height: 30,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Center(child: Text(_obj_dt_kittingtran[index].Model)),
          ),
          Container(
            width: 50,
            height: 30,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Center(child: Text(_obj_dt_kittingtran[index].Line)),
          ),
          Container(
            width: 50,
            height: 30,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Center(child: Text(_obj_dt_kittingtran[index].Status)),
          ),
          Container(
            width: 100,
            height: 30,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Center(child: Text(_obj_dt_kittingtran[index].Issue_Sloc)),
          ),
          Container(
            width: 100,
            height: 30,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Center(child: Text(_obj_dt_kittingtran[index].DeliveryDate)),
          ),
          Container(
            width: 200,
            height: 30,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Center(child: Text(_obj_dt_kittingtran[index].BarcodeCarton)),
          ),
          Container(
            width: 200,
            height: 30,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Center(child: Text(_obj_dt_kittingtran[index].BarcodePartcard)),
          ),
          Container(
            width: 50,
            height: 30,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Center(child: Text(_obj_dt_kittingtran[index].TypeKitting)),
          ),
        ],
      );
    }

  }
  void sortAscending(){
    _obj_dt_kittingtran.sort((a, b) => int.parse(a.SttCheck).compareTo(int.parse(b.SttCheck)));
    statussort = true;
    setState(() {
    });
  }
  void sortDesc(){
    _obj_dt_kittingtran.sort((a, b) => int.parse(b.SttCheck).compareTo(int.parse(a.SttCheck)));
    statussort = false;
    setState(() {
    });
  }

}




