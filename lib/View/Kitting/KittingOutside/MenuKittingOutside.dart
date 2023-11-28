import 'package:flutter/material.dart';
import '../MenuKitting.dart';
import 'frmKittingExportFA.dart';
import 'frmKittingReceiveFA.dart';
import 'frmKittingStockcard.dart';
import 'frmkittingQCRosh.dart';


class MenuKittingOutside extends StatefulWidget {
  MenuKittingOutside({Key? key, required this.UserID}) : super(key: key);
  final UserID;

  @override
  State<MenuKittingOutside> createState() => _MyAppState(datauser:UserID);
}

class _MyAppState extends State<MenuKittingOutside> {

  _MyAppState({Key? key, required this.datauser});
  final String datauser;

  //MenuKittingFA({required this.USerID});
  //final USerID;

  //final TextEditingController _user = TextEditingController();

  //String UserID = "2009847";  //1 time
  //String UserID = "2000109";  //n time
  /* final TextEditingController user = TextEditingController();
  final TextEditingController pass = TextEditingController();*/



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Menu Kitting Outside'),),
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
                        child: Text('1.Kitting Export FA'),
                        onPressed: (){
                          //Navigator.pushNamed(context, '/link_kittingFA');
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => new KittingExportFA(UserID: datauser))
                          );


                        },
                      ) ,
                    ),
                    Container(
                      /*height: MediaQuery.of(context).size.height,*/
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        child: Text('2.Checking Receive FA'),
                        onPressed: (){
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => new KittingReceiveFA(UserID: datauser))
                          );

                        },
                      ) ,
                    ),
                    Container(
                      /*height: MediaQuery.of(context).size.height,*/
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        child: Text('3.Kitting Stockcard'),
                        onPressed: (){
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => new KittingStockcard(UserID: datauser))
                          );
                        },
                      ) ,
                    ),
                    Container(
                      /*height: MediaQuery.of(context).size.height,*/
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        child: Text('4.Tool QC'),
                        onPressed: (){
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => new KittingQCRosh(UserID: datauser))
                          );
                        },
                      ) ,
                    ),

                    /*Container(
                      *//*height: MediaQuery.of(context).size.height,*//*
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        child: Text('5.Kitting pullist urgent'),
                        onPressed: (){
                          *//*Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => new SuplyDIP(UserID: datauser))
                          );*//*
                        },
                      ) ,
                    ),*/

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
                                //builder: (context) => new MenuKitting(UserID: datauser))
                                  builder: (context) => new MenuKitting(UserID: datauser))
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 20.0,
                    ),

                    Container(
                      /* height: MediaQuery.of(context).size.height,*/
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5),
                      child: Text('UserID : ${datauser}',style: TextStyle(fontSize: 15,color: Colors.blue, fontWeight: FontWeight.bold),),
                    ),

                  ],
                )
            )

        )
    );

  }



}


