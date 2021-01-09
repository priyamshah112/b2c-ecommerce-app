import 'dart:convert';

import 'package:Macoma/actualproduct.dart';
import 'package:Macoma/addtocart.dart';
import 'package:Macoma/globalvars.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'productcategorypage.dart';

class CategoryPage extends StatefulWidget {
  int categoryId;
  var categoryName;
  CategoryPage({Key key, this.categoryId, this.categoryName}) : super(key: key);
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  var product_category = [];
  //var products_no_category=[];
  var _loading = true;

  @override
  void initState() {
    super.initState();
    print(widget.categoryId);

    Future<void> category_info() async {
      final response = await http
          .post("http://huzefam.sg-host.com/getCategoryInfo.php", body: {
        "categoryId": widget.categoryId.toString(),
      });
      var decodedResponse = json.decode(response.body);
      print(decodedResponse);
      print(decodedResponse['product_category']);
      //print(decodedResponse['products_no_category']);

      product_category = decodedResponse['product_category'];
      //products_no_category=decodedResponse['products_no_category'];
      setState(() {
        _loading = false;
      });
    }

    category_info();
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
          widget.categoryName,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black87,
            //letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        actions: [
          /*Icon(
            Icons.search,
            size: 22,
          ),*/
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
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: (product_category.length == 0)
                    ? Center(child: Text("New Products Coming Up Soon!"))
                    : ListView(
                        scrollDirection: Axis.vertical,
                        children: product_category.map((i) {
                          var imagepath = "products/0T1YR2.jpg";
                          if (i[3] != "no_image") {
                            imagepath = i[3].toString();
                          }

                          if (i[2] == 1) {
                            //product category
                            return FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {
                                if (i[2] == 1) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductCategoryPage(
                                                productCategoryId:
                                                    int.parse(i[0]),
                                                productCategoryName:
                                                    i[1].toString())),
                                  ).then((value) {
                                    setState(() {});
                                  });
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ActualProductPage(
                                            productId: int.parse(i[0]))),
                                  ).then((value) {
                                    setState(() {});
                                  });
                                }
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Image.network(
                                        'http://huzefam.sg-host.com/' +
                                            imagepath,
                                        height: 130,
                                        width: 130,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: Text(
                                          i[1].toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            //print(i);
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
                                  print("saleprice=" + saleprice.toString());
                                  salepercent = (innerprice - saleprice) /
                                      innerprice *
                                      100;
                                  salepercent =
                                      num.parse(salepercent.toStringAsFixed(0));
                                  print(
                                      "salepercent=" + salepercent.toString());
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
                                                ? Text(
                                                    innerprice.toString() +
                                                        " " +
                                                        GlobalVariables
                                                            .currency,
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                : Row(
                                                    children: [
                                                      Text(
                                                        innerprice.toString(),
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          fontSize: 16,
                                                          decorationThickness:
                                                              2,
                                                          // fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        " " +
                                                            saleprice
                                                                .toString() +
                                                            " " +
                                                            GlobalVariables
                                                                .currency,
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .green[600]),
                                                      ),
                                                    ],
                                                  ),
                                            (sale == 0)
                                                ? Container()
                                                : Container(
                                                    decoration:
                                                        new BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: Colors.green[500],
                                                    ),
                                                    height: 20,
                                                    width: 30,
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Center(
                                                      child: Text(
                                                        salepercent.toString() +
                                                            '%',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color:
                                                                Colors.white),
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
                                                      alignment:
                                                          Alignment.center,
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
                          }
                        }).toList(),
                      ),
              ),
            ),
    );
  }
}
