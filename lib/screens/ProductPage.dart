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
  final CollectionReference _productsRef =
    FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack (
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
                    // Firebase Document Data Ma
                    // Error Map render the data
                    Map<String, dynamic> documentData = snapshot.data.data();
                    // List of Images
                    List imageList = documentData["images"];
                    return ListView(
                      padding: EdgeInsets.all(0),
                      children: [
                        Container(
                          height: 400.0,
                          child: Stack(
                            children: [
                              PageView(
                              children: [
                                for(var i=0; i < imageList.length; i++)
                                  Container(
                                    child: Image.network(
                                      "${imageList[i]}",
                                      fit: BoxFit.cover,
                                    ),
                                  )
                              ],
                            ),
                                  ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 24.0,
                          ),
                         child: Text(
                              "${documentData['name']}",
                              style: Constants.boldHeading,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 24.0,
                          ),
                          child: Text(
                            "\$${documentData['price']}",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w600,
                            )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 24.0,
                          ),
                          child: Text(
                            "${documentData['desc']}",
                            style: Constants.regularDarkText,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 24.0,
                          ),
                          child: Text(
                            "Size",
                            style: Constants.regularDarkText
                          ),
                        )
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
          CustomActionBar(
            hasBackArrow: true,
            hasTitle: false,
          )
        ],
      )
    );
  }
}
