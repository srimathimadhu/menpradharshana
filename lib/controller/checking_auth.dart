// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:menpradharshana/controller/login_page.dart';
import 'package:menpradharshana/screens/main/main_screen.dart';

class checking_auth extends StatefulWidget {
  const checking_auth({Key? key}) : super(key: key);

  @override
  State<checking_auth> createState() => _checking_authState();
}

class _checking_authState extends State<checking_auth> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Main_Screen();
            } else {
              return LoginPage();
            }
          }),
    );
  }
}
