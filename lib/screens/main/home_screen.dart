// ignore_for_file: camel_case_types, non_constant_identifier_names


import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:menpradharshana/screens/admin/registered_team_ad.dart';
import 'package:menpradharshana/screens/category/rejected.dart';
import 'package:menpradharshana/screens/category/sort_by_main.dart';
import 'package:menpradharshana/screens/help/help.dart';
import 'package:menpradharshana/screens/main/register_screen.dart';
import 'package:menpradharshana/screens/widgets/team_details.dart';
import '../category/selected.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});
  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  final currentUser = FirebaseAuth.instance;
  TextEditingController team_controller = TextEditingController();

  Map? map;
  String text = 'Enter The Code For Get Detail';
  findfUserInFirebase() async {
    if (team_controller.text.trim().isNotEmpty) {
      await FirebaseFirestore.instance
          .collection("teams")
          .where("Team_Name", isEqualTo: team_controller.text.trim())
          .get()
          .then((value) {
        for (var i in value.docs) {
          setState(() {
            map = i.data();
          });
        }
      });
    }
    if (map?['Team_Name'] == team_controller.text.trim()) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => User_Detail(
                    team_name: map?['Team_Name'],
                    project_name: map?['Project_Name'],
                    project_dis: map?['Project_Dis'],
                    leader_name: map?['Leader_Name'],
                    member_1: map?['Member_1'],
                    member_2: map?['Member_2'],
                    stage: map?['stage'],
                  )));
    } else {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'))
          ],
          title: Text('Error'),
          content: Text('No Team Found'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50]!.withOpacity(0.5),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Help_Screen()));
        },
        backgroundColor: Colors.blue[600],
        child: Icon(Icons.live_help),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300.0,
              decoration: BoxDecoration(
                  color: Colors.blue[600],
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0),
                  )),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 70.0),
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Menpradharshana",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "By Information Technology",
                              style: TextStyle(
                                  color: Colors.blue[50], fontSize: 14.0),
                            )
                          ],
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register_screen()));
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Users")
                          .where("uid", isEqualTo: currentUser.currentUser?.uid)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, i) {
                                var data = snapshot.data!.docs[i];
                                return Column(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: <Widget>[
                                            Container(
                                              child: Center(
                                                  child: Text(
                                                data['name'].toUpperCase(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              height: 70.0,
                                              width: 300.0,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                );
                              });
                        } else {
                          return Text('');
                        }
                      }),
                  SizedBox(height: 10)
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "More Options",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "(Teams)",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Selected_Team()));
                      },
                      child: Container(
                        height: 95.0,
                        width: 150.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Selected Teams",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Rejected_Team()));
                      },
                      child: Container(
                        height: 95.0,
                        width: 150.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Rejected Teams",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Sort_By_Main()));
                      },
                      child: Container(
                        height: 95.0,
                        width: 150.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Sort By",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Admin_Registered_Teams()));
                      },
                      child: Container(
                        height: 95.0,
                        width: 150.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Registered Teams",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // SingleChildScrollView(
                //   child: Padding(
                //       padding: const EdgeInsets.only(left: 18, right: 18),
                //       child: Form(
                //         child: TextField(
                //           controller: team_controller,
                //           decoration: InputDecoration(
                //               suffixIcon: IconButton(
                //                   onPressed: () {
                //                     findfUserInFirebase();
                //                   },
                //                   icon: Icon(Icons.search_rounded)),
                //               hintText: 'Team Name',
                //               border: OutlineInputBorder(
                //                   borderRadius: BorderRadius.circular(15))),
                //         ),
                //       )),
                // ),
              ],
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

// details

  void openBottomSheet() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 500.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Image.asset(
                            "assets/m.png",
                            height: 60.0,
                            width: 60.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "Team Name",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                    ),
                                    Spacer(),
                                    // Icon(
                                    //   Icons.delete_outline,
                                    //   color: Colors.blue[700],
                                    // ),
                                    // Icon(
                                    //   Icons.more_vert,
                                    //   color: Colors.blue[700],
                                    // ),
                                  ],
                                ),
                                Text(
                                  "Project Name",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14.0),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      "Team Members",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                    SizedBox(height: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "1. Moni",
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                        Text(
                          "2. Madhu",
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                        Text(
                          "3. Naveen",
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      "Description",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "description",
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                    SizedBox(height: 15.0),
                  ],
                ),
              ),
            ),
          );
        });
  }

// auto generate code
  void main() {
    Generate5digit();
  }

  Generate5digit() {
    var rng = new Random();
    var teamcode = rng.nextInt(900000) + 100000;
    print(teamcode.toInt().toString());
  }
}
