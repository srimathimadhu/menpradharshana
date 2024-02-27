// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:menpradharshana/screens/widgets/loading.dart';

class My_Qus extends StatefulWidget {
  const My_Qus({super.key});

  @override
  State<My_Qus> createState() => _My_QusState();
}

class _My_QusState extends State<My_Qus> {
  final currentUser = FirebaseAuth.instance;
  final CollectionReference _qus =
      FirebaseFirestore.instance.collection('helps');

//delete
  Future<void> _delete(String docid) async {
    await _qus.doc(docid).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully deleted Your Qus')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("helps")
              .where("uid", isEqualTo: currentUser.currentUser!.uid)
              .snapshots(),
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
                        Container(
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
                                  SizedBox(height: 5.0),
                                  IconButton(
                                      onPressed: () {
                                        _delete(data.id);
                                      },
                                      icon: Icon(Icons.delete_rounded))

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
                        SizedBox(height: 10)
                      ],
                    );
                  });
            } else {
              return Loading();
            }
          }),
    );
  }
}
