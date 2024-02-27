// ignore_for_file: camel_case_types, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:menpradharshana/screens/widgets/loading.dart';

class Admin_Registered_Teams extends StatefulWidget {
  const Admin_Registered_Teams({super.key});

  @override
  State<Admin_Registered_Teams> createState() => _Admin_Registered_TeamsState();
}

class _Admin_Registered_TeamsState extends State<Admin_Registered_Teams> {
  final CollectionReference _teams =
      FirebaseFirestore.instance.collection('teams');
  final TextEditingController reason = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50]!,
      appBar: AppBar(
        title: Text('Registered Teams AD'),
        backgroundColor: Colors.blue[600],
        elevation: 0,
        centerTitle: true,
        actions: [
          SizedBox(width: 10.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder(
                future: _teams
                    .where("stage", isEqualTo: "Pending")
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List myDocCount = snapshot.data!.docs;
                    var totalStudent = myDocCount.length.toString();
                    return Text(
                      totalStudent.toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    );
                  } else {
                    return Text('');
                  }
                },
              ),
              SizedBox(width: 40)
            ],
          )
        ],
      ),
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("teams")
                .where("stage", isEqualTo: "Pending")
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, i) {
                      var data = snapshot.data!.docs[i];
                      Timestamp t = data['Register_On'] as Timestamp;
                      DateTime date = t.toDate();
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (BuildContext bc) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        height: 500,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        child: SingleChildScrollView(
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0)),
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
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  data[
                                                                      'Team_Name'],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16.0),
                                                                ),
                                                                Spacer(),
                                                                IconButton(
                                                                    onPressed:
                                                                        () async {
                                                                      final String
                                                                          selected =
                                                                          "Selected"
                                                                              .toString();

                                                                      // ignore: unnecessary_null_comparison
                                                                      if (selected !=
                                                                          null) {
                                                                        await _teams
                                                                            .doc(data.id)
                                                                            .update({
                                                                          "stage":
                                                                              selected,
                                                                        }).whenComplete(() {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(const SnackBar(
                                                                            content:
                                                                                Text(
                                                                              'Successfully Selected The Project',
                                                                            ),
                                                                          ));
                                                                        });
                                                                      }
                                                                    },
                                                                    icon: Icon(
                                                                        Icons
                                                                            .check_circle,
                                                                        color: Colors
                                                                            .green)),
                                                                IconButton(
                                                                    onPressed:
                                                                        () async {
                                                                      final String
                                                                          selected =
                                                                          "Rejected"
                                                                              .toString();

                                                                      // ignore: unnecessary_null_comparison
                                                                      if (selected !=
                                                                          null) {
                                                                        await _teams
                                                                            .doc(data.id)
                                                                            .update({
                                                                          "stage":
                                                                              selected,
                                                                        }).whenComplete(() {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(const SnackBar(
                                                                            content:
                                                                                Text(
                                                                              'Successfully Rejected The Project',
                                                                            ),
                                                                          ));
                                                                        });
                                                                      }
                                                                    },
                                                                    icon: Icon(
                                                                        Icons
                                                                            .unpublished,
                                                                        color: Colors
                                                                            .red)),
                                                              ],
                                                            ),
                                                            Text(
                                                              data[
                                                                  'Project_Name'],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      14.0),
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.0),
                                                ),
                                                SizedBox(height: 10.0),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      data['Leader_Name'],
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14.0),
                                                    ),
                                                    Text(
                                                      data['Member_1'],
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14.0),
                                                    ),
                                                    Text(
                                                      data['Member_2'],
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14.0),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10.0),
                                                Text(
                                                  "Description",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.0),
                                                ),
                                                SizedBox(height: 5.0),
                                                Text(
                                                  data['Project_Dis'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14.0),
                                                ),
                                                SizedBox(height: 10.0),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Reason",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18.0),
                                                    ),
                                                    Spacer(),
                                                    IconButton(
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      AlertDialog(
                                                                        title: Text(
                                                                            'Reason'),
                                                                        content:
                                                                            Container(
                                                                          height:
                                                                              140,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              TextFormField(controller: reason),
                                                                              SizedBox(height: 10),
                                                                              MaterialButton(
                                                                                color: Colors.blue[600],
                                                                                onPressed: () async {
                                                                                  await _teams.doc(data.id).update({
                                                                                    "reason": reason.text,
                                                                                  }).whenComplete(() {
                                                                                    Navigator.of(context).pop();
                                                                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                                      content: Text(
                                                                                        'Reason Saved',
                                                                                      ),
                                                                                    ));
                                                                                  });
                                                                                },
                                                                                child: Text(
                                                                                  'Save',
                                                                                  style: TextStyle(color: Colors.white),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ));
                                                        },
                                                        icon: Icon(Icons
                                                            .edit_document))
                                                  ],
                                                ),
                                                SizedBox(height: 5.0),
                                                Text(
                                                  data['reason'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14.0),
                                                ),
                                              ],
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
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      data['Team_Name'],
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                SizedBox(height: 5),
                                                Text(
                                                  data['Project_Name'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14.0),
                                                ),
                                                SizedBox(height: 5),
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
                return Loading();
              }
            }),
      ),
    );
  }
}
