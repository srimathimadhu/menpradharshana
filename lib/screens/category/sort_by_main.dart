// ignore_for_file: unused_local_variable, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Sort_By_Main extends StatefulWidget {
  const Sort_By_Main({super.key});

  @override
  State<Sort_By_Main> createState() => _Sort_By_MainState();
}

class _Sort_By_MainState extends State<Sort_By_Main> {
  //stage sort
  List<String> stage = ['Selected', 'Rejected', 'Pending'];
  String? selectedStage = 'Selected';
  //year sort
  List<String> year = ['1st', '2nd', '3rd', '4th'];
  String? selectedYear = '1st';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        elevation: 0,
        title: Text("Sort By"),
        centerTitle: true,
      ),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DropdownButton<String>(
              value: selectedStage,
              items: stage
                  .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                      )))
                  .toList(),
              onChanged: (item) => setState(() => selectedStage = item),
            ),
            DropdownButton<String>(
              value: selectedYear,
              items: year
                  .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                      )))
                  .toList(),
              onChanged: (item) => setState(() => selectedYear = item),
            ),
          ],
        ),
        DefaultTabController(
          length: 1,
          initialIndex: 0,
          child: Column(
            children: <Widget>[
              Container(
                child: TabBar(
                  labelColor: Colors.black,
                  indicatorColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dragStartBehavior: DragStartBehavior.down,
                  tabs: [
                    Tab(text: 'Result'),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height /
                    1.4, //height of TabBarView

                child: TabBarView(children: <Widget>[
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("teams")
                          .where("stage", isEqualTo: selectedStage)
                          .where("Year", isEqualTo: selectedYear)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Container(
                                                  height: 500.0,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.0)),
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
                                                                        SizedBox(
                                                                            width:
                                                                                25),
                                                                        Text(
                                                                          data['completed_level']
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.black,
                                                                              fontSize: 14.0),
                                                                        ),
                                                                        Text(
                                                                          '%',
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.black,
                                                                              fontSize: 14.0),
                                                                        ),
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
                                                                      SizedBox(height: 10),
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
                                                        SizedBox(
                                                          height: 20.0,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Team Members",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      18.0),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              data[
                                                                  'Leader_Name'],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      14.0),
                                                            ),
                                                            Text(
                                                              data['Member_1'],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      14.0),
                                                            ),
                                                            Text(
                                                              data['Member_2'],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      14.0),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Text(
                                                          "Description",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18.0),
                                                        ),
                                                        SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        Text(
                                                          data['Project_Dis'],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14.0),
                                                        ),
                                                      ],
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
                                                  BorderRadius.circular(15.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.0)),
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
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Row(
                                                            children: <Widget>[
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
                                                              Text(
                                                                data['Register_On']
                                                                    .toDate()
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        12.0),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 5),
                                                          Text(
                                                            data[
                                                                'Project_Name'],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
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
                          return Text('');
                        }
                      }),
                ]),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
