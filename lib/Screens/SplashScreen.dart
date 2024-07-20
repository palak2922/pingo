import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pingo/Screens/Dashboard.dart';
import 'package:pingo/Screens/SignIn.dart';
import 'package:provider/provider.dart';

import '../Widgets/custom_loader.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void _checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 3)); // Simulate a delay for splash screen
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NewsFeedScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const Flexible(
            flex: 1,
            child: Text(
              'Welcome To PingoLearn',
              style: TextStyle(
                  fontSize: 24
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Flexible(
            flex: 1,
            child: CustomLoader(
              color: Colors.black,
              size: 100.0,
            ),
          )
        ],
      ),
    );
  }
}


