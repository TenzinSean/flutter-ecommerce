import 'package:flutter/material.dart';
import '../constants.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasBackArrow;
  final bool hasTitle;
  CustomActionBar({this.title, this.hasBackArrow, this.hasTitle});

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;

    return Container(
      padding: EdgeInsets.only(
        top: 56.0,
        left: 24.0,
        right: 24.0,
        bottom: 24.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(_hasBackArrow)
            Container(
              child: Image(
              image: AssetImage(
                "back_arrow.png"
              ),
                color: Colors.white,
                width: 16.0,
                height: 16.0,
              ),
            ),
           if (_hasTitle )
              Text(
                  title ??  "Action Bar",
                  style: Constants.boldHeading,
              ),
          Container(
            width: 42.0,
            height: 42.0,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            child: Text(
              "0",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              )
            ),
          )
        ],
      ),
    );
  }
}
