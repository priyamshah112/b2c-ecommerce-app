import 'dart:convert';

import 'package:Macoma/bottomnav.dart';
import 'package:Macoma/globalvars.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetLocationPage extends StatefulWidget {
  @override
  _GetLocationPageState createState() => _GetLocationPageState();
}

class _GetLocationPageState extends State<GetLocationPage> {
  var countryname;
  bool _locationobtained = false;
  bool _confirming = false;
  bool _error = false;

  @override
  void initState() {
    super.initState();

    Future<void> getCountryName() async {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print("position=");
      debugPrint('location: ${position.latitude}');
      final coordinates =
          new Coordinates(position.latitude, position.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      print(first.countryName); // this will return country name
      countryname = first.countryName;
      setState(() {
        _locationobtained = true;
      });
    }

    getCountryName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Container(
//        decoration: BoxDecoration(
//            image: DecorationImage(
//                image: AssetImage("assets/images/location.jpg"),
//                fit: BoxFit.cover
//            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Image.asset(
                    'assets/images/icon.png',
                    width: 150,
                  ),
                ),
                (_locationobtained == true)
                    ? Container()
                    : Container(
                        child: SpinKitFadingCircle(
                          color: Colors.black,
                          size: 50.0,
                        ),
                      ),
                (_locationobtained == true)
                    ? Container()
                    : SizedBox(
                        height: 10,
                      ),
                (_locationobtained == true)
                    ? Container()
                    : Text(
                        'Fetching your location',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                (_locationobtained == true)
                    ? Container()
                    : SizedBox(
                        height: 10,
                      ),
                (_locationobtained == true)
                    ? Container()
                    : Text(
                        'Please switch on the device GPS. This is only required on first start.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                (_locationobtained == true)
                    ? Container()
                    : SizedBox(
                        height: 15,
                      ),
                (_locationobtained == false)
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/tick_1.png',
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Location Obtained',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                (_locationobtained == false)
                    ? Container()
                    : SizedBox(height: 15),
                (_locationobtained == false)
                    ? Container()
                    : Text(
                        'Your location is "' + countryname + '"',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                (_locationobtained == false)
                    ? Container()
                    : SizedBox(height: 15),
                (_locationobtained == false)
                    ? Container()
                    : Text(
                        'You can now switch off the GPS.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                (_locationobtained == true && _error == true)
                    ? Text(
                        'Sorry but you can\'t access this app from this country yet.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.red),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            color: Colors.red[300],
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.fromLTRB(25.0, 7.0, 25.0, 7.0),
            splashColor: Colors.red,
            onPressed: () {
              setState(() {
                _locationobtained = false;
              });
              Future<void> getCountryName() async {
                Position position = await Geolocator()
                    .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                print("position=");
                debugPrint('location: ${position.latitude}');
                final coordinates =
                    new Coordinates(position.latitude, position.longitude);
                var addresses = await Geocoder.local
                    .findAddressesFromCoordinates(coordinates);
                var first = addresses.first;
                print(first.countryName); // this will return country name
                countryname = first.countryName;
                setState(() {
                  _locationobtained = true;
                });
              }

              getCountryName();
            },
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.autorenew,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  "Try Again",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 15,
          ),
          RaisedButton(
            color: Colors.green,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.fromLTRB(38.0, 10.0, 38.0, 10.0),
            splashColor: Colors.green[600],
            onPressed: (_locationobtained == false)
                ? null
                : () {
                    setState(() {
                      _confirming = true;
                    });
                    Future<void> confirmlocation() async {
                      print(countryname);
                      // countryname="United Arab Emirates";
                      final response = await http.post(
                          "http://huzefam.sg-host.com/getCountryInfo.php",
                          body: {
                            "country_name": countryname,
                          });
                      //print(response.body);
                      var decodedResponse = json.decode(response.body);
                      print(decodedResponse);
                      if (decodedResponse['error'] == "wrongcountry") {
                        countryname = "United Arab Emirates";
                      }
                      GlobalVariables.countryId =
                          int.parse(decodedResponse['countryId']);
                      GlobalVariables.currency = decodedResponse['currency'];
                      GlobalVariables.contact_no =
                          decodedResponse['contact_no'];
                      print(GlobalVariables.countryId);
                      print(GlobalVariables.currency);
                      print(GlobalVariables.contact_no);

                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool('_locationDone', true);
                      await prefs.setInt(
                          'countryId', GlobalVariables.countryId);
                      await prefs.setString(
                          'currency', GlobalVariables.currency);
                      await prefs.setString(
                          'contact_no', GlobalVariables.contact_no);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeApp()),
                      );
                      /*}
                else{
                  _error=true;
                }*/

                      setState(() {
                        _confirming = false;
                      });
                    }

                    confirmlocation();
                  },
            child: (_confirming == true)
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.black),
                    ))
                : Text(
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
