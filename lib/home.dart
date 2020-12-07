import 'dart:convert';
import 'dart:ui';

import 'package:Macoma/aboutus.dart';
import 'package:Macoma/actualproduct.dart';
import 'package:Macoma/category.dart';
import 'package:Macoma/globalvars.dart';
import 'package:Macoma/searchpage.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';

class HomePage extends StatefulWidget {
  VoidCallback cartbadgecallback;
  HomePage({Key key, this.cartbadgecallback}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List cardList = [
    Category1(),
    Category2(),
    Category3(),
  ];
  List categoryNameList = [
    'Bathroom Fittings',
    'Building Materials',
    'Fasteners'
  ];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  var _stock_loading = true;
  var sale_list = [];

  var _new_arrivals_loading = true;
  var new_arrivals_list = [];

  var _featured_loading = true;
  var featured_list = [];

  var _footer_loading = true;
  var footer_pic;

  @override
  void initState() {
    super.initState();

    Future<void> stock_clearance_info() async {
      final response = await http.post(
        "http://huzefam.sg-host.com/getSaleInfo.php",
      );
      var decodedResponse = json.decode(response.body);
      // print(decodedResponse);
      print(decodedResponse['product_info']);
      // print(decodedResponse['product_info'][0][3]);
      sale_list = decodedResponse['product_info'];

      setState(() {
        _stock_loading = false;
      });
    }

    stock_clearance_info();

    Future<void> new_arrivals_info() async {
      final response = await http.post(
        "http://huzefam.sg-host.com/getNewArrivalsInfo.php",
      );
      var decodedResponse = json.decode(response.body);
      // print(decodedResponse);
      print(decodedResponse['product_info']);
      // print(decodedResponse['product_info'][0][3]);
      new_arrivals_list = decodedResponse['product_info'];

      setState(() {
        _new_arrivals_loading = false;
      });
    }

    new_arrivals_info();

    Future<void> featured_info() async {
      final response = await http.post(
        "http://huzefam.sg-host.com/getFeaturedInfo.php",
      );
      var decodedResponse = json.decode(response.body);
      // print(decodedResponse);
      print(decodedResponse['product_info']);
      // print(decodedResponse['product_info'][0][3]);
      featured_list = decodedResponse['product_info'];

      setState(() {
        _featured_loading = false;
      });
    }

    featured_info();

    Future<void> get_footer_pic() async {
      final response = await http.post(
        "http://huzefam.sg-host.com/getFooterPic.php",
      );
      var decodedResponse = json.decode(response.body);
      // print(decodedResponse);
      print(decodedResponse['image_location']);
      // print(decodedResponse['product_info'][0][3]);
      footer_pic = decodedResponse['image_location'].toString();

      setState(() {
        _footer_loading = false;
      });
    }

    get_footer_pic();
  }

  @override
  Widget build(BuildContext context) {
    final RenderBox box = context.findRenderObject();
    return Scaffold(
      appBar: AppBar(
        //leading: Icon(Icons.menu),
        elevation: 5,
        title: Text(
          'Home',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
          ),
        ),
        //centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: GestureDetector(
              onTap: () {
                FlutterOpenWhatsapp.sendSingleMessage(
                    GlobalVariables.contact_no, "Hey! I'm on your app.");
              },
              child: FaIcon(
                FontAwesomeIcons.whatsapp,
                color: Colors.green,
                size: 22,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                ).then((value) {
                  widget.cartbadgecallback();
                });
              },
              child: Icon(
                Icons.search,
                color: Colors.black87,
                size: 22,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.black87),
      ),
      drawer: Container(
        width: 280,
        child: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Center(
                  child: Text(
                    'AY Building Materials',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.black87,
                ),
              ),
              ListTile(
                title: Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    letterSpacing: 0.7,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ExpansionTile(
                title: Text(
                  'Shop',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    letterSpacing: 0.7,
                  ),
                ),
                children: <Widget>[
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25, bottom: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '> Bathroom Fittings',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryPage(
                                categoryId: 1,
                                categoryName: 'Bathroom Fittings')),
                      ).then((value) {
                        widget.cartbadgecallback();
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25, bottom: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '> Building Materials',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryPage(
                                categoryId: 2,
                                categoryName: 'Building Materials')),
                      ).then((value) {
                        widget.cartbadgecallback();
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25, bottom: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '> Fasteners',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryPage(
                                categoryId: 3, categoryName: 'Fasteners')),
                      ).then((value) {
                        widget.cartbadgecallback();
                      });
                    },
                  ),
                ],
              ),
              ListTile(
                title: Text(
                  'About Us',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    letterSpacing: 0.7,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUsPage()),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Tell a friend',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    letterSpacing: 0.7,
                  ),
                ),
                onTap: () {
                  Share.share(
                      'Checkout this app: https://play.google.com/store/apps/details?id=com.example.building_materials_app',
                      subject: 'Checkout this app',
                      sharePositionOrigin:
                          box.localToGlobal(Offset.zero) & box.size);
                },
              ),
            ],
          ),
        ),
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Text(
                'SHOP BY CATEGORY',
                style: TextStyle(
                  letterSpacing: 0.8,
                  fontSize: 18,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryPage(
                                categoryId: 1,
                                categoryName: 'Bathroom Fittings')),
                      ).then((value) {
                        widget.cartbadgecallback();
                      });
                    },
                    child: Card(
                      //padding: EdgeInsets.all(0),
                      margin: EdgeInsets.zero,
                      elevation: 5,
                      child: SizedBox(
                        height: 180,
                        child: Image.asset(
                          'assets/images/home1.png',
//                      height: 200,
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width * 0.5 - 25,
                        ),
                      ),
                    ),
                  ),
                  //SizedBox(width: 10,),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryPage(
                                categoryId: 2,
                                categoryName: 'Building Materials')),
                      ).then((value) {
                        widget.cartbadgecallback();
                      });
                    },
                    child: Card(
                      margin: EdgeInsets.zero,
                      elevation: 5,
                      child: SizedBox(
                        height: 180,
                        child: Image.asset(
                          'assets/images/home2.png',
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width * 0.5 - 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryPage(
                            categoryId: 3, categoryName: 'Fasteners')),
                  ).then((value) {
                    widget.cartbadgecallback();
                  });
                },
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 5,
                  child: Image.asset(
                    'assets/images/home3.png',
                    width: double.infinity,
                  ),
                ),
              ),
              /*CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: true,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: cardList.map((card){
                  var categoryId = cardList.indexOf(card);
                  var categoryName = categoryNameList[categoryId];
                  return Builder(
                      builder:(BuildContext context){
                        return InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CategoryPage(categoryId: (categoryId+1),categoryName: categoryName)),
                            ).then((value) {
                              widget.cartbadgecallback();
                            });
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.30,
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              //color: Colors.blueAccent,
                              child: card,
                            ),
                          ),
                        );
                      }
                  );
                }).toList(),
              ),*/
              //SizedBox(height:10),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: map<Widget>(cardList, (index, url) {
//                  return Container(
//                    width: 7.0,
//                    height: 7.0,
//                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: _currentIndex == index ? Colors.black87 : Colors.grey,
//                    ),
//                  );
//                }),
//              ),
              SizedBox(
                height: 28,
              ),
              Text(
                'STOCK CLEARANCE SALE',
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 0.8,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 280,
                width: double.infinity,
                child: (_stock_loading == true)
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      )
                    : ListView(
                        scrollDirection: Axis.horizontal,
                        children: sale_list.map<Widget>((i) {
                          var innerprice;
                          var stock_availability;
                          var sale = 0; //0 means no sale(default), 1 means sale
                          var saleprice;
                          var salepercent;
                          print(i);
                          for (int x = 0; x < i[3].length; x++) {
                            // print(i[3][x]);
                            if (GlobalVariables.countryId.toString() ==
                                i[3][x][1]) {
                              innerprice = double.parse(i[3][x][4]);
                              // print("hii");
                              stock_availability = i[3][x][5];
                              if (i[3][x][6].length != 0) {
                                sale = 1;
                                saleprice = double.parse(i[3][x][6][1]);
                                print("saleprice=" + saleprice.toString());
                                salepercent =
                                    (innerprice - saleprice) / innerprice * 100;
                                salepercent =
                                    num.parse(salepercent.toStringAsFixed(0));
                                print(salepercent.toString());
                              }
                            }
                          }
                          return Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Stack(
                              children: [
                                Container(
                                  height: 280,
                                  width: 190,
                                  constraints: BoxConstraints(
                                      minWidth: 100, maxWidth: 200),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: Colors.grey[350],
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: FlatButton(
                                      padding: const EdgeInsets.all(0.0),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ActualProductPage(
                                                      productId:
                                                          int.parse(i[0]))),
                                        ).then((value) {
                                          widget.cartbadgecallback();
                                        });
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 180,
                                            width: double.infinity,
                                            child: Image.network(
                                              'http://huzefam.sg-host.com/' +
                                                  i[2],
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            width: 180,
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    i[1],
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: Row(
                                              children: <Widget>[
                                                (sale == 0)
                                                    ? Expanded(
                                                        child: Text(
                                                          innerprice
                                                                  .toString() +
                                                              " " +
                                                              GlobalVariables
                                                                  .currency,
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      )
                                                    : Row(
                                                        children: [
                                                          (i[4] != "")
                                                              ? Text(
                                                                  saleprice
                                                                          .toString() +
                                                                      " " +
                                                                      GlobalVariables
                                                                          .currency +
                                                                      "/" +
                                                                      i[4] +
                                                                      " ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    // color: Colors.green[600],
                                                                  ),
                                                                )
                                                              : Text(
                                                                  saleprice
                                                                          .toString() +
                                                                      " " +
                                                                      GlobalVariables
                                                                          .currency +
                                                                      " ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    // color: Colors.green[600],
                                                                  ),
                                                                ),
                                                          Text(
                                                            innerprice
                                                                .toString(),
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .green[600],
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              fontSize: 16,
                                                              decorationThickness:
                                                                  1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
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
                                  ),
                                ),
                                (sale == 0)
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: new BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.green[500],
                                          ),
                                          height: 20,
                                          width: 30,
                                          alignment: Alignment.topLeft,
                                          child: Center(
                                            child: Text(
                                              salepercent.toString() + '%',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                (stock_availability == "1")
                                    ? Container()
                                    : Center(
                                        child: Container(
                                          decoration: new BoxDecoration(
                                            color: Colors.red[300]
                                                .withOpacity(0.40),
                                          ),
                                          height: 25,
                                          width: 160,
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Out of Stock',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 16,
                                              letterSpacing: 1.0,
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'NEW ARRIVALS',
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 1.2,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 280,
                width: double.infinity,
                child: (_new_arrivals_loading == true)
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      )
                    : ListView(
                        scrollDirection: Axis.horizontal,
                        children: new_arrivals_list.map<Widget>((i) {
                          var innerprice;
                          var stock_availability;
                          var sale = 0; //0 means no sale(default), 1 means sale
                          var saleprice;
                          var salepercent;
                          print(i);
                          for (int x = 0; x < i[3].length; x++) {
                            // print(i[3][x]);
                            if (GlobalVariables.countryId.toString() ==
                                i[3][x][1]) {
                              innerprice = double.parse(i[3][x][4]);
                              // print("hii");
                              stock_availability = i[3][x][5];
                              if (i[3][x][6].length != 0) {
                                sale = 1;
                                saleprice = double.parse(i[3][x][6][1]);
                                print("saleprice=" + saleprice.toString());
                                salepercent =
                                    (innerprice - saleprice) / innerprice * 100;
                                salepercent =
                                    num.parse(salepercent.toStringAsFixed(0));
                                print(salepercent.toString());
                              }
                            }
                          }
                          return Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Stack(
                              children: [
                                Container(
                                  height: 280,
                                  width: 190,
                                  constraints: BoxConstraints(
                                      minWidth: 100, maxWidth: 200),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: Colors.grey[350],
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: FlatButton(
                                      padding: const EdgeInsets.all(0.0),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ActualProductPage(
                                                      productId:
                                                          int.parse(i[0]))),
                                        ).then((value) {
                                          widget.cartbadgecallback();
                                        });
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 180,
                                            width: double.infinity,
                                            child: Image.network(
                                              'http://huzefam.sg-host.com/' +
                                                  i[2],
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            width: 180,
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    i[1],
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: Row(
                                              children: <Widget>[
                                                (sale == 0)
                                                    ? Expanded(
                                                        child: (i[4] != "")
                                                            ? Text(
                                                                innerprice
                                                                        .toString() +
                                                                    " " +
                                                                    GlobalVariables
                                                                        .currency +
                                                                    "/" +
                                                                    i[4],
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              )
                                                            : Text(
                                                                innerprice
                                                                        .toString() +
                                                                    " " +
                                                                    GlobalVariables
                                                                        .currency,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                      )
                                                    : Row(
                                                        children: [
                                                          (i[4] != "")
                                                              ? Text(
                                                                  saleprice
                                                                          .toString() +
                                                                      " " +
                                                                      GlobalVariables
                                                                          .currency +
                                                                      "/" +
                                                                      i[4] +
                                                                      " ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    // color: Colors.green[600],
                                                                  ),
                                                                )
                                                              : Text(
                                                                  saleprice
                                                                          .toString() +
                                                                      " " +
                                                                      GlobalVariables
                                                                          .currency +
                                                                      " ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    // color: Colors.green[600],
                                                                  ),
                                                                ),
                                                          Text(
                                                            innerprice
                                                                .toString(),
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .green[600],
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              fontSize: 16,
                                                              decorationThickness:
                                                                  1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              // fontWeight: FontWeight.bold,
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
                                  ),
                                ),
                                (sale == 0)
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: new BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.green[500],
                                          ),
                                          height: 20,
                                          width: 30,
                                          alignment: Alignment.topLeft,
                                          child: Center(
                                            child: Text(
                                              salepercent.toString() + '%',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                (stock_availability == "1")
                                    ? Container()
                                    : Center(
                                        child: Container(
                                          decoration: new BoxDecoration(
                                            color: Colors.red[300]
                                                .withOpacity(0.40),
                                          ),
                                          height: 25,
                                          width: 160,
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Out of Stock',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 16,
                                              letterSpacing: 1.0,
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'FEATURED',
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 1.2,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 280,
                width: double.infinity,
                child: (_featured_loading == true)
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      )
                    : ListView(
                        scrollDirection: Axis.horizontal,
                        children: featured_list.map<Widget>((i) {
                          var innerprice;
                          var stock_availability;
                          var sale = 0; //0 means no sale(default), 1 means sale
                          var saleprice;
                          var salepercent;
                          print(i);
                          /*for(int x=0; x<i[3].length;x++){
                      // print(i[3][x]);
                      if(GlobalVariables.countryId.toString()==i[3][x][1]){
                        innerprice=double.parse(i[3][x][4]);
                        // print("hii");
                        stock_availability=i[3][x][5];
                        if(i[3][x][6].length!=0){
                          sale=1;
                          saleprice=double.parse(i[3][x][6][1]);
                          print("saleprice="+saleprice.toString());
                          salepercent=(innerprice-saleprice)/innerprice*100;
                          salepercent = num.parse(salepercent.toStringAsFixed(0));
                          print(salepercent.toString());
                        }
                      }
                    }*/
                          return Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Stack(
                              children: [
                                Container(
                                  height: 280,
                                  width: 190,
                                  constraints: BoxConstraints(
                                      minWidth: 100, maxWidth: 200),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: Colors.grey[350],
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: FlatButton(
                                      padding: const EdgeInsets.all(0.0),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ActualProductPage(
                                                      productId:
                                                          int.parse(i[0]))),
                                        ).then((value) {
                                          widget.cartbadgecallback();
                                        });
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 180,
                                            width: double.infinity,
                                            child: Image.network(
                                              'http://huzefam.sg-host.com/' +
                                                  i[2].toString(),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            width: 180,
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    i[1],
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          /*SizedBox(
                                      width: 150,
                                      child: Row(
                                        children: <Widget>[
                                          (sale==0)?Expanded(
                                            child: Text(
                                              innerprice.toString()+" "+GlobalVariables.currency,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ):Row(
                                            children: [
                                              Text(
                                                saleprice.toString()+" "+GlobalVariables.currency+" ",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,

                                                ),
                                              ),
                                              Text(
                                                innerprice.toString(),
                                                style: TextStyle(
                                                  color: Colors.green[600],
                                                  decoration: TextDecoration.lineThrough,
                                                  fontSize: 16,
                                                  decorationThickness: 1,
                                                  fontWeight: FontWeight.w400,
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ],
                                      ),
                                    ),*/
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                /*(sale==0)?Container():Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.green[500],
                              ),
                              height: 20,
                              width: 30,
                              alignment: Alignment.topLeft,
                              child: Center(
                                child: Text(
                                  salepercent.toString()+'%',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                          (stock_availability=="1")?Container():Center(
                            child: Container(
                              decoration: new BoxDecoration(
                                color: Colors.red[300].withOpacity(0.40),
                              ),
                              height: 25,
                              width: 160,
                              alignment: Alignment.center,
                              child: Text(
                                'Out of Stock',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 16,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),*/
                              ],
                            ),
                          );
                        }).toList(),
                      ),
              ),
              SizedBox(height: 20),
              //Footer
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width * 0.5 - 40,
                child: (_footer_loading == true)
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      )
                    : Image.network(
                        'http://huzefam.sg-host.com/' + footer_pic,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Carousel Categories
class Category1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
//        gradient: LinearGradient(
//            begin: Alignment.topLeft,
//            end: Alignment.bottomRight,
//            stops: [0.3, 1],
//            colors: [Color(0xff5f2c82), Color(0xff49a09d)]
//        ),
        image: DecorationImage(
          image: AssetImage("assets/images/SBF white.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: new BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 0.0, sigmaY: 00.0),
        child: new Container(
          decoration: new BoxDecoration(
            color: Colors.indigo[900].withOpacity(0.30),
          ),
          child: Center(
            child: Text(
              'Bathroom Fittings',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Category2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/BMT white.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: new BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 0.0, sigmaY: 00.0),
        child: new Container(
          decoration: new BoxDecoration(
            color: Colors.indigo[900].withOpacity(0.30),
          ),
          child: Center(
            child: Text(
              'Building Materials',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Category3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/image.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: new BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 0.0, sigmaY: 00.0),
        child: new Container(
          decoration: new BoxDecoration(
            color: Colors.indigo[900].withOpacity(0.30),
          ),
          child: Center(
            child: Text(
              'Fasteners',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
