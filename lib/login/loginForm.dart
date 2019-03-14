import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cooking_app/login/registerForm.dart';
import 'package:cooking_app/models/user.dart';

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {

  final _formKey = new GlobalKey<FormState>(debugLabel: '_loginForm');
  UserLogin _userLogin = new UserLogin();
  BuildContext _context;

  @override
  Widget build(BuildContext context) {

    _context = context;
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.only(top: 40),
        padding: EdgeInsets.only(left:15, right: 15),
        child: Column (
          children: <Widget>[

            _emailWidget(),
            _passwordWidget(),
            _forgotPasswordWidget(),
            _loginButtonWidget(),
            _googleButtonWidget(),
            _registerWidget(),

          ],
        )
      )
    );
  }

  // EmailField
  Widget _emailWidget() {
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'EMAIL',
          labelStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter an Email';
          }
        },
        onSaved: (val) => _userLogin.Email = val
      ),
    );
  }


  Widget _passwordWidget() {
    return Container(
      child: TextFormField (
        obscureText: true,
        decoration: InputDecoration (
          labelText: 'PASSWORD',
          labelStyle: TextStyle (
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter a password';
          }
        },
        onSaved: (val) => _userLogin.Password = val
      ),
    );
  }

  // Forgot Password LInk
  Widget _forgotPasswordWidget() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(top: 15),
      child: Material(
        child:  InkWell (
          child: Text (
            'Forgot Password',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
          onTap: () {},
        ),
      ),
    );
  }

  Widget _loginButtonWidget() {
    return Container(
      padding: EdgeInsets.only(top: 25),
      child: Material(
        child: RaisedButton(
          onPressed: _attemptLogin,
          textColor: Colors.white,
          color: Colors.blue,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          child: Center (
            heightFactor: 2,
            child: Text (
              'Login',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _googleButtonWidget(){
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Material(
        child: RaisedButton(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onPressed: _me,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: new SvgPicture.asset(
                    'assets/images/btn_google_light_normal_ios.svg',
                    height: 50,
                    width: 50,
                  ),
                ),
                Center(
                  child: Text(
                    'Sign in with Google',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )
                  )
                ),
              ]
            ),
          ),
        ),
      )
    );
  }

  Widget _registerWidget() {
    return Container(
      padding: EdgeInsets.only(top: 25, bottom: 10),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text('New Here? '),
            ),
            Center(
              child: Material(
                child: InkWell(
                  child: Text(
                    'Regiseter',
                    style: TextStyle(
                      color: Colors.blue
                    )
                  ),
                  onTap: () => _register(),
                )
              )
            )
          ],
        )
      )
    );
  }

  void _attemptLogin() async {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        _userLogin.login();
      } catch(e) {
        // Show Snack Bar
        print(e);
        Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Incorrect Email/Password')));
      }
    }
  }

  void _register() {
    Navigator.pushNamed(context, '/register');
  }

  // This is just for testing a query
  void _me() async {
    _userLogin.me();
    Navigator.pushNamed(context, '/error');
  }
}

