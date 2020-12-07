import 'dart:async';

import 'package:Macoma/bottomnav.dart';
import 'package:Macoma/getlocation.dart';
import 'package:Macoma/globalvars.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _locationDone = -1;

  Future<void> locationCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _onSeen = (prefs.getBool('_locationDone') ?? false);
    print(_onSeen);
    if (_onSeen) {
      GlobalVariables.countryId = prefs.getInt("countryId");
      GlobalVariables.currency = prefs.getString("currency");
      GlobalVariables.contact_no = prefs.getString("contact_no");
      print(GlobalVariables.countryId);
      print(GlobalVariables.currency);
      print(GlobalVariables.contact_no);
      setState(() {
        _locationDone = 1; //redirect to homepage
      });
      //return 1;
    } else {
      setState(() {
        _locationDone = 0; //redirect to onboarding
      });
      //return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    new Timer(new Duration(milliseconds: 200), () {
      locationCheck();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_locationDone == -1) {
      return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: HomeApp(),
        home: Builder(
          builder: (context) => Scaffold(
              resizeToAvoidBottomPadding: false,
              body: DoubleBackToCloseApp(
                child: Center(
                    child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Colors.red[300]))),
                snackBar: const SnackBar(
                  content: Text('Tap back again to leave'),
                ),
              )),
        ),
      );
    }

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: HomeApp(),
      home: (_locationDone == 0) ? GetLocationPage() : HomeApp(),
    );
  }
}
