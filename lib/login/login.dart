import 'package:flutter/material.dart';
import 'package:cooking_app/login/loginForm.dart';

class Login extends StatelessWidget {

  Widget build(BuildContext context) {
    return new Scaffold(
      body: _login(),
    );
  }

  Widget _login() {
    return ListView (
      children: <Widget>[
        Container (
          padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Column (
            children: <Widget>[
              _topText(),
              LoginForm(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _topText() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 130, 0, 0),
      child: Column (
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 0),
            child: Row (
              children: <Widget>[
                Text(
                  'Hello',
                  style: TextStyle (
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Container(
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan (
                text: 'There',
                style: TextStyle(
                  height: .5,
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: <TextSpan> [
                  TextSpan(
                    text: '.',
                    style: TextStyle(
                      fontSize: 90,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}