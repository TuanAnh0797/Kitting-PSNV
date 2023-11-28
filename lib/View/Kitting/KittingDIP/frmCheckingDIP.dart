import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../../../Controller/Kitting/KittingDIP/api_chekingDip.dart';
import '../../../Model/Kitting/KittingDIP/Class_checkingDip.dart';
import 'MenuKittingDIP.dart';

import 'package:flutter_datawedge/models/scan_result.dart';
import 'package:flutter_datawedge/flutter_datawedge.dart';
import 'dart:io';

/*void main()
{
  runApp(new CheckingFA());
}*/

class CheckingDIP extends StatelessWidget {

  const CheckingDIP({Key? key, required this.UserID}) : super(key: key);
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

  String display = '';
  GetChekingDIP _call_api_chekingdip = new GetChekingDIP();

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

  bool ckbListNotYetKitting = false;
  bool blnScan = false;
  bool _checkpartcard_Supply = false;
  bool _checkingpartcard_had_scan = false;
  bool _check_Supply_Full = true;

  String TypeKitting='';
  String DeliveriDate='';
  String Model='';
  String Plant='';
  String Category='';
  String Name_common='';
  String Time='';
  String UploadNo='';

  String Check_delay = "0";
  bool _check_shortage =  false;
  int count_dt_temp = 0;
  int _count = 0;
  int _index = 0;

  int _currentSortColumn =1;
  bool _isAscending = true;


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
        if(listrid.hasFocus)
        {
          //print('abc');
          txtCode.text = result.data;
          Listid_fucntion(result.data, context);
        }
        else if(codeboxid.hasFocus)
        {
          txtTrays.text = result.data;
          Codeboxid_function(result.data, context);
        }


      } ));
    }
  }

  //dt_kittingTran
  List<Get_KittingTran_Partcard_DIP> _obj_dt_kittingtran = List.empty();
  List<Get_List_KittingDIP_NotYet> _obj_dt_notYetKitting = List.empty();
  List<Report_Partcard_DIP_new> _obj_dt_temp = List.empty();

  //List<dt_notYetKitting> _obj_dt_notYetKitting = <dt_notYetKitting>[];

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    listrid.dispose();
    codeboxid.dispose();
    qtyid.dispose();
    super.dispose();
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
      appBar: AppBar(title: Text("Checking_DIP",)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: TextField(
              autofocus: true,
              controller: txtCode,
              focusNode: listrid,
              readOnly: true,
              showCursor: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'List R',
                hintText: '',
              ),
              onSubmitted: (value)
              {
                //Listid_fucntion(value, context);
              },
            ),
          ),
          /*const SizedBox(
            height: 5.0,
          ),*/
          Container(
            /* margin: EdgeInsets.all(10),*/
            /* margin: const EdgeInsets.only(top: 10.0),*/
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: txtTrays,
              focusNode: codeboxid,
              readOnly: true,
              showCursor: true,
              //keyboardType: TextInputType.none,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Code Box',
                hintText: '',
              ),
              onSubmitted: (value)
              {
                //Codeboxid_function(value, context);
              },
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120.0,
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
                        //
                      },
                    ),
                  ),
                  SizedBox(
                    width: 200.0,
                    height: 50.0,
                    child: CheckboxListTile(
                      title: const Text("List_No_Kitting",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                      value: this.ckbListNotYetKitting,
                      onChanged: (bool? value) async {
                        setState(() {
                          ckbListNotYetKitting = value!;
                        });
                        //pending notyes
                        if(ckbListNotYetKitting == true)
                        {
                          print('vao truong hop show list');
                          if(txtCode.text != '')
                          {
                            setState(() {
                              //ckbListNotYetKitting = true;
                              _obj_dt_kittingtran = [];  //reset ve null
                            });
                            String Partcode ="";
                            String DeliveryDate = DeliveriDate;
                            String TypeKit = TypeKitting;
                            String CATEGORY = Category;
                            String _Time = Time;
                            print('vao blnScan == true');
                            print(DeliveryDate);
                            print(TypeKit);
                            print(CATEGORY);
                            print(CATEGORY);
                            String ProductDate = DeliveriDate;
                            //_call_api_chekingdip.get_dt_notYetKitting(ProductDate, Plant, Category, Time, UploadNo, Model)
                            _obj_dt_notYetKitting = (await _call_api_chekingdip.get_dt_notYetKitting(ProductDate, Plant, Category, Time, UploadNo, Model))!;
                            print('ban ghi dt_not_yes');
                            print(_obj_dt_notYetKitting.length);

                            setState(() {
                              display = '1';
                            });

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
                            });
                            listrid.requestFocus();
                            print('vao blnScan == false');
                          }
                        }
                        else
                        {
                          //reset();
                          setState(() {
                            //ckbListNotYetKitting = false;
                            //_obj_dt_notYetKitting = [];  // reset ve null
                            _obj_dt_kittingtran = [];
                          });

                          //txtcodeEnabled=true;
                          txtCode.text = "";
                          listrid.requestFocus();
                        }

                      },
                    ),
                  )

                ],
              )


          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 2.0, horizontal: 20.0),
                child: ElevatedButton(
                  child: Text('Home'),
                  onPressed: () {
                    if(_check_Supply_Full == false)
                    {
                      //bo cap nhat  ==> //Update_sttchecking
                      // back home  ==> luon  **** test thu***** giam thao tac

                      //part list chua duoc scan het=> ban co muon Are you exit?
                      //showAlertDialog_exit(context);

                      Navigator.push(context, new MaterialPageRoute(builder: (context) => new MenuKittingDIP(UserID: datauser)));

                    }
                    else
                    {
                      // back home
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => new MenuKittingDIP(UserID: datauser)));
                    }
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 2.0, horizontal: 15.0),
                child: ElevatedButton(
                  child: Text('Confirm'),
                  onPressed: () {
                    if(txtCode.text == "")
                    {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.red,
                              content: Text('Ban chua nhap du du lieu!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),  //MessageBox.Show("Partcard da duoc scan");
                            );
                          });
                      listrid.requestFocus();
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
                                backgroundColor: Colors.red,
                                content: Text('ban chua scan code box id!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),  //MessageBox.Show("Partcard da duoc scan");
                              );
                            });
                        codeboxid.requestFocus();
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
    );
  }

  void Codeboxid_function(String value, BuildContext context) {
    try
    {
      if(value != '')
      {
        var barcode_tray = txtTrays.text.toString();
        List<String>? itemList2;
        itemList2 = barcode_tray.split(";");
        print(itemList2.length);

        //set lai gia tri count supply full
        setState(() {
          _count = 0;
        });
        for(int t=0;t< _obj_dt_kittingtran.length; t++)
        {
          if(barcode_tray == _obj_dt_kittingtran[t].BarcodePartcard.toString())
          {
            //print('---------');
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
            //_obj_dt_kittingtran[_index].SttCheck = "1";
            setState(() {
              _obj_dt_kittingtran[_index].SttCheck = '1';
              display = '1'; //update ma vua checking
              //_index = _index+1;
            });

            //update luon trang thai checking
            //pendingcheck  updatesttcheck
            _call_api_chekingdip.Update_sttchecking(barcode_tray).then((value) => {
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
              txtTrays.text="";
              codeboxid.requestFocus();
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
                  content: Text('NG, Ma nay chua duoc checking buoc 1!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),  //MessageBox.Show("Partcard kitting khong ton tai");  //Ma nay khong ton tai
                );
              });
          txtTrays.text="";
          codeboxid.requestFocus();
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
      }
    }
    catch(e)
    {
      thongbaoNG(context, e.toString());
    }

  }

  void Listid_fucntion(String value, BuildContext context) {
    try
    {
      if(value != '')
      {
        //1AP1LPMWE310H1YA;H0A327200200;DIP 04;600;DIP-5A6-3C;1170;08/14/2023;VR01;06:00;1220;0;DIP-DP;DIP-DP;RDIP
        var chuoi = txtCode.text.toString();
        List<String>? itemList;
        itemList = chuoi.split(";");
        print(itemList.length);
        //check 4 ky tu cuoi co phai hang dip hay khong?
        String _checkpartlist = itemList[13].toString();
        print(_checkpartlist);
        if (itemList != null && itemList.length == 14)
        {
          if(_checkpartlist == 'RDIP')
          {
            blnScan = true;
            TypeKitting='4';
            DeliveriDate=itemList[6].toString();
            Model=itemList[0].toString();
            Plant=itemList[7].toString();
            Category=itemList[12].toString();
            Name_common=itemList[11].toString();
            Time=itemList[8].toString();
            UploadNo=itemList[10].toString();
            print(DeliveriDate);
            print(Model);
            print(Plant);
            print(Category);
            print(Name_common);
            print(Time);
            print(UploadNo);
            get_dt_tran(TypeKitting, DeliveriDate, Model, Plant, Category, Name_common, Time, UploadNo);

            /* _call_api_chekingdip.get_dt_kittingTran(TypeKitting, DeliveriDate, Model, Plant, Category, Name_common, Time, UploadNo).then((value) {
            if(value!.isEmpty )
            {
              if(ckbListNotYetKitting == true)
              {
                //truong hop show list da duoc checking het!
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text('List da checking het!'),
                      );
                    });
                ckbListNotYetKitting = false;
                txtCode.text = "";
                listrid.requestFocus();
              }
              else
              {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text('NG, Ma List nay khong the kiem tra!'),
                      );
                    });
                txtCode.text = "";
                listrid.requestFocus();
              }
            }
            else
            {


            }

          });*/

          }
          else
          {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.red,
                    content: Text('NG, Dinh dang ma khong dung!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                  );
                });
            //blnScan = false;
            txtCode.text="";
            listrid.requestFocus();
          }
        }
        else
        {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text('NG, Dinh dang ma khong dung!'),
                );
              });
          //blnScan = false;
          txtCode.text="";
          listrid.requestFocus();
        }

      }
      else
      {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.red,
                content: Text('du lieu null!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
              );
            });
        //blnScan = false;
        listrid.requestFocus();
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

  Widget createTable(BuildContext context, AsyncSnapshot snapshot) {
    return  SingleChildScrollView(
      /* scrollDirection: Axis.vertical,*/
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        //height: MediaQuery.of(context).size.height * 0.3,
        child:LayoutBuilder(builder: (context, constraints) {
          //if check box o day hang thieu hoac khong thieu
          //if( _check_shortage ==  true)
          if( ckbListNotYetKitting == false)
          {
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
                        /*onSort: (columnIndex, _isAscending) {
                          setState(() {
                            this._isAscending = _isAscending;
                          });
                        }*/
                        onSort: (columnIndex, _) {
                          setState(() {
                            _currentSortColumn = columnIndex;
                            if (_isAscending == true) {
                              _isAscending = false;
                              // sort the product list in Ascending, order by Price
                              _obj_dt_kittingtran.sort((a, b) =>
                                  a.SttCheck.compareTo(b.SttCheck));
                            } else {
                              _isAscending = true;
                              // sort the product list in Descending, order by Price
                              _obj_dt_kittingtran.sort((a, b) =>
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
                    /*DataColumn(
                      label: Text("TypeKitting"),
                    ),*/

                  ],   //_obj_dt_kittingtran
                  rows: _obj_dt_kittingtran.map(
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
                            Text(p.SttCheck),
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
                            Text(p.Issue_Sloc),
                          ),
                          DataCell(
                            Text(p.DeliveryDate),
                          ),
                          DataCell(
                            Text(p.BarcodeCarton),
                          ),
                          DataCell(
                            Text(p.BarcodePartcard),
                          ),
                          /*DataCell(
                            Text(p.TypeKitting.toString()),
                          ),*/

                        ]),
                  ).toList(),
                ),
              ),
            );
          }
          else
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
                      label: Text("Material"),
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
                      label: Text("Sloc"),
                    ),
                    DataColumn(
                      label: Text("ProductDate"),
                    ),

                  ],   //_obj_dt_kittingtran
                  rows: _obj_dt_notYetKitting.map(
                        (p) => DataRow(cells: [
                      DataCell(
                        Text(p.Material),
                      ),
                      DataCell(
                        Text(p.Quantity.toString()),
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
                        Text(p.status.toString()),
                      ),
                      DataCell(
                        Text(p.SLoc),
                      ),
                      DataCell(
                        Text(p.ProductDate),
                      ),
                    ]),
                  ).toList(),
                ),
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

  }

  void textcode_Data(String Barcode, String type_check, String name_stored, BuildContext context) {


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

  void update_checking(BuildContext context) {
    Openpeding();
    for(int i=0; i < _obj_dt_kittingtran.length; i++)
    {
      String Reservation_Code = txtCode.text.toString();
      String BarcodePartcard = _obj_dt_kittingtran[i].BarcodePartcard;
      String Update_user=datauser;
      //print(Reservation_Code);
      //print(BarcodePartcard);
      //print(Update_user);

      //_call_api_chekingdip.tblKitting_Trans_PartCard_Temp_Update(Reservation_Code, BarcodePartcard, Update_user).then((value) {
      _call_api_chekingdip.tblKitting_Trans_PartCard_Temp_Update_post(Reservation_Code, BarcodePartcard, Update_user).then((value) {
        if(value == true)
        {
         // Closepending();
          //print('ok1');
        }
        else
        {

          //print('ok2');
        }
      });
    }
    Closepending();
    //showOKDialog(context, "Kiem tra thanh cong", "Thông báo");
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.green,
            content: Text('Kiem tra thanh cong.',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
          );
        });
    reset();

  }



  void reset() {
    setState(() {
      txtCode.text='';
      listrid.requestFocus();
      txtTrays.text='';
      txtQuantity.text='';

      _obj_dt_kittingtran = [];
      _obj_dt_notYetKitting = [];
      _check_shortage = false;
      //_typecheck = "-1";
      ckbListNotYetKitting = false;
      blnScan = false;
      // cac bien su kien code box scan
      _checkpartcard_Supply = false;   // bien check partcard duoc ban kiting buoc 1 chua?
      _checkingpartcard_had_scan = false;  //bien check xem duoc checking o buoc 2 chua?
      _check_Supply_Full = true;
      display = '0';
      //thongbao = '';
      _index = 0;
      _count = 0;

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
          _call_api_chekingdip.tblKitting_Trans_PartCard_Temp_Update_SttCheck(Reservation_Code, BarcodePartcard, Update_user, SttCheck).then((value) {
            //true hay false ==> update xong deu quay lai   ****
          });
        }
        //doan nay viet the nay moi tat duoc show pop up
        Navigator.push(context, new MaterialPageRoute(builder: (context) => new MenuKittingDIP(UserID: datauser)));
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
        //set_value_Listview();
        txtTrays.text="";
        codeboxid.requestFocus();
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

  void  get_dt_tran(String TypeKitting,String DeliveriDate,String Model,String Plant,String Category,String Name_common,String Time,String UploadNo) async
  {
    _obj_dt_kittingtran = (await _call_api_chekingdip.get_dt_kittingTran(TypeKitting, DeliveriDate, Model, Plant, Category, Name_common, Time, UploadNo))!;
    if(_obj_dt_kittingtran.length > 0)
    {
      print('kiem tra gia tri hang delay');
      print(_obj_dt_kittingtran.length);
      print(_obj_dt_kittingtran[0].BarcodePartcard);
      for(int i=0;i< _obj_dt_kittingtran.length; i++)
      {
        if(_obj_dt_kittingtran[i].StatusDelay == "1")
        {
          Check_delay = "1";
          break;
        }
      }
      //show gridview
      setState(() {
        display ='1';
      });
      if(Check_delay == "1")
      {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.red,
                content: Text('Model nay bi tam hoan.\nKhong the kiem tra',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
              );
            });
        txtCode.text='';
        listrid.requestFocus();
        _check_shortage = false;
      }
      else
      {
        String ProductDate = DeliveriDate;
        _obj_dt_temp = (await _call_api_chekingdip.get_dt_dt_temp(ProductDate, Plant, Category, Time, UploadNo,Model))!;

        if(_obj_dt_temp.length > 0)
        {
          count_dt_temp = _obj_dt_kittingtran.length;
          print('soluong ban ghi dt_tem: ${_obj_dt_temp.length}');
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
            //ham dip khong goi so luong    //txtQuantity.Text = (_supply1.Get_SumQuantity_Supply
            showAlertDialog_shortage (context);

          }
          else if(count_dt_temp == _obj_dt_kittingtran.length && _check_shortage == false)
          {
            print("khong phai hang thieu => so luong 2 bang = nhau");
            //set_value_Listview();
            //truong hop OK
            //ham dip khong goi so luong    //txtQuantity.Text = (_supply1.Get_SumQuantity_Supply
            txtTrays.text="";
            codeboxid.requestFocus();
          }
          else
          {
            print("so luong 2 bang khong = nhau  ==> This Model not enough qty.Do you wan checking?");
            //ham dip khong goi so luong    //txtQuantity.Text = (_supply1.Get_SumQuantity_Supply
            showAlertDialog_shortage (context);
          }


        }
        else
        {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.red,
                  content: Text('NG, Ma List nay khong the kiem tra, dt_temp null!!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
                );
              });
          txtCode.text = "";
          listrid.requestFocus();
        }
      }

    }
    else
    {
      print('gia tri null');
      if(ckbListNotYetKitting == true)
      {
        //truong hop show list da duoc checking het!
        /*showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.red,
                content: Text('List da checking het!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
              );
            });*/
        /*ckbListNotYetKitting = false;
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
      }
      else
      {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.red,
                content: Text('Ma List nay khong the kiem tra!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),),
              );
            });
        txtCode.text = "";
        listrid.requestFocus();
      }
    }
  }

  showAlertDialog_update_shortage(BuildContext context) {
    // truong hop checking hang thieu
    Widget continueButton = TextButton(
      child: Text("YES"),
      onPressed: () {
        //update_checking(context);
        update_checking(context);
        Navigator.of(context, rootNavigator: true).pop(true); // dismisses only the dialog and returns true
      },
    );
    Widget cancelButton = TextButton(
      child: Text("NO"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true)
            .pop(false); // dismisses only the dialog and returns false
        reset();
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

}

