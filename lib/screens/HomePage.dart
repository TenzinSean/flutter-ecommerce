import 'package:ecommerce/constants.dart';
import 'package:ecommerce/widgets/bottom_tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageController _tabsPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    // TODO: implement initState
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: PageView(
                controller: _tabsPageController,
                onPageChanged: (num) {
                    setState(() {
                      _selectedTab = num;
                    });
                },
                children: [
                  Container(
                    child: Center(
                      child: Text("Homepage"),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text("Searchpage"),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text("Saved Page"),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text("Saved Page"),
                    ),
                  ),
                ],
              ),
            ),
          BottomTabs(
            selectedTab: _selectedTab,
            tabPressed: (num) {
              setState(() {
                  _tabsPageController.animateToPage(
                  num,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic);
                  },
              );
            },
          ),
        ],
      ),
    );
  }
}
