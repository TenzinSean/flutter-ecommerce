import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ProductPage extends StatefulWidget {
  final String productId;
  ProductPage({this.productId});


  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final CollectionReference _productsRef = FirebaseFirestore.instance.collection("Products");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack (
        children: [
          ListView(
            children: [
              FutureBuilder(
                future: _productsRef.doc(widget.productId).get(),
                builder: (context, snapshot) {
                  if(snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text("EROOR : ${snapshot.error}"),
                      ),
                    );
                  }

                  if(snapshot.connectionState == ConnectionState.done){
                    Map<String, dynamic> documentData = snapshot.data.data();
                    return ListView(
                      children: [
                        Image.network(
                          "${documentData["images"]}",
                        ),
                        Text(
                            "Product name",
                            style: Constants.boldHeading,
                        ),
                        Text(
                            "Price",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w600,
                            ),
                        ),
                        Text(
                          "Description",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                         )
                        ),
                        Text(
                            "Size",
                          style: Constants.regularDarkText
                        ),
                      ],
                    );
                  }
                  // Loading State
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              ),
            ],
          ),
          CustomActionBar(
            hasBackArrow: true,
            hasTitle: false,
          )
        ],
      )
    );
  }
}
