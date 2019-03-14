import 'package:flutter/material.dart';

class Unknown extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 30),
                child: Text(
                  'You took a wrong turn :(',
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                )
              ),

              RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                child: Center (
                  heightFactor: 2,
                  child: Text(
                    'Go Back',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    )
                  )
                ),
                onPressed: () {
                  Navigator.pop(context);
                }
              )
            ],
          )
        )
      )
    );
  }
}