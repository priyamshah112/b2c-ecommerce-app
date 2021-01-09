import 'dart:convert';

import 'package:Macoma/globalvars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:http/http.dart' as http;

class AddToCartPage extends StatefulWidget {
  VoidCallback cartbadgecallback;
  VoidCallback backtohomecallback;
  bool fromHomePage;
  AddToCartPage(
      {Key key,
      this.cartbadgecallback,
      this.backtohomecallback,
      this.fromHomePage})
      : super(key: key);

  @override
  _AddToCartPageState createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
  var _loading = true;
  double total_price = 0;
  var _checkingout = false;
  var _checkoutConfirm = false;

  @override
  void initState() {
    super.initState();
    void calculate_total() {
      for (int i = 0; i < GlobalVariables.order_list.length; i++) {
        total_price += GlobalVariables.order_list[i][3];
      }
      print(total_price);

      //product_category=decodedResponse['product_category'];
      //products_no_category=decodedResponse['products_no_category'];
      setState(() {
        _loading = false;
      });
    }

    calculate_total();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: widget.fromHomePage == false
          ? null
          : () {
              widget.backtohomecallback();
            },
      child: Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          leading: widget.fromHomePage == false
              ? IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 22,
                  ),
                  color: Colors.black87,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              : IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 22,
                  ),
                  color: Colors.black87,
                  onPressed: () {
                    widget.backtohomecallback();
                  },
                ),
          title: Text(
            'Shopping Cart',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: (GlobalVariables.order_list.length == 0)
            ? Center(
                child: Text(
                "No items in the cart.",
                style: TextStyle(fontSize: 17),
              ))
            : Container(
                decoration: new BoxDecoration(color: Colors.grey[100]),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: GlobalVariables.order_list.length,
                          itemBuilder: (BuildContext context, int index) {
                            var i = GlobalVariables.order_list[index];
                            print("sale=" + i[6].toString());
                            print("oldprice=" + i[7].toString());
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: ListTile(
                                    leading: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minWidth: 60,
                                        minHeight: 60,
                                        maxWidth: 80,
                                        maxHeight: 80,
                                      ),
                                      child: Image.network(
                                        'http://huzefam.sg-host.com/' + i[5],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    title: Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            i[4],
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          (i[6] == 0)
                                              ? Row(
                                                  children: <Widget>[
                                                    Text(
                                                      i[3].toString(),
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      GlobalVariables.currency,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Row(
                                                  children: [
                                                    Text(
                                                      i[3].toString() +
                                                          " " +
                                                          GlobalVariables
                                                              .currency +
                                                          " ",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .green[600]),
                                                    ),
                                                    Text(
                                                      i[7].toString() +
                                                          " " +
                                                          GlobalVariables
                                                              .currency,
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
                                          Container(
                                              child: Row(
                                            children: <Widget>[
                                              Text(
                                                'Quantity:',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              SizedBox(
                                                width: 25,
                                                height: 25,
                                                child: FloatingActionButton(
                                                  heroTag:
                                                      "minus" + i[0].toString(),
                                                  onPressed: () {
                                                    setState(() {
                                                      var index =
                                                          GlobalVariables
                                                              .order_list
                                                              .indexOf(i);
                                                      if (GlobalVariables
                                                                  .order_list[
                                                              index][1] !=
                                                          0) {
                                                        GlobalVariables
                                                                .order_list[
                                                            index][1] -= 1;
                                                        GlobalVariables
                                                            .total_cart_items -= 1;
                                                        if (widget
                                                                .fromHomePage ==
                                                            true) {
                                                          widget
                                                              .cartbadgecallback();
                                                        }
                                                        total_price -=
                                                            GlobalVariables
                                                                    .order_list[
                                                                index][3];
                                                        GlobalVariables
                                                                    .order_list[
                                                                index][
                                                            3] = GlobalVariables
                                                                    .order_list[
                                                                index][1] *
                                                            GlobalVariables
                                                                    .order_list[
                                                                index][2];
                                                        total_price +=
                                                            GlobalVariables
                                                                    .order_list[
                                                                index][3];
                                                        if (i[1] == 0) {
                                                          GlobalVariables
                                                              .order_list
                                                              .removeWhere(
                                                                  (product) =>
                                                                      product[
                                                                          0] ==
                                                                      i[0]);
                                                        }
                                                        print(GlobalVariables
                                                            .order_list);
                                                      }
                                                    });
                                                  },
                                                  elevation: 1,
                                                  child: Icon(Icons.remove,
                                                      size: 18),
                                                  backgroundColor:
                                                      Colors.red[300],
                                                  mini: true,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0))),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 0, 5, 0),
                                                child: Text(
                                                  i[1].toString(),
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 25,
                                                height: 25,
                                                child: FloatingActionButton(
                                                  heroTag:
                                                      "plus" + i[0].toString(),
                                                  onPressed: () {
                                                    setState(() {
                                                      var index =
                                                          GlobalVariables
                                                              .order_list
                                                              .indexOf(i);
                                                      GlobalVariables
                                                              .order_list[index]
                                                          [1] += 1;
                                                      GlobalVariables
                                                          .total_cart_items += 1;
                                                      if (widget.fromHomePage ==
                                                          true) {
                                                        widget
                                                            .cartbadgecallback();
                                                      }
                                                      total_price -=
                                                          GlobalVariables
                                                                  .order_list[
                                                              index][3];
                                                      GlobalVariables
                                                              .order_list[index]
                                                          [3] = GlobalVariables
                                                                  .order_list[
                                                              index][1] *
                                                          GlobalVariables
                                                                  .order_list[
                                                              index][2];
                                                      total_price +=
                                                          GlobalVariables
                                                                  .order_list[
                                                              index][3];
                                                      print(GlobalVariables
                                                          .order_list);
                                                    });
                                                  },
                                                  elevation: 1,
                                                  child:
                                                      Icon(Icons.add, size: 20),
                                                  backgroundColor:
                                                      Colors.green[300],
                                                  mini: true,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0))),
                                                ),
                                              )
                                            ],
                                          )),
                                        ],
                                      ),
                                    ),
                                    trailing: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          var index = GlobalVariables.order_list
                                              .indexOf(i);
                                          GlobalVariables.total_cart_items -=
                                              GlobalVariables.order_list[index]
                                                  [1];
                                          if (widget.fromHomePage == true) {
                                            widget.cartbadgecallback();
                                          }
                                          total_price -= GlobalVariables
                                              .order_list[index][3];
                                          GlobalVariables.order_list
                                              .removeWhere((product) =>
                                                  product[0] == i[0]);
                                          print(GlobalVariables.order_list);
                                        });
                                      },
                                      child: Icon(
                                        Icons.delete,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      RaisedButton(
                        color: Colors.black87,
                        textColor: Colors.white,
                        //disabledColor: Colors.grey,
                        //disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.grey,
                        onPressed: () {
                          if (widget.fromHomePage == false) {
                            Navigator.popUntil(
                                context,
                                ModalRoute.withName(
                                    Navigator.defaultRouteName));
                          } else {
                            widget.backtohomecallback();
                          }
                        },
                        child: Text(
                          "Continue Shopping",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
        bottomNavigationBar: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              /*leading: Padding(
                padding: EdgeInsets.only(left: 0, top: 10.0),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Total Price',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      total_price.toString()+" "+GlobalVariables.currency,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),*/
              title: Padding(
                padding: const EdgeInsets.only(left: 0, top: 0.0),
                child: Text(
                  'Total Price',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  total_price.toString() + " " + GlobalVariables.currency,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: RaisedButton(
                  onPressed: (GlobalVariables.order_list.length == 0)
                      ? null
                      : () async {
                          Future<void> addOrder() async {
                            var order_products = [];
                            for (int x = 0;
                                x < GlobalVariables.order_list.length;
                                x++) {
                              var this_product = [];
                              this_product
                                  .add(GlobalVariables.order_list[x][0]);
                              this_product
                                  .add(GlobalVariables.order_list[x][1]);
                              this_product
                                  .add(GlobalVariables.order_list[x][2]);
                              order_products.add(this_product);
                            }

                            var data = [
                              GlobalVariables.countryId,
                              total_price,
                              order_products
                            ];
                            final response = await http.post(
                                "http://huzefam.sg-host.com/addOrder.php",
                                body: {
                                  "data": json.encode(data),
                                });
                            //print(response.body);
                            var decodedResponse = json.decode(response.body);
                            print(decodedResponse);
                            if (decodedResponse != "problem") {
                              print("inside");
                              var whatsapp_msg = "";
                              for (int x = 0;
                                  x < GlobalVariables.order_list.length;
                                  x++) {
                                whatsapp_msg = whatsapp_msg +
                                    (x + 1).toString() +
                                    ". " +
                                    GlobalVariables.order_list[x][4]
                                        .toString() +
                                    "(" +
                                    decodedResponse[x].toString() +
                                    "): quantity=" +
                                    GlobalVariables.order_list[x][1]
                                        .toString() +
                                    " price/item=" +
                                    GlobalVariables.order_list[x][2]
                                        .toString() +
                                    GlobalVariables.currency +
                                    " total=" +
                                    GlobalVariables.order_list[x][3]
                                        .toString() +
                                    GlobalVariables.currency +
                                    "\n";
                              }
                              whatsapp_msg = whatsapp_msg +
                                  "\nTOTAL= " +
                                  total_price.toString() +
                                  " " +
                                  GlobalVariables.currency;
                              print(whatsapp_msg);
                              setState(() {
                                //reseting all variables
                                GlobalVariables.order_list.clear();
                                GlobalVariables.total_cart_items = 0;
                                total_price = 0;
                                if (widget.fromHomePage == true) {
                                  widget.cartbadgecallback();
                                }
                                _checkingout = false;
                              });
                              print(GlobalVariables.order_list.length);

                              FlutterOpenWhatsapp.sendSingleMessage(
                                  GlobalVariables.contact_no, whatsapp_msg);
                            }
                          }

                          bool reply = await showDialog(
                            context: this.context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return AlertDialog(
                                title: new Center(
                                  child: Text("Checkout"),
                                ),
                                content: new Text(
                                    "Would you like to place your order?"),
                                actions: <Widget>[
                                  // usually buttons at the bottom of the dialog
                                  new FlatButton(
                                    child: new Text("Cancel"),
                                    onPressed: () {
                                      _checkoutConfirm = false;
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  new FlatButton(
                                    child: new Text("Confirm"),
                                    onPressed: () {
                                      _checkoutConfirm = true;
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                          print(_checkoutConfirm);
                          if (_checkoutConfirm == true) {
                            print("inside");
                            setState(() {
                              _checkingout = true;
                            });
                            addOrder();
                          }
                          _checkoutConfirm = false;
                        },
                  color: Colors.green[400],
                  textColor: Colors.white,
                  child: (_checkingout == true)
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.black),
                          ))
                      : Text(
                          'Checkout',
                          style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 0.5,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
