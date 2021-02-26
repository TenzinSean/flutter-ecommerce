import 'package:ecommerce/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';

class SearchTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
          children: [
            Center(
              child: Text("Search Tabs"),
            ),
            CustomActionBar(
              title: "Search",
              hasBackArrow: false,
            ),
          ],
        )
    );
  }
}
