import 'package:flutter/material.dart';
import '../MenuPage/MenuPage.dart';
import 'IssueLabelNG/frmIssuLabelNG.dart';
import 'KittingDIP/MenuKittingDIP.dart';
import 'KittingFA/MenuKittingFA.dart';
import 'KittingOutside/MenuKittingOutside.dart';
import 'UnlockMaterial/frmUnlockmaterial.dart';

class MenuKitting extends StatefulWidget {
  const MenuKitting({Key? key,required this.UserID}) : super(key: key);
  final UserID;

  @override
  State<MenuKitting> createState() => _MyAppState(datauser:UserID);
}

class _MyAppState extends State<MenuKitting> {
  _MyAppState({Key? key, required this.datauser});
  final String datauser;

 // final TextEditingController _user = TextEditingController();

  //String UserID = datauser;  //1 time
  //String UserID = "2000109";  //n time

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Menu Kitting MCS'),),
        body: Padding(
            padding: EdgeInsets.all(15),
            child:SingleChildScrollView(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      /*height: MediaQuery.of(context).size.height,*/
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        child: Text('3.1 Kitting FA'),
                        onPressed: (){
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => new MenuKittingFA(UserID: datauser))
                          );

                        },
                      ) ,
                    ),
                    Container(
                      /*height: MediaQuery.of(context).size.height,*/
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        child: Text('3.2 Kitting DIP'),
                        onPressed: (){
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => new MenuKittingDIP(UserID: datauser))
                          );
                        },
                      ) ,
                    ),
                    Container(
                      /*height: MediaQuery.of(context).size.height,*/
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        child: Text('3.3 Kitting outside'),
                        onPressed: (){
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => new MenuKittingOutside(UserID: datauser))
                          );
                        },
                      ) ,
                    ),
                    /*Container(
                      *//*height: MediaQuery.of(context).size.height,*//*
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        child: Text('3.4 Free Temp Location'),
                        onPressed: (){

                        },
                      ) ,
                    ),*/
                    Container(
                      /*height: MediaQuery.of(context).size.height,*/
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        child: Text('3.4 Issue label NG'),
                        onPressed: (){
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => new IssulabelNG(UserID: datauser))
                          );
                        },
                      ) ,
                    ),
                    Container(
                      /*height: MediaQuery.of(context).size.height,*/
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        child: Text('3.5 Unlock Material'),
                        onPressed: (){
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => new UnlockMaterial(UserID: datauser))
                          );
                        },
                      ) ,
                    ),

                    const SizedBox(
                      height: 50.0,
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
                              Navigator.push(context, new MaterialPageRoute(
                                  builder: (context) => new MenuPage())
                              );
                            },
                          ),
                        ),
                      ],
                    ),


                  ],
                )
            )

        )


    );
  }
}
