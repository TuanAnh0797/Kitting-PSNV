import 'package:flutter/material.dart';
import '../MenuPage/MenuPage.dart';
import 'CombinePallet.dart';
import 'MoveStockcard.dart';
import 'StorageTemp.dart';
import 'fixfreelocation.dart';


class MenuFreelocationTemp extends StatefulWidget {
  const MenuFreelocationTemp({Key? key,required this.UserID}) : super(key: key);
  final UserID;

  @override
  State<MenuFreelocationTemp> createState() => _MyAppState(datauser:UserID);
}

class _MyAppState extends State<MenuFreelocationTemp> {
  _MyAppState({Key? key, required this.datauser});
  final String datauser;

  // final TextEditingController _user = TextEditingController();

  //String UserID = datauser;  //1 time
  //String UserID = "2000109";  //n time

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Menu Free Location Temp'),),
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
                        child: Text('4.1 Fix Freelocation'),
                        onPressed: (){
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => new Fixfreelocation(UserID: datauser))
                          );

                        },
                      ) ,
                    ),
                    Container(
                      /*height: MediaQuery.of(context).size.height,*/
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        child: Text('4.2 Move Stock Card'),
                        onPressed: (){
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => new MoveStockCard(UserID: datauser))
                          );
                        },
                      ) ,
                    ),
                    Container(
                      /*height: MediaQuery.of(context).size.height,*/
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        child: Text('4.3 Combine Pallet'),
                        onPressed: (){
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => new CombinePallet(UserID: datauser))
                          );
                        },
                      ) ,
                    ),

                    Container(
                      /*height: MediaQuery.of(context).size.height,*/
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        child: Text('4.4 Storage'),
                        onPressed: (){
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => new Storagetemp(UserID: datauser))
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
