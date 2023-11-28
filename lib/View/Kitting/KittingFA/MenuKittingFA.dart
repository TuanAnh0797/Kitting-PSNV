import 'package:flutter/material.dart';
import '../MenuKitting.dart';
import 'frmCheckingFA.dart';
import 'frmKittingFA.dart';
import 'frmSuplyFA.dart';

//import '../../test.dart';

/*void main(){
  runApp(MaterialApp(
    title: 'Menu',
    theme: ThemeData(
      primarySwatch: Colors.green,
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => MenuKittingFA(UserID:"2012757"),
    },
    //home: MyApp(),
  ));
}*/

class MenuKittingFA extends StatefulWidget {
  MenuKittingFA({Key? key, required this.UserID}) : super(key: key);
  final UserID;

  @override
  State<MenuKittingFA> createState() => _MyAppState(datauser:UserID);
}

class _MyAppState extends State<MenuKittingFA> {

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
        appBar: AppBar(title: Text('Menu Kitting For FA'),),
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
                        child: Text('1.Kitting FA'),
                        onPressed: (){
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => new KittingFA(UserID: datauser))
                          );
                        },
                      ) ,
                    ),
                    Container(
                      /*height: MediaQuery.of(context).size.height,*/
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        child: Text('2.Checking FA'),
                        onPressed: (){
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => new CheckingFA(UserID: datauser))
                          );
                        },
                      ) ,
                    ),
                    Container(
                      /*height: MediaQuery.of(context).size.height,*/
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        child: Text('3.Supply FA'),
                        onPressed: (){
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => new SuplyFA(UserID: datauser))
                          );
                        },
                      ) ,
                    ),
                    /*Container(
                          *//* height: MediaQuery.of(context).size.height,*//*
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(5),
                          child: ElevatedButton(
                            child: Text('4.Kitting Expand'),
                            onPressed: (){

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


