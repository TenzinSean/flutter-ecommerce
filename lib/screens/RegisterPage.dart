import 'package:ecommerce/screens/LoginPage.dart';
import 'package:ecommerce/widgets/custom_btn.dart';
import 'package:ecommerce/widgets/custom_input.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  //Build on alert dialog to display some errors.
  Future<void> _alertDialgBuilder() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text("Just some random text for now"),
            ),
            actions: [
              FlatButton(
                  child: Text("close Dialog"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
              )
            ],
          );
        }
    );
  }

  bool _registerFormLoading = false;

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
                  'Create new Account',
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
                    text: "Create new Account",
                    onPressed: () {
                      //Open the dialog
                      setState(() {
                        _registerFormLoading = true;
                      });
                    },
                    isLoading: _registerFormLoading,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16.0,
                ),
                child: CustomBtn(
                  text: "Back to Login",
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => LoginPage()
                    //   ),
                    // );
                    Navigator.pop(context);
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
