import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:menpradharshana/controller/checking_auth.dart';
import 'package:menpradharshana/core/viewmodels/home_model.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: checking_auth(),
      ),
    );
  }
}
