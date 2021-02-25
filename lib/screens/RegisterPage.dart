import 'package:ecommerce/screens/LoginPage.dart';
import 'package:ecommerce/widgets/custom_btn.dart';
import 'package:ecommerce/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  //Build on alert dialog to display some errors.
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(error),
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

  // Create a new user account
  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
      return null;
    } on FirebaseAuthException catch(e) {
      if(e.code == 'weak-password') {
        return 'The password provided is too weak';
      } else if (e.code == 'email-already-in-user') {
        return 'The account already exists for that email';
      }
      return e.message;
    } catch(e) {
      print(e.toString());
    }
  }

  void _submitForm() async {
      // Set the form to loading state
      setState(() {
        _registerFormLoading = true;
      });

      // Run the create account method
      String _createAccountFeedback = await _createAccount();

      // If the string is not null, we got error while create account.
      if(_createAccountFeedback != null) {
        _alertDialogBuilder(_createAccountFeedback);

        // Set the form to regular state [ not loading]
        setState(() {
          _registerFormLoading = false;
        });
      } else {
        // The String was null, user is logged in, head back to login page
        Navigator.pop(context);
      }
  }

  // Default from Loading State
  bool _registerFormLoading = false;

  // Form Input Field Values
  String _registerEmail = "";
  String _registerPassword = "";


  // Focus Node for input fields
  FocusNode _passwordFocusNode;

  @override
  void initState(){
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }


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
                    onChanged: (value) {
                      _registerEmail = value;
                    },
                    onSubmit: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInput(
                    hintText: "Password.. ",
                    onChanged: (value) {
                      _registerPassword = value;
                    },
                    focusNode: _passwordFocusNode,
                    isPasswordField: true,
                    onSubmit: (value) {
                      _submitForm();
                    },
                  ),
                  CustomBtn(
                    text: "Create new Account",
                    onPressed: () {
                      //Open the dialog
                      _submitForm();
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
