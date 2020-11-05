import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class GetLocationPage extends StatefulWidget {
  @override
  _GetLocationPageState createState() => _GetLocationPageState();
}

class _GetLocationPageState extends State<GetLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
//        decoration: BoxDecoration(
//            image: DecorationImage(
//                image: AssetImage("assets/images/location.jpg"),
//                fit: BoxFit.cover
//            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: SpinKitFadingCircle(
                color: Colors.black,
                size: 50.0,
              ),
            ),
            SizedBox(height: 10,),
            Text(
              'Fetching your location',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
//                Image.asset(
//                    'assets/images/tick_1.png',
//                  height: 30,
//                  width: 30,
//                ),
                Text(
                  'Location Obtained',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text(
                'Your location is "India"',
              style: TextStyle(
              fontSize: 25,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            color: Colors.red[300],
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.fromLTRB(25.0, 7.0, 25.0, 7.0),
            splashColor: Colors.red,
            onPressed: () {
            },
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.autorenew,
                ),
                SizedBox(width: 3,),
                Text(
                  "Try Again",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 15,),
          FlatButton(
            color: Colors.green,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.fromLTRB(38.0, 10.0, 38.0, 10.0),
            splashColor: Colors.green[600],
            onPressed: () {
            },
            child: Text(
              "Confirm",
              style: TextStyle(
                fontSize: 18.0,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
