import 'dart:convert';

import 'package:Macoma/actualproduct.dart';
import 'package:Macoma/addtocart.dart';
import 'package:Macoma/globalvars.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductCategoryPage extends StatefulWidget {
  int productCategoryId;
  var productCategoryName;
  ProductCategoryPage(
      {Key key, this.productCategoryId, this.productCategoryName})
      : super(key: key);
  @override
  _ProductCategoryPageState createState() => _ProductCategoryPageState();
}

class _ProductCategoryPageState extends State<ProductCategoryPage> {
  var product = [];
  var series_product = [];

  var _loading = true;

  @override
  void initState() {
    super.initState();
    print(widget.productCategoryId.toString());
    var x = ["1", []];
    series_product.add(x);
    Future<void> product_category_info() async {
      final response = await http
          .post("http://huzefam.sg-host.com/getProductCategoryInfo.php", body: {
        "productCategoryId": widget.productCategoryId.toString(),
      });
      var decodedResponse = json.decode(response.body);
      print(decodedResponse);
      print(decodedResponse['product_info']);

      product = decodedResponse['product_info'];

      for (int i = 0; i < product.length; i++) {
        //if(product[i][2]!="0") {
        var flag = false; //false means series not found
        int j = 0;
        for (; j < series_product.length; j++) {
          if (series_product[j][0] == product[i][2]) {
            flag = true;
            break;
          }
        }

        if (flag == false) {
          var temp = [
            product[i][2],
            [product[i]]
          ];
          series_product.add(temp);
        } else {
          series_product[j][1].add(product[i]);
        }
      }
      //}
      // print(series_product);

      setState(() {
        _loading = false;
      });
    }

    product_category_info();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
            size: 22,
          ),
        ),
        title: Text(
          widget.productCategoryName,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black87,
            //letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        actions: [
          // Icon(Icons.search),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddToCartPage(
                            fromHomePage: false,
                          )),
                ).then((value) {
                  setState(() {});
                });
              },
              icon: Badge(
                //position: BadgePosition.topEnd(top: 10, end: 10),
                showBadge:
                    (GlobalVariables.total_cart_items == 0) ? false : true,
                badgeColor: Colors.red[500],
                badgeContent: Text(
                  GlobalVariables.total_cart_items.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.black87,
                  // FontAwesomeIcons.map,
                  size: 25.0,
                ),
              ),
            ),
          ),
          //Icon(Icons.more_vert),
        ],
        backgroundColor: Colors.white,
      ),
      body: (_loading == true)
          ? Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            )
          : Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: series_product.map((j) {
                  if (j[1].length != 0) {
                    var series_no = j[0];
                    var series_list = j[1];
                    // print(series_no);
                    // print(series_list);

                    if (series_no != "0") {
                      return Column(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'SERIES ' + series_no.toString(),
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
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: series_list.map<Widget>((i) {
                                  var innerprice;
                                  var stock_availability;
                                  var sale =
                                      0; //0 means no sale(default), 1 means sale
                                  var saleprice;
                                  var salepercent;
                                  // print(i);
                                  for (int x = 0; x < i[4].length; x++) {
                                    // print(i[4][x][1]);
                                    if (GlobalVariables.countryId.toString() ==
                                        i[4][x][1]) {
                                      innerprice = double.parse(i[4][x][4]);
                                      // print("hii");
                                      stock_availability = i[4][x][5];
                                      if (i[4][x][6].length != 0) {
                                        sale = 1;
                                        saleprice = double.parse(i[4][x][6][1]);
                                        print("saleprice=" +
                                            saleprice.toString());
                                        salepercent = (innerprice - saleprice) /
                                            innerprice *
                                            100;
                                        salepercent = num.parse(
                                            salepercent.toStringAsFixed(0));
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
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            border: Border.all(
                                              color: Colors.grey[350],
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: FlatButton(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ActualProductPage(
                                                              productId:
                                                                  int.parse(
                                                                      i[0]))),
                                                ).then((value) {
                                                  setState(() {});
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
                                                          i[3],
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
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Colors
                                                                  .grey[600],
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
                                                                child:
                                                                    (i[5] != "")
                                                                        ? Text(
                                                                            innerprice.toString() +
                                                                                " " +
                                                                                GlobalVariables.currency +
                                                                                "/" +
                                                                                i[5],
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          )
                                                                        : Text(
                                                                            innerprice.toString() +
                                                                                " " +
                                                                                GlobalVariables.currency,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                              )
                                                            : Row(
                                                                children: [
                                                                  (i[5] != "")
                                                                      ? Text(
                                                                          saleprice.toString() +
                                                                              " " +
                                                                              GlobalVariables.currency +
                                                                              "/" +
                                                                              i[5] +
                                                                              " ",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        )
                                                                      : Text(
                                                                          saleprice.toString() +
                                                                              " " +
                                                                              GlobalVariables.currency +
                                                                              " ",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                  Text(
                                                                    innerprice
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                              .green[
                                                                          600],
                                                                      decoration:
                                                                          TextDecoration
                                                                              .lineThrough,
                                                                      fontSize:
                                                                          16,
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: new BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.green[500],
                                                  ),
                                                  height: 20,
                                                  width: 30,
                                                  alignment: Alignment.topLeft,
                                                  child: Center(
                                                    child: Text(
                                                      salepercent.toString() +
                                                          '%',
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.italic,
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
                              )),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: series_list.map<Widget>((i) {
                          //print(i);
                          var innerprice;
                          var stock_availability;
                          var sale = 0; //0 means no sale(default), 1 means sale
                          var saleprice;
                          var salepercent;
                          // print(i);
                          for (int x = 0; x < i[4].length; x++) {
                            // print(i[4][x][1]);
                            if (GlobalVariables.countryId.toString() ==
                                i[4][x][1]) {
                              innerprice = double.parse(i[4][x][4]);
                              // print("hii");
                              stock_availability = i[4][x][5];
                              if (i[4][x][6].length != 0) {
                                sale = 1;
                                saleprice = double.parse(i[4][x][6][1]);
                                print("saleprice=" + saleprice.toString());
                                salepercent =
                                    (innerprice - saleprice) / innerprice * 100;
                                salepercent =
                                    num.parse(salepercent.toStringAsFixed(0));
                                print("salepercent=" + salepercent.toString());
                              }
                            }
                          }
                          return FlatButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ActualProductPage(
                                        productId: int.parse(i[0]))),
                              ).then((value) {
                                setState(() {});
                              });
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: <Widget>[
                                    Image.network(
                                      'http://huzefam.sg-host.com/' +
                                          i[3].toString(),
                                      height: 130,
                                      width: 130,
                                    ),
                                    //SizedBox(width: 15,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            i[1].toString(),
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          (sale == 0)
                                              ? ((i[5] != "")
                                                  ? Text(
                                                      innerprice.toString() +
                                                          " " +
                                                          GlobalVariables
                                                              .currency +
                                                          "/" +
                                                          i[5],
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  : Text(
                                                      innerprice.toString() +
                                                          " " +
                                                          GlobalVariables
                                                              .currency,
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ))
                                              : Row(
                                                  children: [
                                                    (i[5] != "")
                                                        ? Text(
                                                            saleprice
                                                                    .toString() +
                                                                " " +
                                                                GlobalVariables
                                                                    .currency +
                                                                "/" +
                                                                i[5] +
                                                                " ",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                        .green[
                                                                    600]),
                                                          )
                                                        : Text(
                                                            saleprice
                                                                    .toString() +
                                                                " " +
                                                                GlobalVariables
                                                                    .currency +
                                                                " ",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                        .green[
                                                                    600]),
                                                          ),
                                                    Text(
                                                      innerprice.toString(),
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        fontSize: 16,
                                                        decorationThickness: 2,
                                                        // fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          (sale == 0)
                                              ? Container()
                                              : Container(
                                                  decoration: new BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.green[500],
                                                  ),
                                                  height: 20,
                                                  width: 30,
                                                  alignment: Alignment.topLeft,
                                                  child: Center(
                                                    child: Text(
                                                      salepercent.toString() +
                                                          '%',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                          (stock_availability == "1")
                                              ? Container()
                                              : Center(
                                                  child: Container(
                                                    decoration:
                                                        new BoxDecoration(
                                                      color: Colors.red[300]
                                                          .withOpacity(0.40),
                                                    ),
                                                    height: 25,
                                                    width: double.infinity,
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      'Out of Stock',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontSize: 16,
                                                        letterSpacing: 1.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                  } else {
                    return Container();
                  }
                }).toList(),
              ),
            ),
    );
  }
}
