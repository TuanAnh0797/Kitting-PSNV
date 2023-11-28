import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../../../Controller/Kitting/KittingDIP/api_supplyDIP.dart';
import '../../../Model/Kitting/KittingDIP/Class_supplyDIP.dart';
import 'MenuKittingDIP.dart';

//libary focus
import 'package:flutter_datawedge/models/scan_result.dart';
import 'package:flutter_datawedge/flutter_datawedge.dart';
import 'dart:io';

/*void main()
{
  runApp(new SuplyFA());
}*/

class SuplyDIP extends StatelessWidget {

  const SuplyDIP({Key? key, required this.UserID}) : super(key: key);
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
  String Partcode, Status,Quantity,Model,Line,Time,Issue_Sloc,DeliveryDate,BarcodeCarton,BarcodePartcard,TypeKitting;
  dt_kittingTran(this.Partcode, this.Status, this.Quantity,this.Model,this.Line, this.Time, this.Issue_Sloc, this.DeliveryDate, this.BarcodeCarton,this.BarcodePartcard,this.TypeKitting);
}


class ExampleWidget extends StatefulWidget {
  ExampleWidget({Key? key, required this.datauser}) : super(key: key);
  final String datauser;
  @override
  _ExampleWidgetState createState() => new _ExampleWidgetState(datauser:datauser);
}

class _ExampleWidgetState extends State<ExampleWidget>
{
  _ExampleWidgetState({required this.datauser});
  final String datauser;

  //bien focus
  late StreamSubscription<ScanResult> onScanResultListener;
  late FlutterDataWedge fdw;

  //Store the color as a part of your `State`
  //Color color = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  Color color = Colors.white;

  SupplyKittingDIP _call_API_supply = new SupplyKittingDIP();
  List<Get_KittingTran_Issue_line_Partcard> _obj_dt_kittingtran = List.empty();

  var txtList = new TextEditingController();
  var txtLine = new TextEditingController();
  var txtConfirm_user = new TextEditingController();

  var focusNode = FocusNode();  //gia tri focus
  final FocusNode listid = FocusNode();
  late FocusNode lineid = FocusNode();
  late FocusNode userid = FocusNode();

  bool txtListEnabled = true;
  bool txtLineEnabled = true;
  bool txtConfirm_userEnabled = true;


  String lblModel = '';
  String lblLine = '';
  String lblQty = '';
  String lblDate = '';
  String lblTime = '';
  String lblPlant = '';
  String lblResult = '';

  String TypeKitting='';
  String DeliveriDate='';
  String Model='';
  String Line='';
  String Time='';
  String Plant='';
  String _Line_List ='';
  String _Line = "";
  bool Check_compare = false;

  String _Category = '';
  String _UploadNo = '';
  String _Qty = '';
  String _Plant='';
  String _Name_Common='';


  String _typecheck = '';

  int count_dt_temp = 0;        //so luong ban ghi dt_temp
  bool _check_shortage = false;
  bool check_Issue_line = false;

  @override
  // Method that call only once to initiate the default app.
  void initState() {
    //SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
    initScanner();
  }

  void initScanner() {
    if (Platform.isAndroid) {
      fdw = FlutterDataWedge(profileName: 'FlutterDataWedge');
      onScanResultListener = fdw.onScanResult
          .listen((result) => setState(() {
        if(listid.hasFocus)
        {
          //print('abc');
          txtList.text = result.data;
          Listid_function(result.data, context);
        }else if(lineid.hasFocus)
        {
          txtLine.text = result.data;
          Lineid_function(result.data, context);
        }
        else if(userid.hasFocus)
        {
          txtConfirm_user.text = result.data;
          Userid_function(result.data, context);
        }

      } ));
    }
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    listid.dispose();
    lineid.dispose();
    userid.dispose();
    super.dispose();
    onScanResultListener.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
    return Scaffold(
      appBar: AppBar(
        title: Text("Suply kitting DIP",)
        ,),
      body:SingleChildScrollView(
        /*scrollDirection: Axis.horizontal,*/
          scrollDirection: Axis.vertical,
          child:Container(
            color: color,  //set color back ground
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextField(
                    autofocus: true,
                    controller: txtList,
                    focusNode: listid,
                    showCursor: true,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'List',
                      hintText: '',
                    ),
                    onSubmitted: (value)
                    {
                      //Listid_function(value, context);
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextField(
                    controller: txtLine,
                    focusNode: lineid,
                    readOnly: true,
                    showCursor: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Line',
                      hintText: '',
                    ),
                    onSubmitted: (value)
                    {
                      //Lineid_function(value, context);
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextField(
                    //autofocus: true,
                    controller: txtConfirm_user,
                    focusNode: userid,
                    readOnly: true,
                    showCursor: true,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'PIC',
                      hintText: '',
                    ),
                    onSubmitted: (value)
                    {
                      //Userid_function(value, context);
                    },
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  child: Row(
                    children: [
                      Padding(
                        //padding: EdgeInsets.all(10), //apply padding to all four sides
                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                        child: Text("Model :",style: TextStyle(),),
                      ),
                      SizedBox(
                          width: 260.0,
                          height: 50.0,
                          child: lblModel == ''? Card(child: Text('',style: TextStyle(fontSize: 23,color: Colors.blue, fontWeight: FontWeight.bold),)):
                          Card(child: Text('${lblModel}',style: TextStyle(fontSize: 23,color: Colors.blue, fontWeight: FontWeight.bold),))
                      ),
                    ],
                  ),

                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  child: Row(
                    children: [
                      Padding(
                        //padding: EdgeInsets.all(10), //apply padding to all four sides
                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                        child: Text("Line :",style: TextStyle(),),
                      ),
                      SizedBox(
                          width: 120.0,
                          height: 50.0,
                          child: lblLine == ''? Card(child: Text('',style: TextStyle(fontSize: 25,color: Colors.blue, fontWeight: FontWeight.bold),)):
                          Card(child: Text('${lblLine}',style: TextStyle(fontSize: 25,color: Colors.blue, fontWeight: FontWeight.bold),))
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: Text("Qty:",style: TextStyle(),),
                      ),
                      SizedBox(
                          width: 110.0,
                          height: 50.0,
                          child: lblQty == ''? Card(child: Text('0',style: TextStyle(fontSize: 25,color: Colors.blue, fontWeight: FontWeight.bold),)):
                          Card(child: Text('${lblQty}',style: TextStyle(fontSize: 25,color: Colors.blue, fontWeight: FontWeight.bold),))
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  child: Row(
                    children: [
                      Padding(
                        //padding: EdgeInsets.all(10), //apply padding to all four sides
                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                        child: Text("Date :",style: TextStyle(),),
                      ),
                      SizedBox(
                          width: 120.0,
                          height: 50.0,
                          child: lblDate == ''? Card(child: Text('',style: TextStyle(fontSize: 14,color: Colors.blue, fontWeight: FontWeight.bold),)):
                          Card(child: Text('${lblDate}',style: TextStyle(fontSize: 14,color: Colors.blue, fontWeight: FontWeight.bold),))
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: Text("Time:",style: TextStyle(),),
                      ),
                      SizedBox(
                          width: 100.0,
                          height: 50.0,
                          child: lblTime == ''? Card(child: Text('00:00',style: TextStyle(fontSize: 25,color: Colors.blue, fontWeight: FontWeight.bold),)):
                          Card(child: Text('${lblTime}',style: TextStyle(fontSize: 25,color: Colors.blue, fontWeight: FontWeight.bold),))
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  child: Row(
                    children: [
                      Padding(
                        //padding: EdgeInsets.all(10), //apply padding to all four sides
                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                        child: Text("plan :",style: TextStyle(),),
                      ),
                      SizedBox(
                          width: 120.0,
                          height: 50.0,
                          child: lblPlant == ''? Card(child: Text('',style: TextStyle(fontSize: 25,color: Colors.blue, fontWeight: FontWeight.bold),)):
                          Card(child: Text('${lblPlant}',style: TextStyle(fontSize: 25,color: Colors.blue, fontWeight: FontWeight.bold),))
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: Text("Result",style: TextStyle(),),
                      ),
                      SizedBox(
                          width: 100.0,
                          height: 50.0,
                          child: lblResult == ''? Card(child: Text('',style: TextStyle(fontSize: 40,color: Colors.black, fontWeight: FontWeight.bold),)):
                          Card(child: Text('${lblTime}',style: TextStyle(fontSize: 40,color: Colors.blue, fontWeight: FontWeight.bold),))
                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3.0, horizontal: 50.0),
                      child: ElevatedButton(
                        child: Text('Home'),
                        onPressed: () {
                          // back home
                          Navigator.push(context, new MaterialPageRoute(builder: (context) => new MenuKittingDIP(UserID: datauser)));
                        },
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3.0, horizontal: 50.0),
                      child: ElevatedButton(
                        child: Text('Clear'),
                        onPressed: () {
                          reset();
                        },
                      ),
                    ),
                  ],
                ),

              ],
            ),
          )

      ),

    );
  }

  void Userid_function(String value, BuildContext context) {
    try
    {
      if(value != '')
      {
        var chuoi = txtConfirm_user.text.toString();
        var _psnv = chuoi.substring(0,4);
        print('user psnv:${_psnv}');
        if(_psnv == "PSNV")
        {
          if(Check_compare = true)
          {
            //update supply
            //tblKitting_Trans_Partcard_Temp_Update_2
            String Reservation_Code = txtList.text.toString();
            String Update_user = datauser;
            String Confirm_user = chuoi.substring(4,11);
            print(Reservation_Code);
            print(Update_user);
            print(Confirm_user);

            // Thay doi stored cu xem co van de gi khong? tblKitting_Trans_Partcard_Temp_Update_2 ==> tblKitting_Trans_Partcard_Temp_Update_Main_Mobile
            //hang dip chi chay 1 stored
            Openpeding();
            _call_API_supply.tblKitting_Trans_Partcard_Temp_DIP_Update_2(Reservation_Code, Update_user, Confirm_user).then((value5) {
              if(value5 == true)
              {
                //print(value5);
                //print('OK');
                Closepending();
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.green,
                        content: Text('Supply Thanh cong !',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                      );
                    });
                reset();
              }
              else
              {
                //print('NG');
                Closepending();
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.red,
                        content: Text('NG!!!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                      );
                    });
                setState(() {
                  lblResult="NG";
                });
                txtConfirm_user.text="";
                userid.requestFocus();
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
                    content: Text('NG, Sai ten Line !',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                  );
                });
            //background
            setState(() {
              color = Colors.red; //set background
              lblResult = 'NG';
            });

            txtLine.text="";
            lineid.requestFocus();
            //lblResult = 'NG';
          }
        }
        else
        {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.red,
                  content: Text('NG, Code ID sai dinh dang !',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                );
              });
          txtConfirm_user.text="";
          userid.requestFocus();
        }

      }
      else
      {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.red,
                content: Text('NG, Ban chua scan ma PIC !',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
              );
            });
        userid.requestFocus();
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

  void Lineid_function(String value, BuildContext context) {
    try
    {
      if(value != '')
      {
        var chuoi = txtLine.text.toString();
        List<String>? itemList;
        itemList = chuoi.split("-");
        print('Line');
        print(itemList[1].toString());
        if(itemList[0].toString() != "LINE")
        {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.red,
                  content: Text('NG, Barcode line sai dinh dang !',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                );
              });
          txtLine.text = "";
          lineid.requestFocus();
        }
        else
        {
          _Line = itemList[1].toString();
          //compare = Check_compare();
          if(_Line != "" && _Line_List != "")
          {
            if(_Line_List == _Line)
            {

              setState(() {
                Check_compare = true;
                //txtListEnabled = false;
                //txtLineEnabled = false;
                //txtConfirm_userEnabled = true;
                txtConfirm_user.text="";
              });
              txtLine.text= _Line;
              userid.requestFocus();
            }
            else
            {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.red,
                      content: Text('NG, Khong dung ten Line !',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                    );
                  });
              txtLine.text = "";
              lineid.requestFocus();
            }
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
                content: Text('NG, Ban phai san Line !',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
              );
            });
        txtLine.text = "";
        lineid.requestFocus();
      }
    }
    catch(e)
    {
      thongbaoNG(context, e.toString());
    }

  }

  void Listid_function(String value, BuildContext context) {
    try
    {
      if(value != '')
      {
        //VL-SE35XLA-V4; 3M;07/18/2023;06:00;1;VR01;DP;DP;R  ==> hang FA
        //dip
        //1AP1LPMWE310H1YA;H0A327200200;DIP 04;600;DIP-5A6-3C;1170;08/14/2023;VR01;06:00;1220;0;DIP-DP;DIP-DP;RDIP
        var chuoi = txtList.text.toString();
        List<String>? itemList;
        itemList = chuoi.split(";");
        print(itemList.length);

        TypeKitting= "4";//itemList[4].toString();
        DeliveriDate=itemList[6].toString();
        Model=itemList[0].toString();
        Line=itemList[2].toString();
        Time=itemList[8].toString();
        Plant = itemList[7].toString();
        _Category = itemList[12].toString();
        _UploadNo = itemList[10].toString();
        _Qty = itemList[3].toString();
        _Plant = itemList[7].toString();
        _Name_Common = itemList[12].toString();
        _typecheck = "4";

        _Line_List = itemList[2].toString();

        if (itemList != null  && itemList.length == 14 )
        {

          /*var chuoi = txtConfirm_user.text.toString();
        var _psnv = chuoi.substring(0,4);*/
          var output = chuoi.substring(chuoi.length-4,chuoi.length);
          //var output = chuoi[chuoi.length - 4];
          print(output);
          if(output == 'RDIP')
          {
            //pending suply
            //Check_Issue_List_Partcard
            //Check_Issue_List_Partcard
            String Reservation_Code = txtList.text.toString();
            //==> check xem list co gia tri status =1 da duoc checking trong bang Tran temp chua?
            _call_API_supply.Check_Issue_List_Partcard(Reservation_Code).then((value) async {
              if(value == '0')
              {
                //print(value);
                print('==>co gia tri status =1 da duoc checking.');
                //check_Issue_line_DIP()
                //dt_kittingTran

                String UploadNo =_UploadNo;
                String Category =_Category;
                String Name_Common=_Name_Common;
                print(TypeKitting);
                print(DeliveriDate);
                print(Model);
                print(Plant);
                print(Category);
                print(Name_Common);
                print(Time);
                print(UploadNo);

                //TypeKitting, DeliveriDate, Model, Plant, Category, Name_Common, Time, UploadNo

                //_obj_dt_temp = (await _call_api_chekingdip.get_dt_dt_temp(ProductDate, Plant, Category, Time, UploadNo,Model))!;
                Openpeding();
                _obj_dt_kittingtran =  (await _call_API_supply.fetch_dt_kittingTran_dip(TypeKitting, DeliveriDate, Model, Plant, Category,Name_Common,Time,UploadNo))!;
                if(_obj_dt_kittingtran.length > 0)
                {
                  print('ok dt_kittingTran > 0');
                  String Barcode = txtList.text.toString();
                  print('type check');
                  print(_typecheck);
                  print('kitting other');
                  String ProductDate = DeliveriDate;
                  //String Category = _Category;
                  //String UploadNo = _UploadNo;

                  _call_API_supply.fetchtrantemp_dip(ProductDate, Plant, Category, Time, UploadNo,Model).then((value3) {
                    if(value3!.isEmpty)
                    {
                      Closepending();
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.red,
                              content: Text('call API null data!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                            );
                          });
                      /*txtList.text="";
                              listid.requestFocus();*/
                    }
                    else
                    {
                      print('so luong ban ghi tran');
                      print(_obj_dt_kittingtran.length);
                      print('so luong dt temp');
                      count_dt_temp = value3.length;
                      print (count_dt_temp);
                      //bool _check_shortage = false;
                      //kiem tra xem co phai truong hop kitting hang thieu khong?
                      for(int k=0; k< _obj_dt_kittingtran.length; k++)
                      {
                        if(_obj_dt_kittingtran[k].Status == 10)
                        {
                          _check_shortage = true;   //int check = Check_Shortage();
                          break; //thoat khoi vong lap
                        }
                      }
                      if(count_dt_temp == _obj_dt_kittingtran.length && _check_shortage == true )
                      {
                        print("Model nay kitting dang thieu => so luong 2 bang = nhau");
                        //This Model not enough qty.\nDo you wan checking?
                        //"Model nay kitting dang thieu"
                        check_Issue_line = false;
                      }
                      else if(count_dt_temp == _obj_dt_kittingtran.length && _check_shortage == false)
                      {
                        check_Issue_line = true;
                      }
                      else
                      {
                        check_Issue_line = false;
                      }
                      if(check_Issue_line = false)
                      {
                        Closepending();
                        //supply hang thieu
                        print('kitting thieu');
                        showAlertDialog_shortage(context);
                        //truong hop supply hang dip
                        //hang thieu khong duoc supply****** check ky voi user truong hop nay
                      }
                      print('so luong qty:');

                      setState(() {
                        _Line_List = Line;
                        lblDate = DeliveriDate;
                        lblLine = Line;
                        lblModel = Model;
                        lblTime = Time;
                        lblQty = _Qty;
                        lblPlant= Plant;
                        lblResult = '';
                      });

                      //txtListEnabled = false;
                      //txtLineEnabled = true;
                      //suply dip khong check line
                      /*txtLine.text = "";
                              lineid.requestFocus();*/
                      //suply dip khong check line
                      txtConfirm_user.text="";
                      userid.requestFocus();
                      //pending o day

                      Closepending();

                    }

                  });

                }
                else
                {
                  Closepending();
                  print('data dt_kittingTran null');
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.red,
                          content: Text('NG, data dt_kittingTran null!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                        );
                      });
                  txtList.text = "";
                  listid.requestFocus();
                }

                //txtLineEnabled = true;
                //lineid.requestFocus();
              }
              else
              {
                if(value != 'err_time_out')
                {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.red,
                          content: Text('NG, Khong the supply!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                        );
                      });
                  txtList.text = "";
                  listid.requestFocus();
                }
                else
                {
                  print('err_time_out');
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.red,
                          content: Text('Connect Time Out!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                        );
                      });

                  txtList.text = "";
                  listid.requestFocus();
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
            txtList.text ='';
            listid.requestFocus();
          }
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
          listid.requestFocus();
        }


      }
      else
      {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.red,
                content: Text('NG, Ban phai san List code!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
              );
            });

        listid.requestFocus();
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

  void reset() {
    setState(() {
      color = Colors.white; //set background
      //txtListEnabled = true;
      txtList.text="";
      listid.requestFocus();
      //txtLineEnabled = true;
      //txtConfirm_userEnabled = true;
      txtLine.text="";
      txtConfirm_user.text="";

      lblModel ='';
      lblLine='';
      lblQty='';
      lblDate='';
      lblTime='';
      lblPlant='';
      lblResult='';

      TypeKitting='';
      DeliveriDate='';
      Model='';
      Line='';
      Time='';
      Plant='';
      _Line_List ='';
      _Line = "";
      Check_compare = false;
      _typecheck = '';

      count_dt_temp = 0;
      _check_shortage = false;
      check_Issue_line = false;

      _obj_dt_kittingtran = [];

      _UploadNo='';
      _Plant='';
      _Qty='';
      _Plant='';
      _Name_Common='';
      _Category='';
    });

  }

  showAlertDialog_shortage(BuildContext context) {
    // truong hop checking hang thieu
    Widget continueButton = TextButton(
      child: Text("YES"),
      onPressed: () {
        _check_shortage = true;
        //lay so luong
        //String Deliverydate = DeliveriDate;

        /*if (MessageBox.Show("List hang chua du, ban co muon SUPPLY?", "Thong bao",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.No)
          return;*/
        //****khong cho supply hang thieu cua dip

        Navigator.of(context, rootNavigator: true).pop(true); // dismisses only the dialog and returns true
      },
    );
    Widget cancelButton = TextButton(
      child: Text("NO"),
      onPressed: () {
        //Navigator.of(context).pop();
        txtList.text = "";
        listid.requestFocus();
        Navigator.of(context, rootNavigator: true)
            .pop(false); // dismisses only the dialog and returns false
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Thong bao"),
      //content: Text("List hang chua du, ban co muon SUPPLY?"),
      content: Text("List hang chua du, ban khong the SUPPLY?"),
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


}