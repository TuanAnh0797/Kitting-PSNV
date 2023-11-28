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

class CombinePallet extends StatelessWidget {
  const CombinePallet({Key? key, required this.UserID}) : super(key: key);
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


  var txtSource = new TextEditingController();
  var txtDestination = new TextEditingController();

  //var focusNode = FocusNode(); //gia tri focus
  final FocusNode sourceid = FocusNode();
  late FocusNode  destinationid= FocusNode();

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
            if (sourceid.hasFocus) {
              txtSource.text = result.data;
              //Partcardid_function(result.data, context);
            }
            else if (destinationid.hasFocus) {
              txtDestination.text = result.data;
              //await button_clickOK(result.data, context);
            }
          }));
    }
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    sourceid.dispose();
    destinationid.dispose();
    super.dispose();

    onScanResultListener.cancel();
  }

  @override
  Widget build(BuildContext context) {
    //Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
    return Scaffold(
        appBar: AppBar(
          title: Text('Combine Pallet'),
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
                      controller: txtSource,
                      focusNode: sourceid,
                      readOnly: true,
                      showCursor: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'PL Nguon',
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
                      controller: txtDestination,
                      focusNode: destinationid,
                      readOnly: true,
                      showCursor: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'PL Dich',
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
                              vertical: 2.0, horizontal: 15.0),
                          child: ElevatedButton(
                            child: Text('OK'),
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
