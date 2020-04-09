import 'package:flutter/material.dart';
import 'package:myFinances/src/root_pages.dart';
import 'package:myFinances/src/ui/authentication/login_page.dart';
import 'package:myFinances/src/ui/home/home_page.dart';

class MyFinances extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.purpleAccent,
      ),
      initialRoute: RootPage.ROUTENAME,
      routes: {
        RootPage.ROUTENAME: (context) => RootPage(),
        LoginPage.ROUTENAME: (context) => LoginPage(),
        HomePage.ROUTENAME: (context) => HomePage(),
      },
    );
  }
}