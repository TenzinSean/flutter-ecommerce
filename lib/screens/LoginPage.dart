import 'package:ecommerce/screens/RegisterPage.dart';
import 'package:ecommerce/widgets/custom_btn.dart';
import 'package:ecommerce/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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

  //Login page
  Future<String> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _LoginEmail, password: _LoginPassword);
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
      _loginFormLoading = true;
    });

    // Run the create account method
    String _signInFeedback = await _loginAccount();

    // If the string is not null, we got error while create account.
    if(_signInFeedback != null) {
      _alertDialogBuilder(_signInFeedback);

      // Set the form to regular state [ not loading]
      setState(() {
        _loginFormLoading = false;
      });
    }
  }

  // Default from Loading State
  bool _loginFormLoading = false;

  // Form Input Field Values
  String _LoginEmail = "";
  String _LoginPassword = "";


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
                      'Welcome User Login, \n Login to your account',
                       textAlign: TextAlign.center,
                       style: Constants.boldHeading,
                  ),
                ),
                Column(
                  children: [
                    CustomInput(
                      hintText: "Email...",
                      onChanged: (value) {
                        _LoginEmail = value;
                      },
                      onSubmit: (value) {
                        _passwordFocusNode.requestFocus();
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    CustomInput(
                      hintText: "Password...",
                      onChanged: (value) {
                        _LoginPassword = value;
                      },
                      onSubmit: (value) {
                        _passwordFocusNode.requestFocus();
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    CustomBtn(
                      text: "Login",
                      onPressed: () {
                        _submitForm();
                      },
                      isLoading: _loginFormLoading,
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
