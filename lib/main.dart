import 'dart:async';
import 'dart:io';

import 'package:Macoma/bottomnav.dart';
import 'package:Macoma/getlocation.dart';
import 'package:Macoma/globalvars.dart';
import 'package:connectivity/connectivity.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  ConnectivityResult previous;

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

    // try {
    //   InternetAddress.lookup('google.com').then((result){
    //     if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
    //       // internet conn available
    //       // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
    //       //     imageui(),
    //       // ));
    //     }else{
    //       // no conn
    //       _showdialog();
    //     }
    //   }).catchError((error){
    //     // no conn
    //     _showdialog();
    //   });
    // } on SocketException catch (_){
    //   // no internet
    //   _showdialog();
    // }
    //
    //
    // Connectivity().onConnectivityChanged.listen((ConnectivityResult connresult){
    //   if(connresult == ConnectivityResult.none){
    //
    //   }else if(previous == ConnectivityResult.none){
    //     // internet conn
    //     // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
    //     //     imageui(),
    //     // ));
    //   }
    //
    //   previous = connresult;
    // });

    new Timer(new Duration(milliseconds: 200), () {
      locationCheck();
    });
  }

  // void _showdialog(){
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text('ERROR'),
  //       content: Text("No Internet Detected."),
  //       actions: <Widget>[
  //         FlatButton(
  //           // method to exit application programitacally
  //           onPressed: () => SystemChannels.platform.invokeMethod('Systemnavigator.pop'),
  //           child: Text("Exit"),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
