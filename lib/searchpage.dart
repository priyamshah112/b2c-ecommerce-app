import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:Macoma/actualproduct.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var product = [];
  TextEditingController searchController = new TextEditingController();

  ConnectivityResult _previousResult;
  StreamSubscription connectivitySubscription;
  bool dialogshown = false;

  @override
  void initState() {
    super.initState();

    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connresult) {
      print("on change called");
      print(connresult);
      // if (connresult == ConnectivityResult.none) {
      //   dialogshown = true;
      //   print("NO INTERNET");
      checkinternet().then((result) {
        print("result of check internet="+result.toString());
        if (result == false) {
          dialogshown = true;
          showDialog(
            context: context,
            barrierDismissible: false,
            child: AlertDialog(
              title: Text(
                "Error",
              ),
              content: Text(
                "No Data Connection Available.",
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () =>
                  {
                    SystemChannels.platform.invokeMethod(
                        'SystemNavigator.pop'),
                  },
                  child: Text("Exit."),
                ),
              ],
            ),
          );
        }
        else {
          print("YES INTERNET");
          if (dialogshown == true) {
            dialogshown = false;
            Navigator.pop(context);
          }
        }
      });
      // } else if (_previousResult == ConnectivityResult.none) {
      //   checkinternet().then((result) {
      //     if (result == true) {
      //       print("YES INTERNET");
      //       if (dialogshown == true) {
      //         dialogshown = false;
      //         Navigator.pop(context);
      //       }
      //     }
      //   });
      // }

      _previousResult = connresult;
    });
  }

  Future<bool> checkinternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return Future.value(true);
      }
    } on SocketException catch (_) {
      return Future.value(false);
    }
  }

  @override
  void dispose() {
    super.dispose();

    connectivitySubscription.cancel();
  }

  Future<void> search_info() async {
    print(searchController.text);
    final response =
        await http.post("http://huzefam.sg-host.com/searchSys.php", body: {
      "searchString": searchController.text,
    });
    var decodedResponse = json.decode(response.body);
    print(decodedResponse);
    print(decodedResponse['product_info']);

    product = decodedResponse['product_info'];

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 0.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 22,
                  ),
                  color: Colors.black87,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: 7,
                ),
                Container(
                  width: 260,
                  child: TextField(
                    controller: searchController,
                    onChanged: (text) {
                      search_info();
                    },
                    decoration: InputDecoration(
                      //border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: 'Search',
                      contentPadding: EdgeInsets.only(left: 20, top: 2),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          search_info();
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.black87,
                        ),
                      ),
                      hintStyle: TextStyle(
                        fontSize: 17.0,
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Colors.grey[100],
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Colors.grey[100],
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: product.map((i) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ActualProductPage(
                                    productId: int.parse(i[0]))),
                          );
                        },
                        leading: Image.network(
                          'http://huzefam.sg-host.com/' + i[2],
                        ),
                        title: Text(
                          i[1],
                        ),
                        //subtitle: Text("yo"),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
