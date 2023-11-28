import 'dart:async';
import 'package:edimobilesystem/View/FreelocationTemp/MenuFreelocationTemp.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:flutter_datawedge/models/scan_result.dart';
import 'package:flutter_datawedge/flutter_datawedge.dart';
import 'dart:io';

/*void main() {
  runApp(new KittingFA());
}*/

class Fixfreelocation extends StatelessWidget {
  const Fixfreelocation({Key? key, required this.UserID}) : super(key: key);
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


  var txtPallet = new TextEditingController();
  var txtBarcode = new TextEditingController();
  var txtTotalQty = new TextEditingController();
  var txtSplitQty = new TextEditingController();

  //var focusNode = FocusNode(); //gia tri focus
  final FocusNode palletid = FocusNode();
  late FocusNode bacodeid = FocusNode();
  late FocusNode totalqtyid = FocusNode();
  late FocusNode splitqtyid = FocusNode();

  bool isChecked = false;
  String label4 = "";


  //bool txtPartCardEnabled = true;
  //bool txtCodeEnabled = true;
  //bool txtAct_QtyEnabled = true;

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
      onScanResultListener =
          fdw.onScanResult.listen((result) => setState(() async {
            if (palletid.hasFocus) {
              txtPallet.text = result.data;
              //Partcardid_function(result.data, context);
            }
            else if (bacodeid.hasFocus) {
              txtBarcode.text = result.data;
              //await button_clickOK(result.data, context);
            }
          }));
    }
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    palletid.dispose();
    bacodeid.dispose();
    totalqtyid.dispose();
    splitqtyid.dispose();
    super.dispose();

    onScanResultListener.cancel();
  }

  @override
  Widget build(BuildContext context) {
    //Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
    return Scaffold(
        appBar: AppBar(
          title: Text('Fix free location'),
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
                      controller: txtPallet,
                      focusNode: palletid,
                      readOnly: true,
                      showCursor: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Pallet',
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
                        SizedBox(
                            width: 80.0,
                            height: 50.0,
                          child: label4 == ''? Center(child: Text('Total Qty',textAlign: TextAlign.center,style: TextStyle(fontSize: 14,color: Colors.blue,fontWeight: FontWeight.bold,),))
                              :Center(child: Text('Total Qty',textAlign: TextAlign.center,style: TextStyle(fontSize: 14,color: Colors.blue,fontWeight: FontWeight.bold,),))
                        ),
                        // SizedBox(
                        //     width: 80.0,
                        //     height: 50.0,
                        //     child: label4 == ''? Card(child: Text('Total Qty',style: TextStyle(fontSize: 14, color: Colors.blue,fontWeight: FontWeight.bold),))
                        //         : Card(child: Text('${label4}',style: TextStyle(fontSize: 14,color: Colors.blue,fontWeight: FontWeight.bold),))),
                        const SizedBox(
                          width: 5.0,
                        ),
                        SizedBox(
                          width: 80.0,
                          height: 50.0,
                          child: TextField(
                            controller: txtTotalQty,
                            focusNode: totalqtyid,
                            readOnly: true,
                            showCursor: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '',
                              hintText: '',
                            ),
                            //keyboardType: TextInputType.number,
                            onSubmitted: (value) {
                              //Actualid_function(value, context);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),

                        SizedBox(
                          width: 100.0,
                          height: 50.0,
                          child: TextField(
                            controller: txtSplitQty,
                            focusNode: splitqtyid,
                            //readOnly: true,
                            showCursor: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Split Qty',
                              hintText: '',
                            ),
                            keyboardType: TextInputType.number,
                            onSubmitted: (value) {
                              //Actualid_function(value, context);
                            },
                          ),
                        ),

                      ],
                    ),

                    SizedBox(
                      height: 10.0,
                    ),

                    Row(
                      children: <Widget>[
                        SizedBox(width: 10,),
                        //CheckboxListTile(
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) async {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        SizedBox(
                            width: 250.0,
                            height: 20.0,
                            child: Center(child: Text('Qty Khong du theo ke hoach',style: TextStyle(fontSize: 16,color: Colors.blue, fontWeight: FontWeight.bold),))
                        )
                        //Text('View Plant Kitting',style: TextStyle(fontSize: 18.0), ),
                      ],
                    ),

                    SizedBox(
                      height: 10.0,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 15.0),
                          child: ElevatedButton(
                            child: Text('Input'),
                            onPressed: () {

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
                              //reset();
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 10.0),
                          child: ElevatedButton(
                            child: Text('Home'),
                            onPressed: () {
                              Navigator.push(context, new MaterialPageRoute(builder: (context) =>new MenuFreelocationTemp(UserID: datauser)));
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
                          width: 10.0,
                          height: 20.0,
                        ),
                        Text('User : ${datauser}',style: TextStyle(fontSize: 16,color: Colors.blue,fontWeight: FontWeight.bold),
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

  void reset() {
    setState(() {

    });
  }


}
