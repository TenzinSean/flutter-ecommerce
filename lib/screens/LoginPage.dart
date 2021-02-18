import 'package:ecommerce/screens/RegisterPage.dart';
import 'package:ecommerce/widgets/custom_btn.dart';
import 'package:ecommerce/widgets/custom_input.dart';
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
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                top: 24.0
                ),
                  child: Text(
                      'Welcome User Login, \n Login to your account',
                       textAlign: TextAlign.center,
                       style: Constants.boldHeading,
                  ),
                ),
                Column(
                  children: [
                    CustomInput(
                      hintText: "Email...",
                    ),
                    CustomInput(
                      hintText: "Password.. ",
                    ),
                    CustomBtn(
                      text: "Login",
                      onPressed: () {
                        print("click login button");
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16.0,
                  ),
                  child: CustomBtn(
                    text: "Create new Account",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage()
                      ),
                      );
                    },
                    outlinedBtn: true,
                  ),
                ),
              ],
            ),
        ),
    ),
        );
  }
}
