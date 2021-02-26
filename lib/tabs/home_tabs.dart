import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';


class HomeTab extends StatelessWidget {
  final CollectionReference _productsRef = FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _productsRef.get(),
            builder: (context, snapshot) {
              if(snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("EROOR : ${snapshot.error}"),
                  ),
                );
              }

              // //Collection Data ready to display
              if(snapshot.connectionState == ConnectionState.done){
                return ListView(
                  children: snapshot.data.docs.map((document){
                    return Container(
                      child: Text('Name: ${document.data()['name']}'),
                    );
                  }).toList(),
                );
              }

              // Loading State
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            title: "Home",
            hasBackArrow: false,
          ),
        ],
      )
    );
  }
}
