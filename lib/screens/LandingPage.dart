import 'package:ecommerce/screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecommerce/constants.dart';

import 'LoginPage.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> __intialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: __intialization,
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("EROOR : ${snapshot.error}"),
            ),
          );
        }

        //Connection Initialezed firebase is running
        if(snapshot.connectionState ==  ConnectionState.done){
          //Streambuilder check the login state live
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamSnapshot){
              // if stream snapshot has error
              if(snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("EROOR : ${streamSnapshot.error}"),
                  ),
                );
              }

              // Connection state active Do the user login check inside the
              // if statement
              if(streamSnapshot.connectionState == ConnectionState.active){

                //Get the user
                User _user = streamSnapshot.data;

                //if the user is null, we're not logged in
                if(_user == null){

                  // if the user not logged in, head to login
                  return LoginPage();
                } else {

                  // if the user is logged in , head to homepage
                  return HomePage();
                }
              }

              //Checking the auth state
              return Scaffold(
                body: Center(
                  child: Text(
                    "Checking authentication...",
                    style: Constants.regularHeading,
                  ),
                ),
              );
            },
          );
        }

        // Connecting firebase -- loading
        return Scaffold(
          body: Center(
            child: Text(
                "Initialied App....",
              style: Constants.regularHeading,
            ),
          ),
        );
      },
    );
  }
}
