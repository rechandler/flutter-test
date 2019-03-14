import 'package:flutter/material.dart';
import 'package:cooking_app/utils/unknown.dart';
import 'package:cooking_app/home/homeView.dart';
import 'package:cooking_app/login/login.dart';
import 'package:cooking_app/login/register.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cooking_app/dao/graphql_client.dart';

void main() => runApp(App());

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    primeEnv();
    return new MaterialApp(
      title: 'Cooking App',
      initialRoute: '/login',
      routes: {
        '/': (context) => HomeView(),
        '/login': (context) => Login(),
        '/register': (context) => Register(),
      },
      onUnknownRoute: (RouteSettings setting) {
        return new MaterialPageRoute(
            builder: (context) => Unknown()
        );
      }
    );
  }

  /**
   * Load the .env file into the app
   */
  void primeEnv() async {
    await DotEnv().load('.env');
    new Client().setup();
  }
}