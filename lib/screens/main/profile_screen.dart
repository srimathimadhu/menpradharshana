// ignore_for_file: camel_case_types, non_constant_identifier_names, unused_field, unused_local_variable, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:menpradharshana/controller/login_page.dart';
import 'package:numberpicker/numberpicker.dart';
import '../widgets/loading.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({super.key});

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  final currentUser = FirebaseAuth.instance;

  int _currentValue = 0;

  //logout
  Future<LoginPage> _signOut() async {
    await FirebaseAuth.instance.signOut();
    return new LoginPage();
  }

  //delete project
  final CollectionReference _teams =
      FirebaseFirestore.instance.collection('teams');
  Future<void> _delete(String project) async {
    await _teams.doc(project).delete().whenComplete(() {
      Navigator.pop(context);
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Successfully Deleted Your Project',
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50]!.withOpacity(0.5),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 150.0,
            decoration: BoxDecoration(
                color: Colors.blue[600],
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0),
                )),
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(left: 30.0, right: 30.0, top: 70.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "Account",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      FloatingActionButton.small(
                        backgroundColor: Colors.white,
                        onPressed: () {
                          _signOut();
                        },
                        child: Icon(
                          Icons.person ,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .where("uid", isEqualTo: currentUser.currentUser?.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, i) {
                        var data = snapshot.data!.docs[i];
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 40, bottom: 8, top: 8, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Name: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data['name'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Branch: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data['dept'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    data['year'].toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Register No: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data['regno'].toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Reward Points: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data['reward_point'].toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      });
                } else {
                  return Text('');
                }
              }),
          Text(
            'My Projects',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          DefaultTabController(
              length: 3, // length of tabs
              initialIndex: 0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      child: TabBar(
                        labelColor: Colors.blue[600],
                        indicatorColor: Colors.blue[600],
                        unselectedLabelColor: Colors.grey,
                        indicatorSize: TabBarIndicatorSize.tab,
                        dragStartBehavior: DragStartBehavior.down,
                        tabs: [
                          Tab(text: 'Pending'),
                          Tab(text: 'Selected'),
                          Tab(text: 'Rejected'),
                        ],
                      ),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height /
                            2, //height of TabBarView
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Colors.grey, width: 0.5))),
                        child: TabBarView(children: <Widget>[
                          Container(
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("teams")
                                    .where("email",
                                        arrayContains:
                                            currentUser.currentUser!.email)
                                    .where("stage", isEqualTo: "Pending")
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, i) {
                                          var data = snapshot.data!.docs[i];
                                          Timestamp t =
                                              data['Register_On'] as Timestamp;
                                          DateTime date = t.toDate();
                                          return Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                      context: context,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      builder:
                                                          (BuildContext bc) {
                                                        return SingleChildScrollView(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Container(
                                                              height: 500,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30.0),
                                                              ),
                                                              child:
                                                                  SingleChildScrollView(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          15.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      Row(
                                                                        children: <
                                                                            Widget>[
                                                                          Container(
                                                                            decoration:
                                                                                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                                                                            child:
                                                                                Image.asset(
                                                                              "assets/m.png",
                                                                              height: 60.0,
                                                                              width: 60.0,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(10.0),
                                                                              child: Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: <Widget>[
                                                                                  Text(
                                                                                    data['Team_Name'],
                                                                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),
                                                                                  ),
                                                                                  Spacer(),
                                                                                  Container(
                                                                                    height: 20,
                                                                                    width: 70,
                                                                                    decoration: BoxDecoration(shape: BoxShape.rectangle, color: Colors.black),
                                                                                    child: Center(
                                                                                      child: Text(
                                                                                        data['stage'],
                                                                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  IconButton(
                                                                                    onPressed: () {
                                                                                      _delete(data.id);
                                                                                    },
                                                                                    icon: Icon(Icons.delete),
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(20.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                Text(
                                                                                  "Project Name",
                                                                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),
                                                                                ),
                                                                                Spacer(),
                                                                              ],
                                                                            ),
                                                                            SizedBox(height: 10),
                                                                            Text(
                                                                              data['Project_Name'],
                                                                              style: TextStyle(color: Colors.black, fontSize: 14.0),
                                                                            ),
                                                                            SizedBox(height: 10.0),
                                                                            Row(
                                                                              children: [
                                                                                Text(
                                                                                  "Team Members",
                                                                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),
                                                                                ),
                                                                                Spacer(),
                                                                              ],
                                                                            ),
                                                                            SizedBox(height: 10.0),
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      "1. ",
                                                                                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                                                                                    ),
                                                                                    Text(
                                                                                      data['Leader_Name'],
                                                                                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      "2. ",
                                                                                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                                                                                    ),
                                                                                    Text(
                                                                                      data['Member_1'],
                                                                                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      "3. ",
                                                                                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                                                                                    ),
                                                                                    Text(
                                                                                      data['Member_2'],
                                                                                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(height: 10.0),
                                                                                Text(
                                                                                  "Description",
                                                                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),
                                                                                ),
                                                                                SizedBox(height: 5.0),
                                                                                Text(
                                                                                  data['Project_Dis'],
                                                                                  style: TextStyle(color: Colors.black, fontSize: 15.0),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 95.0,
                                                      width: 350.0,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0)),
                                                              child:
                                                                  Image.asset(
                                                                "assets/m.png",
                                                                height: 60.0,
                                                                width: 60.0,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Text(
                                                                          data[
                                                                              'Team_Name'],
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 16.0),
                                                                        ),
                                                                        Spacer(),
                                                                        Text(
                                                                          data['Register_On']
                                                                              .toDate()
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              color: Colors.grey,
                                                                              fontSize: 12.0),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          data[
                                                                              'Project_Name'],
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 14.0),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.0),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  } else {
                                    return Center(child: Loading());
                                  }
                                }),
                          ),
                          Container(
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("teams")
                                    .where("email",
                                        arrayContains:
                                            currentUser.currentUser?.email)
                                    .where("stage", isEqualTo: "Selected")
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, i) {
                                          var data = snapshot.data!.docs[i];
                                          Timestamp t =
                                              data['Register_On'] as Timestamp;
                                          DateTime date = t.toDate();
                                          return Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                      context: context,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      builder:
                                                          (BuildContext bc) {
                                                        return SingleChildScrollView(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Container(
                                                              height: 500,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30.0),
                                                              ),
                                                              child:
                                                                  SingleChildScrollView(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: <
                                                                            Widget>[
                                                                          Container(
                                                                            decoration:
                                                                                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                                                                            child:
                                                                                Image.asset(
                                                                              "assets/m.png",
                                                                              height: 60.0,
                                                                              width: 60.0,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(10.0),
                                                                              child: Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: <Widget>[
                                                                                  Text(
                                                                                    data['Team_Name'],
                                                                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),
                                                                                  ),
                                                                                  Spacer(),
                                                                                  Container(
                                                                                    height: 20,
                                                                                    width: 70,
                                                                                    decoration: BoxDecoration(shape: BoxShape.rectangle, color: Colors.black),
                                                                                    child: Center(
                                                                                      child: Text(
                                                                                        data['stage'],
                                                                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  IconButton(
                                                                                    onPressed: () {
                                                                                      _delete(data.id);
                                                                                    },
                                                                                    icon: Icon(Icons.delete),
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(20.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                Text(
                                                                                  "Project Name",
                                                                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),
                                                                                ),
                                                                                Spacer(),
                                                                                Text(
                                                                                  data['completed_level'].toString(),
                                                                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),
                                                                                ),
                                                                                Text(
                                                                                  '%',
                                                                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),
                                                                                ),
                                                                                Spacer(),
                                                                                IconButton(
                                                                                    onPressed: () {
                                                                                      showDialog<int>(
                                                                                          context: context,
                                                                                          builder: (BuildContext context) {
                                                                                            return AlertDialog(
                                                                                              title: Center(child: Text("Completed Level")),
                                                                                              content: StatefulBuilder(builder: (context, SBsetState) {
                                                                                                return NumberPicker(
                                                                                                    selectedTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                                                                    textStyle: TextStyle(color: Colors.grey),
                                                                                                    value: _currentValue,
                                                                                                    axis: Axis.vertical,
                                                                                                    minValue: 0,
                                                                                                    maxValue: 100,
                                                                                                    itemHeight: 50,
                                                                                                    step: 5,
                                                                                                    decoration: BoxDecoration(
                                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                                      border: Border.all(color: Colors.black),
                                                                                                    ),
                                                                                                    onChanged: (value) {
                                                                                                      setState(() => _currentValue = value); // to change on widget level state
                                                                                                      SBsetState(() => _currentValue = value); //* to change on dialog state
                                                                                                    });
                                                                                              }),
                                                                                              actions: [
                                                                                                Center(
                                                                                                  child: MaterialButton(
                                                                                                    color: Colors.blue[600],
                                                                                                    child: Text(
                                                                                                      "Update",
                                                                                                      style: TextStyle(color: Colors.white),
                                                                                                    ),
                                                                                                    onPressed: () async {
                                                                                                      _currentValue.toString();

                                                                                                      if (_currentValue.toString() != null) {
                                                                                                        await _teams.doc(data.id).update({
                                                                                                          "completed_level": _currentValue.toInt(),
                                                                                                        }).whenComplete(() {
                                                                                                          Navigator.of(context).pop();
                                                                                                          Navigator.of(context).pop();
                                                                                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                                                            content: Text(
                                                                                                              'Successfully Update Your Project',
                                                                                                            ),
                                                                                                          ));
                                                                                                        });
                                                                                                      }
                                                                                                    },
                                                                                                  ),
                                                                                                )
                                                                                              ],
                                                                                            );
                                                                                          });
                                                                                    },
                                                                                    icon: Icon(Icons.incomplete_circle_rounded))
                                                                              ],
                                                                            ),
                                                                            Text(
                                                                              data['Project_Name'],
                                                                              style: TextStyle(color: Colors.black, fontSize: 14.0),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10.0,
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Text(
                                                                                  "Team Members",
                                                                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10.0,
                                                                            ),
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      "1. ",
                                                                                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                                                                                    ),
                                                                                    Text(
                                                                                      data['Leader_Name'],
                                                                                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      "2. ",
                                                                                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                                                                                    ),
                                                                                    Text(
                                                                                      data['Member_1'],
                                                                                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      "3. ",
                                                                                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                                                                                    ),
                                                                                    Text(
                                                                                      data['Member_2'],
                                                                                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 10.0,
                                                                                ),
                                                                                Text(
                                                                                  "Description",
                                                                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),
                                                                                ),
                                                                                SizedBox(height: 5.0),
                                                                                Text(
                                                                                  data['Project_Dis'],
                                                                                  style: TextStyle(color: Colors.black, fontSize: 15.0),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 95.0,
                                                      width: 350.0,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0)),
                                                              child:
                                                                  Image.asset(
                                                                "assets/m.png",
                                                                height: 60.0,
                                                                width: 60.0,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Text(
                                                                          data[
                                                                              'Team_Name'],
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 16.0),
                                                                        ),
                                                                        Spacer(),
                                                                        Text(
                                                                          data['Register_On']
                                                                              .toDate()
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              color: Colors.grey,
                                                                              fontSize: 12.0),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          data[
                                                                              'Project_Name'],
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 14.0),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.0),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  } else {
                                    return Center(child: Loading());
                                  }
                                }),
                          ),
                          Container(
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("teams")
                                    .where("email",
                                        arrayContains:
                                            currentUser.currentUser?.email)
                                    .where("stage", isEqualTo: "Rejected")
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, i) {
                                          var data = snapshot.data!.docs[i];
                                          Timestamp t =
                                              data['Register_On'] as Timestamp;
                                          DateTime date = t.toDate();
                                          return Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                      context: context,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      builder:
                                                          (BuildContext bc) {
                                                        return SingleChildScrollView(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Container(
                                                              height: 500,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30.0),
                                                              ),
                                                              child:
                                                                  SingleChildScrollView(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          15.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: <
                                                                            Widget>[
                                                                          Container(
                                                                            decoration:
                                                                                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                                                                            child:
                                                                                Image.asset(
                                                                              "assets/m.png",
                                                                              height: 60.0,
                                                                              width: 60.0,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(10.0),
                                                                              child: Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: <Widget>[
                                                                                  Text(
                                                                                    data['Team_Name'],
                                                                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),
                                                                                  ),
                                                                                  Spacer(),
                                                                                  Container(
                                                                                    height: 20,
                                                                                    width: 70,
                                                                                    decoration: BoxDecoration(shape: BoxShape.rectangle, color: Colors.black),
                                                                                    child: Center(
                                                                                      child: Text(
                                                                                        data['stage'],
                                                                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  IconButton(
                                                                                    onPressed: () {
                                                                                      _delete(data.id);
                                                                                    },
                                                                                    icon: Icon(Icons.delete),
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(20.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                Text(
                                                                                  "Project Name",
                                                                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),
                                                                                ),
                                                                                Spacer(),
                                                                              ],
                                                                            ),
                                                                            SizedBox(height: 10),
                                                                            Text(
                                                                              data['Project_Name'],
                                                                              style: TextStyle(color: Colors.black, fontSize: 14.0),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10.0,
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Text(
                                                                                  "Team Members",
                                                                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),
                                                                                ),
                                                                                Spacer(),
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10.0,
                                                                            ),
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      "1. ",
                                                                                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                                                                                    ),
                                                                                    Text(
                                                                                      data['Leader_Name'],
                                                                                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      "2. ",
                                                                                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                                                                                    ),
                                                                                    Text(
                                                                                      data['Member_1'],
                                                                                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      "3. ",
                                                                                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                                                                                    ),
                                                                                    Text(
                                                                                      data['Member_2'],
                                                                                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(height: 10.0),
                                                                                Text(
                                                                                  "Description",
                                                                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),
                                                                                ),
                                                                                SizedBox(height: 5.0),
                                                                                Text(
                                                                                  data['Project_Dis'],
                                                                                  style: TextStyle(color: Colors.black, fontSize: 15.0),
                                                                                ),
                                                                                SizedBox(height: 10.0),
                                                                                Text(
                                                                                  "Reason",
                                                                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),
                                                                                ),
                                                                                SizedBox(height: 5.0),
                                                                                Text(
                                                                                  data['reason'],
                                                                                  style: TextStyle(color: Colors.black, fontSize: 15.0),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 95.0,
                                                      width: 350.0,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0)),
                                                              child:
                                                                  Image.asset(
                                                                "assets/m.png",
                                                                height: 60.0,
                                                                width: 60.0,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Text(
                                                                          data[
                                                                              'Team_Name'],
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 16.0),
                                                                        ),
                                                                        Spacer(),
                                                                        Text(
                                                                          data['Register_On']
                                                                              .toDate()
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              color: Colors.grey,
                                                                              fontSize: 12.0),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          data[
                                                                              'Project_Name'],
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 14.0),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.0),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  } else {
                                    return Center(child: Loading());
                                  }
                                }),
                          ),
                        ])),
                  ])),
        ]),
      ),
    );
  }
}
