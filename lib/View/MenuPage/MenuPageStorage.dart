import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MenuPage.dart';

class StoragePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  child: Text('2.1 Storage'),
                  onPressed: () {
                    //Handle menu 1 action

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => StorageDAPage(),
                    //   ),
                    // );
                  },
                ),
              ),
              SizedBox(height: 20.0),

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