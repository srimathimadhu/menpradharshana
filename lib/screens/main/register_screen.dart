// ignore_for_file: camel_case_types, unused_field, non_constant_identifier_names, unused_local_variable

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/loading.dart';

class Register_screen extends StatefulWidget {
  @override
  State<Register_screen> createState() => _Register_screenState();
}

class _Register_screenState extends State<Register_screen> {
  final _auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance;
  CollectionReference ref = FirebaseFirestore.instance.collection('teams');
  CollectionReference UserInfo = FirebaseFirestore.instance.collection("Users");
  final TextEditingController team_name = new TextEditingController();
  final TextEditingController project_name = new TextEditingController();
  final TextEditingController project_dis = new TextEditingController();
  final TextEditingController leader_name = new TextEditingController();
  final TextEditingController member_1 = new TextEditingController();
  final TextEditingController member_2 = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController email1 = new TextEditingController();
  final TextEditingController email2 = new TextEditingController();
  final String stage = "Pending";
  final String reason = "Null";
  final int _currentValue = 0;
  final _formkey = GlobalKey<FormState>();
  bool visible = false;
  bool loading = false;

  //year
  List<String> year = ['1st', '2nd', '3rd', '4th'];
  String? selectedYear = '1st';

  // image pick

  File? _image;
  final imagePicker = ImagePicker();
  String? downloadURL;

  Future imagePickerMethod() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        showSnackBar("No file selected", Duration(milliseconds: 400));
      }
    });
  }

  //  adding that download url to firestore
  Future uploadImage() async {
    Reference reff = FirebaseStorage.instance.ref().child("image");
    await reff.putFile(_image!);
    downloadURL = await reff.getDownloadURL();
    print(downloadURL);
  }

  //snackbar error

  showSnackBar(String snakText, Duration d) {
    final snackbar = SnackBar(content: Text(snakText), duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : Scaffold(
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 110.0,
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
                              left: 30.0, right: 30.0, top: 60.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    "Registration",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Form(
                    key: _formkey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          StreamBuilder(
                              stream: UserInfo.where("uid",
                                      isEqualTo: currentUser.currentUser?.uid)
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, i) {
                                        var data = snapshot.data!.docs[i];
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text('Leader Name: '),
                                                Text(
                                                  data['name'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text('Leader Mail ID: '),
                                                Text(
                                                  data['email'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text('Year: '),
                                                Text(
                                                  data['year'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                          ],
                                        );
                                      });
                                } else {
                                  return Text('');
                                }
                              }),

                          Divider(),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text("Project Details: "),
                            ],
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                              validator: (value) {
                                if (value!.length == 0) {
                                  return "Project Name cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                project_name.text = value!;
                              },
                              maxLength: 35,
                              controller: project_name,
                              decoration: InputDecoration(
                                  label: Text('Project Name'),
                                  prefixIcon: Icon(Icons.tips_and_updates),
                                  border: OutlineInputBorder())),
                          SizedBox(height: 15.0),
                          Row(
                            children: [
                              Text("Project Discription: "),
                            ],
                          ),
                          SizedBox(height: 15.0),
                          TextFormField(
                              maxLines: 10,
                              validator: (value) {
                                if (value!.length == 0) {
                                  return "Project Discription cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                project_dis.text = value!;
                              },
                              maxLength: 250,
                              controller: project_dis,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder())),
                          SizedBox(height: 10.0),
                          Divider(),
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              Text("Team Details: "),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                              validator: (value) {
                                if (value!.length == 0) {
                                  return "Team Name cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                team_name.text = value!;
                              },
                              maxLength: 15,
                              controller: team_name,
                              decoration: InputDecoration(
                                  label: Text('Team Name'),
                                  prefixIcon: Icon(Icons.groups),
                                  border: OutlineInputBorder())),
                          SizedBox(height: 10.0),

                          TextFormField(
                              validator: (value) {
                                if (value!.length == 0) {
                                  return "Leader Name cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                leader_name.text = value!;
                              },
                              maxLength: 25,
                              controller: leader_name,
                              decoration: InputDecoration(
                                  label: Text('Leader Name'),
                                  prefixIcon: Icon(Icons.manage_accounts),
                                  border: OutlineInputBorder())),
                          SizedBox(height: 10.0),

                          TextFormField(
                              validator: (value) {
                                if (value!.length == 0) {
                                  return "Member 1 Name cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                member_1.text = value!;
                              },
                              maxLength: 25,
                              controller: member_1,
                              decoration: InputDecoration(
                                  label: Text('Member 1 Name'),
                                  prefixIcon: Icon(Icons.group_add),
                                  border: OutlineInputBorder())),
                          SizedBox(height: 10.0),
                          TextFormField(
                              validator: (value) {
                                if (value!.length == 0) {
                                  return "Memeber 1 Email ID cannot be empty";
                                }
                                if (!RegExp(
                                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                    .hasMatch(value)) {
                                  return ("Please enter a valid email");
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                email1.text = value!;
                              },
                              controller: email1,
                              decoration: InputDecoration(
                                  label: Text('Member 1 Email'),
                                  prefixIcon: Icon(Icons.email),
                                  border: OutlineInputBorder())),
                          SizedBox(height: 10.0),
                          TextFormField(
                              validator: (value) {
                                if (value!.length == 0) {
                                  return "Member 2 Name cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                member_2.text = value!;
                              },
                              maxLength: 25,
                              controller: member_2,
                              decoration: InputDecoration(
                                  label: Text('Member 2 Name'),
                                  prefixIcon: Icon(Icons.group_add),
                                  border: OutlineInputBorder())),
                          SizedBox(height: 10.0),
                          TextFormField(
                              validator: (value) {
                                if (value!.length == 0) {
                                  return "Memeber 2 Email ID cannot be empty";
                                }
                                if (!RegExp(
                                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                    .hasMatch(value)) {
                                  return ("Please enter a valid email");
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                email2.text = value!;
                              },
                              controller: email2,
                              decoration: InputDecoration(
                                  label: Text('Member 2 Email'),
                                  prefixIcon: Icon(Icons.email),
                                  border: OutlineInputBorder())),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Year: "),
                              DropdownButton<String>(
                                value: selectedYear,
                                items: year
                                    .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                        )))
                                    .toList(),
                                onChanged: (item) =>
                                    setState(() => selectedYear = item),
                              ),
                            ],
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     MaterialButton(
                          //         color: Colors.blue[600],
                          //         onPressed: () {
                          //           imagePickerMethod();
                          //         },
                          //         child: Text(
                          //           'Image Select',
                          //           style: TextStyle(color: Colors.white),
                          //         )),
                          //     MaterialButton(
                          //         color: Colors.blue[600],
                          //         onPressed: () {
                          //           uploadImage();
                          //         },
                          //         child: Text(
                          //           'Image Upload',
                          //           style: TextStyle(color: Colors.white),
                          //         )),
                          //   ],
                          // ),
                          SizedBox(height: 10.0),
                          MaterialButton(
                            height: 50.0,
                            minWidth: double.infinity,
                            elevation: 0,
                            color: Colors.blue[600],
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                setState(() => loading = true);
                                ref.add({
                                  'Team_Name': team_name.text,
                                  'Project_Name': project_name.text,
                                  'Project_Dis': project_dis.text,
                                  'Leader_Name': leader_name.text,
                                  'Member_1': member_1.text,
                                  'Member_2': member_2.text,
                                  'uid': currentUser.currentUser!.uid,
                                  'Register_On': FieldValue.serverTimestamp(),
                                  'stage': stage.toString(),
                                  'Year': selectedYear.toString(),
                                  'reason': reason.toString(),
                                  'completed_level': _currentValue.toInt(),
                                  //'ImageURL': downloadURL.toString(),
                                  'email': FieldValue.arrayUnion([
                                    currentUser.currentUser!.email,
                                    email1.text.trim(),
                                    email2.text.trim()
                                  ])
                                }).whenComplete(() {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text("Project Registred"),
                                      content: const Text(
                                          "Your Project Idea was waiting for review"),
                                      actions: <Widget>[
                                        MaterialButton(
                                          color: Colors.blue[600],
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: Text("Done",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                              } else {
                                CircularProgressIndicator();
                              }
                            },
                            child: Text(
                              'Register Now',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      )),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
