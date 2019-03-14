import 'package:flutter/material.dart';
import 'package:cooking_app/models/registration.dart';


class RegisterForm extends StatefulWidget {
  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {

  final _registerKey = new GlobalKey<FormState>(debugLabel: '_registerForm');
  Registration _registration = new Registration();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registerKey,
      child: Material(
        child: Container (
          padding: EdgeInsets.only(bottom: 40),
          child: Column (
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              _emailAddress(),
              _username(),
              _password(),
              _registerButton(),

            ],
          )
        )
      ),
    );
  }

  Widget _emailAddress() {
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'EMAIL',
          labelStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter an Email';
          }
        },
        onSaved: (val) => _registration.email = val
      )
    );
  }

  Widget _username() {
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'USERNAME',
          labelStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold
          )
        ),
        validator: (val) {
          if(val.isEmpty) {
            return 'Please enter a USERNAME';
          }
        },
        onSaved: (val) => _registration.username = val
      )
    );
  }

  Widget _password() {
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'PASSWORD',
          labelStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold
          )
        ),
        validator: (val) {
          if(val.isEmpty) {
            return 'Gotta enter a password... make it good ;)';
          }
        },
        onSaved: (val) => _registration.password = val,
      )
    );
  }

  Widget _registerButton() {
    return Container(
      child: RaisedButton(
        onPressed: _attemptRegister,
        textColor: Colors.white,
        color: Colors.blue,
        child: Center (
          heightFactor: 2,
          child: Text(
            'Register',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            )
          )
        )
      )
    );
  }

  void _attemptRegister() {
    if(_registerKey.currentState.validate()) {
      _registerKey.currentState.save();

      try {
        _registration.register();
      } catch(message) {
        Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
      }
    }
  }
}