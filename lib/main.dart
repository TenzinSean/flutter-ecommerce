import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: LandingPage(),
    );
  }
}

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
          return Scaffold(
            body: Container(
              child: Center(
                child: Text ("Firebase app intialized")
              ),
            ),
          );
        }

        // Connecting firebase -- loading
        return Scaffold(
          body: Center(
            child: Text("Initialied App...."),
          ),
        );
      },
    );
  }
}
