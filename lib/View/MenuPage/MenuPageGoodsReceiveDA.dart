import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controller/GRController/GRController.dart';
import '../GRPage/GRNoPo.dart';
import 'MenuPageGoodsReceiveCommon.dart';

class MenuPageGoodsReceive extends StatefulWidget {
  const MenuPageGoodsReceive({super.key});

  @override
  State<MenuPageGoodsReceive> createState() => _MenuPageGoodsReceiveState();
}

class _MenuPageGoodsReceiveState extends State<MenuPageGoodsReceive> {

  bool isActiveOpenGR=false;
  bool isActiveRevertGR=false;
  bool iswait=false;
  String userId="";

  @override
  void initState() {
    super.initState();
    autogetuser();

  }

  void autogetuser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('username')!;

    });
    UserRight1();
  }

  void UserRight1() async {
    bool check = await UserRight(userId, "frmRevertGR_NoPOPending");
    if(check){
      isActiveRevertGR=true;
    }
    bool check1 = await UserRight(userId, "frmOpenGR_NoPOPending");
    if(check1){
      isActiveOpenGR=true;
    }
    setState(() {
      iswait=true;
    });
  }



  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: iswait?Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  child:
                  Container(width: 200,
                      alignment:Alignment.center,child: Text('1.1 Goods receive')),
                  onPressed: () {
                    // Handle menu 1 action
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GRNoPo(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  child:
                  Container(width: 200,
                      alignment:Alignment.center,child: Text('1.2 Open GR')),
                  onPressed:  isActiveOpenGR ? () {
                    // Handle menu 1 action
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => OpenGRPage(),
                    //   ),
                    // );
                  }:null,
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  child:
                  Container(width: 200,
                      alignment:Alignment.center,child: Text('1.3 Revert GR')),
                  onPressed: isActiveRevertGR?() {
                    // Handle menu 1 action
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => RevertGRPage(),
                    //   ),
                    // );
                  }:null,
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  child:
                  Container(width: 200,
                      alignment:Alignment.center,child: Text('1.4 Check Part not GR')),
                  onPressed: () {
                    // Handle menu 1 action
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => CheckPartNotGRPage(),
                    //   ),
                    // );
                  },
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  child:
                  Container(width: 200,
                      alignment:Alignment.center,child: Text('1.5 Scan barcode NG')),
                  onPressed: () {
                    // Handle menu 1 action
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => LabelGRNGPage(),
                    //   ),
                    // );
                  },
                ),
              ),
              SizedBox(height: 10.0),

              /*InkWell(
                onTap: () {
                  // Add your button click logic here
                },
                child: Container(
                  width: 200, // Set the width of the container as per your requirement
                  height: 50, // Set the height of the container as per your requirement
                  decoration: BoxDecoration(
                    color: Colors.blue, // Set the background color of the container
                    borderRadius: BorderRadius.circular(8), // Set the border radius of the container
                  ),
                  child: Center(
                    child: Text(
                      'Click Me',
                      style: TextStyle(
                        color: Colors.white, // Set the text color of the button
                        fontSize: 18, // Set the font size of the button text
                      ),
                    ),
                  ),
                ),
              ),*/

              ElevatedButton(
                child: Text('Back'),
                onPressed: () {
                  // Implement your logout logic here
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MenuPageGoodsReceiveCommon()),
                        (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          ),
        ):CircularProgressIndicator(),
      ),
    );
  }
}