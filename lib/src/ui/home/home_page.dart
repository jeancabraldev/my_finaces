import 'package:flutter/material.dart';
import 'package:myFinances/src/utils/values/colors.dart';

class HomePage extends StatefulWidget {

  //Rota
  static const String ROUTENAME = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.colorMainPurple,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Center(
            child: Text(
              'Home Page',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),  
    );
  }
}