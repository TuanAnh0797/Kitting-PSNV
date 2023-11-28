import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MenuPage.dart';
import 'MenuPageGoodsReceiveDA.dart';

class MenuPageGoodsReceiveCommon extends StatelessWidget {
  const MenuPageGoodsReceiveCommon({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
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
                      alignment:Alignment.center,child: Text('1. Goods receive Local')),
                  onPressed: () {
                    // Handle menu 1 action
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MenuPageGoodsReceive(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  child:
                  Container(width: 200,
                      alignment:Alignment.center,child: Text('2. Goods receive Oversea')),
                  onPressed: () {
                    // Handle menu 1 action
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => MenuPageGoodReceiveOversea(),
                    //   ),
                    // );
                  },
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                child: Text('Back'),
                onPressed: () {
                  // Implement your logout logic here
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MenuPage()),
                        (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}