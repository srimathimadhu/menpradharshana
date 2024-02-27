// ignore_for_file: unused_field, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:menpradharshana/screens/help/all_qus.dart';
import 'package:menpradharshana/screens/help/your_action.dart';

class Help_Screen extends StatefulWidget {
  const Help_Screen({super.key});

  @override
  State<Help_Screen> createState() => _Help_ScreenState();
}

class _Help_ScreenState extends State<Help_Screen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController title = new TextEditingController();
  final TextEditingController dis = new TextEditingController();
  final currentUser = FirebaseAuth.instance;
  bool loading = false;
  CollectionReference ref = FirebaseFirestore.instance.collection('helps');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        centerTitle: true,
        elevation: 0,
        title: Text('Help'),
      ),
      backgroundColor: Colors.blue[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Text('If you have any doubts?'),
                    // onTap: () {
                    //   Navigator.push(context,
                    //       MaterialPageRoute(builder: (context) => PostScreen()));
                    // },
                  ),
                  MaterialButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 600,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  key: _formkey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.help),
                                          SizedBox(width: 10),
                                          Text('Ask Help',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Form(
                                        child: Text('Title',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      SizedBox(height: 5),
                                      TextFormField(
                                          controller: title,
                                          validator: (value) {
                                            if (value!.length == 0) {
                                              return "Title cannot be empty";
                                            } else {
                                              return null;
                                            }
                                          },
                                          onSaved: (value) {
                                            title.text = value!;
                                          },
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder())),
                                      SizedBox(height: 10),
                                      Text('Description',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 10),
                                      TextFormField(
                                          controller: dis,
                                          validator: (value) {
                                            if (value!.length == 0) {
                                              return "Description cannot be empty";
                                            } else {
                                              return null;
                                            }
                                          },
                                          onSaved: (value) {
                                            title.text = value!;
                                          },
                                          maxLines: 7,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder())),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          MaterialButton(
                                              color: Colors.blue[600],
                                              child: const Text('Publish',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              onPressed: () {
                                                if (_formkey.currentState!
                                                    .validate()) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                            title: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                CircularProgressIndicator(
                                                                  color: Colors
                                                                          .blue[
                                                                      600],
                                                                ),
                                                                SizedBox(
                                                                    width: 10),
                                                                Text(
                                                                  'Please Wait',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20),
                                                                )
                                                              ],
                                                            ),
                                                          ));
                                                  ref.add({
                                                    'title': title.text,
                                                    'dis': dis.text,
                                                    'uid': currentUser
                                                        .currentUser!.uid,
                                                    'Register_On': FieldValue
                                                        .serverTimestamp(),
                                                    'email': currentUser
                                                        .currentUser!.email,
                                                  }).whenComplete(() {
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                      content: Text(
                                                        'Successfully Publish Your Questions',
                                                      ),
                                                    ));
                                                  });
                                                } else {
                                                  CircularProgressIndicator();
                                                }
                                              }),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    color: Colors.black,
                    child: Text('Ask Help ',
                        style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('View All Qus'),
                  MaterialButton(
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => All_Qus()));
                    },
                    child:
                        Text('All Qus', style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Your Actions'),
                  MaterialButton(
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Your_Actions()));
                    },
                    child: Text('View', style: TextStyle(color: Colors.white)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
