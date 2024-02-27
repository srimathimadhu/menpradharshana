// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:menpradharshana/screens/help/answers.dart';

class All_Qus extends StatefulWidget {
  const All_Qus({super.key});

  @override
  State<All_Qus> createState() => _All_QusState();
}

class _All_QusState extends State<All_Qus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
          backgroundColor: Colors.blue[600],
          elevation: 0,
          title: Text('All Qus', style: TextStyle(color: Colors.white)),
          centerTitle: true),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("helps").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, i) {
                    var data = snapshot.data!.docs[i];
                    return Column(
                      children: [
                        SizedBox(height: 5),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    Help_Details(docid: snapshot.data!.docs[i]),
                              ),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 15.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26.withOpacity(0.05),
                                      offset: Offset(0.0, 6.0),
                                      blurRadius: 10.0,
                                      spreadRadius: 0.10)
                                ]),
                            child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Container(
                                    //   height: 60,
                                    //   color: Colors.white,
                                    // child: Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment
                                    //           .spaceBetween,
                                    //   children: <Widget>[
                                    //     Row(
                                    //       children: <Widget>[
                                    //         CircleAvatar(
                                    //           backgroundImage:
                                    //               AssetImage(
                                    //                   "assets/m.png"),
                                    //           radius: 22,
                                    //         ),
                                    //         Padding(
                                    //           padding:
                                    //               const EdgeInsets
                                    //                       .only(
                                    //                   left: 8.0),
                                    //           child: Column(
                                    //             crossAxisAlignment:
                                    //                 CrossAxisAlignment
                                    //                     .start,
                                    //             mainAxisAlignment:
                                    //                 MainAxisAlignment
                                    //                     .center,
                                    //             children: <Widget>[
                                    //               Text(
                                    //                 data['title'],
                                    //                 style: TextStyle(
                                    //                     fontSize: 16,
                                    //                     fontWeight:
                                    //                         FontWeight
                                    //                             .bold,
                                    //                     letterSpacing:
                                    //                         .4),
                                    //               ),
                                    //               SizedBox(
                                    //                   height: 2.0),
                                    //               // Text(
                                    //               //   "widget.question.created_at",
                                    //               //   style: TextStyle(color: Colors.grey),
                                    //               // )
                                    //             ],
                                    //           ),
                                    //         )
                                    //       ],
                                    //     ),
                                    // Icon(
                                    //   Icons.bookmark,
                                    //   color: Colors.grey
                                    //       .withOpacity(0.6),
                                    //   size: 26,
                                    // )
                                    //   ],
                                    // ),
                                    // ),
                                    Text(
                                      data['title'],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: .4),
                                    ),
                                    SizedBox(height: 5.0),
                                    Text(
                                      data['dis'],
                                      style: TextStyle(
                                          fontSize: 16, letterSpacing: .4),
                                    ),
                                    SizedBox(height: 2.0),

                                    //   Padding(
                                    //     padding: EdgeInsets.symmetric(
                                    //         vertical: 10.0),
                                    //     child: Row(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.start,
                                    //       children: <Widget>[
                                    //         Row(
                                    //           crossAxisAlignment:
                                    //               CrossAxisAlignment.center,
                                    //           children: <Widget>[
                                    //             Icon(
                                    //               Icons.thumb_up,
                                    //               color: Colors.grey
                                    //                   .withOpacity(0.5),
                                    //               size: 22,
                                    //             ),
                                    //             SizedBox(width: 4.0),
                                    //             Text(
                                    //               "votes",
                                    //               style: TextStyle(
                                    //                 fontSize: 14,
                                    //                 color: Colors.grey
                                    //                     .withOpacity(0.5),
                                    //               ),
                                    //             )
                                    //           ],
                                    //         ),
                                    //         SizedBox(width: 15.0),
                                    //         Row(
                                    //           children: <Widget>[
                                    //             Icon(
                                    //               Icons.remove_red_eye,
                                    //               color: Colors.grey
                                    //                   .withOpacity(0.5),
                                    //               size: 18,
                                    //             ),
                                    //             SizedBox(width: 4.0),
                                    //             Text(
                                    //               "views",
                                    //               style: TextStyle(
                                    //                 fontSize: 14,
                                    //                 color: Colors.grey
                                    //                     .withOpacity(0.5),
                                    //                 fontWeight: FontWeight.w600,
                                    //               ),
                                    //             )
                                    //           ],
                                    //         )
                                    //       ],
                                    //     ),
                                    //   )
                                  ],
                                )),
                          ),
                        ),
                        SizedBox(height: 10)
                      ],
                    );
                  });
            } else {
              return Text('');
            }
          }),
    );
  }
}
