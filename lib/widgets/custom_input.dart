import 'package:flutter/material.dart';
import 'package:ecommerce/constants.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  CustomInput({this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 24.0,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText ?? "Hint text",
          contentPadding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 20.0,
          )
        ),
        style: Constants.regularDarkText,
      )
    );
  }
}
