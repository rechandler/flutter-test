import 'package:flutter/material.dart';
import 'package:cooking_app/login/registerForm.dart';

class Register extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _registration(),
    );
  }

  Widget _registration() {
    return Material(
      child: Container(
        padding: EdgeInsets.only(left:30, right: 30),
        child: Center(
          child: RegisterForm(),
        )
      )
    );
  }
}