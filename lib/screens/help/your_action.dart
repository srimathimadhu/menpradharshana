// ignore_for_file: camel_case_types

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:menpradharshana/screens/help/my_ans.dart';
import 'package:menpradharshana/screens/help/my_qus.dart';

class Your_Actions extends StatefulWidget {
  const Your_Actions({super.key});

  @override
  State<Your_Actions> createState() => _Your_ActionsState();
}

class _Your_ActionsState extends State<Your_Actions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: Text('Your Actions'),
        centerTitle: true,
        elevation: 0,
      ),
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          children: <Widget>[
            Container(
              child: TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.tab,
                dragStartBehavior: DragStartBehavior.down,
                tabs: [
                  Tab(text: 'My Qustions'),
                  Tab(text: 'My Answers'),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height /
                  1.3, //height of TabBarView
              decoration:
                  BoxDecoration(border: Border(top: BorderSide(width: 0.5))),
              child: TabBarView(children: <Widget>[My_Qus(), My_Ans()]),
            )
          ],
        ),
      ),
    );
  }
}
