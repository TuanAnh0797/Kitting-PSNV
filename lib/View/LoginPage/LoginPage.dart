import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../Controller/LoginController/LoginController.dart';
import '../MenuPage/MenuPage.dart';
import '../PageCommon/Common.dart';

//bien focus
import 'dart:async';
import 'package:flutter_datawedge/models/scan_result.dart';
import 'package:flutter_datawedge/flutter_datawedge.dart';
import 'dart:io';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _txtUserNameFocusNode = FocusNode();
  TextEditingController usernameController = TextEditingController();
  bool isLoggedIn = false;
  bool loginSuccess = false;

  String lblVersion = "Ver:01";
  String kq_checkversion ="";

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  //bien focus
  late StreamSubscription<ScanResult> onScanResultListener;
  late FlutterDataWedge fdw;


  void handlogin(String value) async {
    try
    {
      if(value.length>=11){
        Openpeding();
        loginSuccess = await Login_HT(value.substring(4, 11));
        print(loginSuccess);
        if (loginSuccess == true) {
          print("vaoday after login");
          print(loginSuccess);
          loginUser();
          Closepending();
        } else {
          usernameController.value = TextEditingValue(text: "");
          _txtUserNameFocusNode.requestFocus();
          Closepending();
          showError(context, "Đăng nhập thất bại", "Thông báo");
        }
      }else{
        showError(context, "User ID không đúng định dạng", "Thông báo");
        usernameController.value = TextEditingValue(text: "");
        _txtUserNameFocusNode.requestFocus();
      }
    }
    catch(e)
    {
      Closepending();
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.red,
              content: Text('${e.toString()}!',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold) ,),
            );
          });

    }

  }

  @override
  void initState() {
    super.initState();
    //_txtUserNameFocusNode.requestFocus();
    //autoLogIn();
    initScanner();
  }

  void initScanner() {
    if (Platform.isAndroid) {
      fdw = FlutterDataWedge(profileName: 'FlutterDataWedge');
      onScanResultListener = fdw.onScanResult
          .listen((result) => setState(() async {
        if(_txtUserNameFocusNode.hasFocus)
        {
          //print('abc');
          usernameController.text = result.data;
          handlogin(result.data);
        }

      } ));
    }
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    onScanResultListener.cancel();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('username');
    print(userId);
    if (userId != "") {
      setState(() {
        isLoggedIn = true;
        goToMenuPage(context);
        //name = userId;
      });
      return;
    }
  }

  Future<void> loginUser() async {
    //print("vaoday2");

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', usernameController.text.substring(4, 11));
    final String? userId = prefs.getString('username');
    //print(userId);
    setState(() {
      //name = nameController.text;
      isLoggedIn = true;
      goToMenuPage(context);
    });

    //nameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //padding: const EdgeInsets.all(20.0),
        //child: !isLoggedIn ? buildLoginForm(context) : Container(),
        child: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Center(
             child: Container(
               margin: const EdgeInsets.all(10.0),
               child: Column(
                 children: [
                   const SizedBox(
                     height: 100.0,
                   ),
                   Text(
                     "EDI SYSTEM",
                     style: TextStyle(
                       fontSize: 30,
                       fontWeight: FontWeight.w700,
                       color: Colors.pink,
                     ),
                   ),
                   const SizedBox(
                     height: 20.0,
                   ),
                   TextField(
                     autofocus: true,
                     readOnly: true,
                     showCursor: true,
                     obscureText: true,
                     controller: usernameController,
                     focusNode: _txtUserNameFocusNode,
                     decoration: InputDecoration(
                       border: OutlineInputBorder(),
                       labelText: 'Password',
                     ),
                   ),
                   const SizedBox(
                     height: 20.0,
                   ),
                   Container(
                     child: Text(
                       "Made by: Develop Team",
                       style: TextStyle(
                         fontSize: 16,
                         fontWeight: FontWeight.w700,
                         color: Colors.green,
                       ),
                     ),
                   ),
                   Container(
                     child: Text(
                       "Ver:01",
                       style: TextStyle(
                         fontSize: 12,
                         fontWeight: FontWeight.w700,
                         color: Colors.green,
                       ),
                     ),
                   ),
                   const SizedBox(
                     height: 120.0,
                   ),
                   Container(
                     child:  FilledButton(
                         onPressed:() {
                           _launchURL();
                         },
                         child: const Text('Update Version')),
                   ),

                 ],

               ),
             ),

            // TextField(
            //   autofocus: true,
            //   controller: usernameController,
            //   focusNode: _txtUserNameFocusNode,
            //   readOnly: true,
            //   showCursor: true,
            //   decoration: InputDecoration(
            //     labelText: 'Username',
            //   ),
            //   onSubmitted: (value){
            //     //handlogin(value);
            //   },
            // ),


          ),
        ),
      ),
    );
  }



  _launchURL() async {
    final Uri url = Uri.parse('http://10.92.184.24:8011/DowloadAPI.aspx');
    //final String script = 'document.getElementById("Button1").click();';

    //check version update
    kq_checkversion = await Checkversion_Foss(lblVersion);
    if(kq_checkversion == "0")
    {
      //update version
      if (!await launchUrl(url)) {
        //throw Exception("Could not launch API dowload ${url}");
        thongbaoNG(context, "Could not launch API dowload!");
      }
      else
      {
        //thoat chuong trinh
        exit(0);
      }
    }
    else
    {
      thongbaoNG(context, "Chua co version moi!");
    }
  }

  void goToMenuPage(BuildContext context) async {
    // Assuming you have defined the MenuPage widget and imported it correctly
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MenuPage(),
      ),
    );
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

}