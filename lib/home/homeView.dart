import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {

  @override
  HomeViewState createState() => new HomeViewState();
}

class HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cooking App'),
      ),
      body: Center(
        child: Text('Checking Center')
      )
    );
  }
}