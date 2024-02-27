// ignore_for_file: must_be_immutable, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Help_Details extends StatefulWidget {
  DocumentSnapshot docid;
  Help_Details({required this.docid});

  @override
  State<Help_Details> createState() => _Help_DetailsState();
}

class _Help_DetailsState extends State<Help_Details> {
  final _formkey = GlobalKey<FormState>();

  CollectionReference ref = FirebaseFirestore.instance.collection('helps');

  TextEditingController qus = new TextEditingController();

  TextEditingController ans = new TextEditingController();

  final currentUser = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          backgroundColor: Colors.blue[600],
          centerTitle: true,
          elevation: 0,
          title: Text('Answers'),
          actions: [
            IconButton(
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.help),
                                      SizedBox(width: 10),
                                      Text('Your Answer',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text('Answer',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10),
                                  Form(
                                    key: _formkey,
                                    child: TextFormField(
                                        controller: ans,
                                        validator: (value) {
                                          if (value!.length == 0) {
                                            return "Answer cannot be empty";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onSaved: (value) {
                                          ans.text = value!;
                                        },
                                        maxLines: 7,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder())),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
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
                                                                  .blue[600],
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              'Please Wait',
                                                              style: TextStyle(
                                                                  fontSize: 20),
                                                            )
                                                          ],
                                                        ),
                                                      ));

                                              ref
                                                  .doc(widget.docid.id)
                                                  .collection('Answers')
                                                  .add({
                                                'uid': currentUser
                                                    .currentUser!.uid,
                                                'Answered_On': FieldValue
                                                    .serverTimestamp(),
                                                'email': currentUser
                                                    .currentUser!.email,
                                                'ans': ans.text
                                              }).whenComplete(() {
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content: Text(
                                                    'Successfully Publish Your Answer',
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
                icon: Icon(Icons.send))
          ],
        ),
        body: ListView(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("helps")
                    .doc(widget.docid.id)
                    .collection('Answers')
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
                                          color:
                                              Colors.black26.withOpacity(0.05),
                                          offset: Offset(0.0, 6.0),
                                          blurRadius: 10.0,
                                          spreadRadius: 0.10)
                                    ]),
                                child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          data['ans'],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: .4),
                                        ),
                                        SizedBox(height: 2.0),
                                      ],
                                    )),
                              ),
                              SizedBox(height: 10)
                            ],
                          );
                        });
                  } else {
                    return Text('');
                  }
                }),
          ],
        ));
  }
}
