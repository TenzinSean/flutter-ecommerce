import 'package:flutter/material.dart';
import '../constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Text(
              "LoginPage",
              style: Constants.regularHeading,
            )
        )
    );
  }
}
