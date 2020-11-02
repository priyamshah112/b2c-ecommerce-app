import 'dart:convert';

import 'package:building_materials_app/addtocart.dart';
import 'package:building_materials_app/globalvars.dart';
import 'package:building_materials_app/image_carousel_dots.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ActualProductPage extends StatefulWidget {
  int productId;
  ActualProductPage({Key key, this.productId}): super(key: key);
  @override
  _ActualProductPageState createState() => _ActualProductPageState();
}

class _ActualProductPageState extends State<ActualProductPage> {
  var product=[];
  var category_id;
  var category_name;
  var product_category_id;
  var product_category_name;
  var product_number;
  var images=[];
  var product_name;
  var certification;
  var guarantee;
  var accessories;
  var material;
  var surface_treatment;
  var cartridge;
  var casting;
  var water_consumption;
  var available_length;
  var color;
  var specification;
  var unit;
  var product_description;
  var no_of_images;
  var country_info=[];
  var price;
  var stock_availability;
  var currency;

  int quantity = 0;
  var _loading=true;
  var _addedToCart=false;

  @override
  void initState() {
    super.initState();
    print(widget.productId.toString());
    Future<void> product_info() async {
      final response = await http.post(
          "http://huzefam.sg-host.com/getProductInfo.php",
          body: {
            "productId":widget.productId.toString(),
          }
      );
      var decodedResponse = json.decode(response.body);
      print(decodedResponse);
      print(decodedResponse['product_name']);
      category_id=decodedResponse['category_id'];
      category_name=decodedResponse['category_name'];
      product_category_id=decodedResponse['product_category_id'];
      product_category_name=decodedResponse['product_category_name'];
      product_number=decodedResponse['product_number'];
      images=decodedResponse['images'];
      product_name=decodedResponse['product_name'];
      certification=decodedResponse['certification'];
      guarantee=decodedResponse['guarantee'];
      accessories=decodedResponse['accessories'];
      print(accessories);
      material=decodedResponse['material'];
      surface_treatment=decodedResponse['surface_treatment'];
      cartridge=decodedResponse['cartridge'];
      casting=decodedResponse['casting'];
      water_consumption=decodedResponse['water_consumption'];
      available_length=decodedResponse['available_length'];
      color=decodedResponse['color'];
      specification=decodedResponse['specification'];
      unit=decodedResponse['unit'];
      product_description=decodedResponse['product_description'];
      no_of_images=decodedResponse['no_of_images'];
      country_info=decodedResponse['country_info'];
//      price=double.parse(decodedResponse['price']);
//      print(price);
      print(decodedResponse['country_info']);

      for(int i=0;i<country_info.length;i++){
        if(int.parse(country_info[i][1])==GlobalVariables.countryId){
          currency=country_info[i][2];
          price=double.parse(country_info[i][4]);
          if(country_info[i][5]=="0") {
            stock_availability = "Out of stock";
          }
          else{
            stock_availability = "In stock";
          }
        }
      }
      print(price);

      for(int i=0; i<GlobalVariables.order_list.length;i++){
        if(widget.productId==GlobalVariables.order_list[i][0]){
          quantity=GlobalVariables.order_list[i][1];
          _addedToCart=true;
          break;
        }
      }

      //product_category=decodedResponse['product_category'];
      //products_no_category=decodedResponse['products_no_category'];
      setState(() {
        _loading=false;
      });
    }
    product_info();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios,
          ),
        ),
//        title: Text(
//          'Product',
//        ),
        centerTitle: true,
        actions: [
          //Icon(Icons.search),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.shopping_cart),
          ),
          //Icon(Icons.more_vert),
        ],
        backgroundColor: Colors.black,
      ),
      body: (_loading==true)?Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),),):Padding(
        padding: EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 300,
                  width: 300,
                  child: Carousel(images: images),
                ),
              ],
            ),
            Text(
              product_name,
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            SizedBox(height: 5,),
            Row(
              children: <Widget>[
                Text(
                  price.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  currency,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15,),
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
                  SizedBox(width: 8,),
                  SizedBox(
                    width:30,
                    height:30,
                    child: FloatingActionButton(
                      heroTag: "minus",
                      onPressed: (){
                        setState(() {
                          if(quantity!=0){
                            quantity-=1;

                            void quantityChange(int productId, int new_quantity){
                              for(int i=0;i<GlobalVariables.order_list.length;i++) {
                                if (productId == GlobalVariables.order_list[i][0]) {
                                  GlobalVariables.order_list[i][1]=new_quantity;
                                  GlobalVariables.order_list[i][3]=new_quantity * GlobalVariables.order_list[i][2];
                                  break;
                                }
                              }
                            }
                            quantityChange(widget.productId, quantity);
                            if(quantity==0){
                              GlobalVariables.order_list.removeWhere((product) => product[0] == widget.productId);
                              _addedToCart=false;
                            }
                            print(GlobalVariables.order_list);
                          }

//                          if(GlobalVariables.allcartitems[widget.menuitem[0]][0]>0){
//                            GlobalVariables.no_of_cart_items-=1;
//                            GlobalVariables.allcartitems[widget.menuitem[0]][0]-=1;
//                            GlobalVariables.totalcost-=GlobalVariables.allcartitems[widget.menuitem[0]][1];
//                            // CHECK IF CART HAS NO ITEMS AND REMOVE BADGE AND 'PROCEED TO CART' FAB HERE
//                            widget.badgecallback();
//                          }
                        });
                      },
                      elevation: 1,
                      child: Icon(Icons.remove, size: 18),
                      backgroundColor: Colors.red[300],
                      mini: true,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Text(
                      quantity.toString(),
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),
                  ),
                  SizedBox(
                    width:30,
                    height:30,
                    child: FloatingActionButton(
                      heroTag: "plus",
                      onPressed: (){
                        setState(() {
                          quantity+=1;
                          void quantityChange(int productId, int new_quantity){
                            for(int i=0;i<GlobalVariables.order_list.length;i++) {
                              if (productId == GlobalVariables.order_list[i][0]) {
                                GlobalVariables.order_list[i][1]=new_quantity;
                                GlobalVariables.order_list[i][3]=new_quantity * GlobalVariables.order_list[i][2];
                                break;
                              }
                            }
                          }
                          quantityChange(widget.productId, quantity);
//                            GlobalVariables.no_of_cart_items+=1;
//                            GlobalVariables.allcartitems[widget.menuitem[0]][0]+=1;
//                            GlobalVariables.totalcost+=GlobalVariables.allcartitems[widget.menuitem[0]][1];
//                            // SET BADGE AND 'PROCEED TO CART' FAB HERE
//                            widget.badgecallback();
                        });
                      },
                      elevation: 1,
                      child: Icon(Icons.add, size: 20),
                      backgroundColor: Colors.green[300],
                      mini:true,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    ),
                  )
                ],
              )
            ),
            SizedBox(height: 20,),
            (product_description=="")?Container(): Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Product Description Details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      product_description,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            (certification=="")?Container(): Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Certification',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 0,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      certification,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            (guarantee=="")?Container(): Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Guarantee',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      guarantee,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            (material=="")?Container(): Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Accessories',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      accessories,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            (material=="")?Container(): Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Material',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      material,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            (surface_treatment=="")?Container(): Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Surface Treatment',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      surface_treatment,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            (cartridge=="")?Container(): Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Cartridge',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      cartridge,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            (casting=="")?Container(): Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Casting',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      casting,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            (water_consumption=="")?Container(): Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Water Consumption',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      water_consumption,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            (available_length=="")?Container(): Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Available length',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      available_length,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            (color=="")?Container(): Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Color',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      color,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            (specification=="")?Container(): Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Specification',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      specification,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            (unit=="")?Container(): Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Unit',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      unit,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ButtonTheme(
              minWidth: 165,
              child: Hero(
                tag: Text("addtocart"),
                child: RaisedButton(
                  disabledColor: Colors.blueGrey,
                  onPressed: (_addedToCart==true)?null:() {
                    int addToCart(int productId, int quantity, double price, var product_name){
                      bool flag = false;
                      for(int i=0;i<GlobalVariables.order_list.length;i++) {
                        if (productId == GlobalVariables.order_list[i][0]) {
                          flag = true;
                          break;
                        }
                      }
                      if(flag==true){
                        //success
                        return 1;
                      }
                      else{
                        //adding to cart
                        var temp = [productId, quantity, price, quantity*price, product_name, images[0]];
                        GlobalVariables.order_list.add(temp);
                        _addedToCart=true;
                        return 0;
                      }
                    }
                    int result=addToCart(widget.productId, quantity, price, product_name);
                    _addedToCart=true;
                    print(GlobalVariables.order_list);
                    print("result="+result.toString());
                    setState(() {
                    });
                  },
                  color: Colors.green,
                  textColor: Colors.white,
                  child: (_addedToCart==false)?Row(
                      children: <Widget>[
                        Icon(
                          Icons.shopping_cart,
                          size: 20,
                        ),
                        SizedBox(width: 10,),
                        Text(
                            'Add to Cart',
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                  ):Row(
                    children: <Widget>[
                      Icon(
                        Icons.check_circle,
                        size: 20,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        'Added to Cart',
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 10,),
            Row(
              children: <Widget>[
                ButtonTheme(
                  minWidth: 150,
                  child: Hero(
                    tag: Text("buynow"),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddToCartPage()),
                        );
                      },
                      color: Colors.red[300],
                      textColor: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.date_range,
                            size: 20,
                          ),
                          SizedBox(width: 10,),
                          Text(
                              'Buy now',
                            style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
