import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../FreelocationTemp/MenuFreelocationTemp.dart';
import '../Kitting/MenuKitting.dart';
import '../LoginPage/LoginPage.dart';
import '../Otherfuntion/frmCheckStatus.dart';
import '../Otherfuntion/frmPostDiff.dart';
import 'MenuPageGoodsReceiveCommon.dart';
import 'MenuPageStorage.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String userId="";
  @override
  void autogetuser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('username')!;
    });

  }
  Future<void> logout() async {
    //print("vaoday123");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', "");
    goToLoginPage(context);
  }



  @override
  void initState() {
    super.initState();
    autogetuser();

  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if(userId=="")
                  CircularProgressIndicator()
                else
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    height: 50,
                    width: MediaQuery.of(context).size.width - 20,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFFd8dbe0),
                              offset: Offset(1, 1),
                              blurRadius: 20.0,
                              spreadRadius: 10)
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Text(
                                'Welcome: $userId',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            child: Text('1. Goods receive'),
                            onPressed: () {
                              // Handle menu 1 action
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MenuPageGoodsReceiveCommon(),
                                ),
                              );
                            },
                          ),
                        ), SizedBox(width: 10.0),
                        Expanded(
                          child: ElevatedButton(
                            child: Text('6. Check status'),
                            onPressed: () {
                              // Handle menu 2 action
                              Navigator.push(context, new MaterialPageRoute(
                                  builder: (context) => new CheckStockcard(UserID: userId))
                              );
                            },
                          ),
                        ),
                      ],
                    )
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            child: Text('2. Storage'),
                            onPressed: () {
                              // Handle menu 1 action
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StoragePage(),
                                ),
                              );
                            },
                          ),
                        ), SizedBox(width: 10.0),
                        Expanded(
                          child: ElevatedButton(
                            child: Text('7. Input Sirim'),
                            onPressed: () {
                              // Handle menu 2 action
                            },
                          ),
                        ),
                      ],
                    )
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            child: Text('3. Kitting'),
                            onPressed: () {
                              Navigator.push(context, new MaterialPageRoute(
                                  builder: (context) => new MenuKitting(UserID: userId))
                              );
                            },
                          ),
                        ), SizedBox(width: 10.0),
                        Expanded(
                          child: ElevatedButton(
                            child: Text('8. Post Diff'),
                            onPressed: () {
                              Navigator.push(context, new MaterialPageRoute(
                                  builder: (context) => new Postdiff(UserID: userId))
                              );
                            },
                          ),
                        ),
                      ],
                    )
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            //child: Text('4. Transfer'),
                            child: Text('4. Temporary Freelocation'),
                            onPressed: () {
                              Navigator.push(context, new MaterialPageRoute(
                                  builder: (context) => new MenuFreelocationTemp(UserID: userId))
                              );
                            },
                          ),
                        ), SizedBox(width: 10.0),
                        Expanded(
                          child: ElevatedButton(
                            child: Text('9. Inventory'),
                            onPressed: () {
                              // Handle menu 2 action
                            },
                          ),
                        ),
                      ],
                    )
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            child: Text('5. Compare'),
                            onPressed: () {
                              // Handle menu 1 action
                            },
                          ),
                        ), SizedBox(width: 10.0),
                        Expanded(
                          child: ElevatedButton(
                            child: Text('10. Scan Hoppe'),
                            onPressed: () {
                              // Handle menu 2 action
                            },
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  child: Text('Logout'),
                  onPressed: () {
                    // Implement your logout logic here
                    logout();
                  },
                ),

              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
  void goToLoginPage(BuildContext context) async {
    // Assuming you have defined the MenuPage widget and imported it correctly
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}