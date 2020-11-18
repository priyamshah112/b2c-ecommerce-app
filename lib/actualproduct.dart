import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:building_materials_app/addtocart.dart';
import 'package:building_materials_app/globalvars.dart';
import 'package:building_materials_app/image_carousel_dots.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_images/carousel_images.dart';

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
  var sale=0;//0 means no sale(default), 1 means sale
  var saleprice;
  var salepercent;

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
          stock_availability = country_info[i][5];
          if(country_info[i][6].length!=0){
            sale=1;
            saleprice=double.parse(country_info[i][6][1]);
            print("saleprice="+saleprice.toString());
            salepercent=(price-saleprice)/price*100;
            salepercent = num.parse(salepercent.toStringAsFixed(0));
            print("salepercent="+salepercent.toString());
          }
          // stock_availability="0";
          /*if(country_info[i][5]=="0") {
            stock_availability = "Out of stock";
          }
          else{
            stock_availability = "In stock";
          }*/
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
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 22,
            color: Colors.black87,
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
            child: IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddToCartPage(fromHomePage: false,)),
                ).then((value) {
                  setState(() {

                  });
                });
              },
              icon: Badge(
                //position: BadgePosition.topEnd(top: 10, end: 10),
                showBadge: (GlobalVariables.total_cart_items==0)?false:true,
                badgeColor: Colors.red[500],
                badgeContent: Text(
                  GlobalVariables.total_cart_items.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
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
      body: (_loading==true)?Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),),):Padding(
        padding: EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    height: 300,
                    width: 300,
                    child: Carousel(images: images),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return ImageScreen(images: images);
                    }));
                  },
                ),
              ],
            ),
            /*ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 90,
              ),
              child: Container(
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.grey[350],
                  ),
                ),
                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(
                      Icons.share,
                      size: 15,
                      color: Colors.black54,
                    ),
                    SizedBox(width: 8,),
                    Text(
                        'Share',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),*/
            SizedBox(height: 10),
            (stock_availability=="1")?Container():
            Column(
              children: [
                Center(
                  child: Container(
                    decoration: new BoxDecoration(
                      color: Colors.red[300].withOpacity(0.40),
                    ),
                    height: 25,
                    width: double.infinity,
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
                SizedBox(height:15),
              ],
            ),
            (unit=="")?Text(
              product_name,
              style: TextStyle(
                fontSize: 18,
              ),
            ):Text(
              product_name+" ("+unit+")",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 15,),
            (sale==0)?Row(
              children: <Widget>[
                Text(
                  "Price: "+price.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(width: 15),
                Text(
                  currency,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ):Row(
              children: [
                Text(
                  "Price: ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  saleprice.toString()+" "+currency+" ",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[600]
                  ),
                ),
                Text(
                  price.toString()+" "+currency,
                  style: TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                    fontSize: 16,
                    decorationThickness: 2,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            (sale==0)?Container():Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Container(
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.green[500].withOpacity(0.9),
                ),
                alignment: Alignment.topLeft,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      salepercent.toString()+'% Discount',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),
            Container(
              child: Row(
                children: <Widget>[
                  Text(
                    'Quantity:',
                    style: TextStyle(
                      fontSize: 20,
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
                                  GlobalVariables.total_cart_items-=1;
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
                          fontSize: 18,
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
                                GlobalVariables.total_cart_items+=1;//only do this if it is added in the order_list
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
                        color: Colors.grey[600],
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
                        color: Colors.grey[600],
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
                        color: Colors.grey[600],
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
                        color: Colors.grey[600],
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
                        color: Colors.grey[600],
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
                        color: Colors.grey[600],
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
                        color: Colors.grey[600],
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
                        color: Colors.grey[600],
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
                        color: Colors.grey[600],
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
                        color: Colors.grey[600],
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
                        color: Colors.grey[600],
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
                        color: Colors.grey[600],
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
                        color: Colors.grey[600],
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
                  disabledColor: Colors.grey,
                  onPressed: (stock_availability=="0")?null:(_addedToCart==true)?null:() {
                    int addToCart(int productId, int quantity, double price, var product_name, var sale, var oldprice){
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
                        var temp = [productId, quantity, price, quantity*price, product_name, images[0], sale, oldprice];
                        GlobalVariables.order_list.add(temp);
                        _addedToCart=true;
                        return 0;
                      }
                    }
                    int result;
                    print("sale="+sale.toString());
                    if(quantity == 0){
                      quantity=1;
                    }
                    if(sale==0){
                      result=addToCart(widget.productId, quantity, price, product_name, sale, price);
                    }
                    else{
                      result=addToCart(widget.productId, quantity, saleprice, product_name, sale, price);
                    }
                    _addedToCart=true;
                    GlobalVariables.total_cart_items+=quantity;
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
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        'Added to Cart',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
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
                        int addToCart(int productId, int quantity, double price, var product_name, var sale, var oldprice){
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
                            var temp = [productId, quantity, price, quantity*price, product_name, images[0], sale, oldprice];
                            GlobalVariables.order_list.add(temp);
                            _addedToCart=true;
                            GlobalVariables.total_cart_items+=quantity;
                            return 0;
                          }
                        }
                        int result;
                        print("sale="+sale.toString());
                        if(quantity == 0){
                          quantity=1;
                        }
                        if(sale==0){
                          result=addToCart(widget.productId, quantity, price, product_name, sale, price);
                        }
                        else{
                          result=addToCart(widget.productId, quantity, saleprice, product_name, sale, price);
                        }
                        _addedToCart=true;

                        print(GlobalVariables.order_list);
                        print("result="+result.toString());
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddToCartPage(fromHomePage: false,)),
                        ).then((value) {
                          setState(() {

                          });
                        });
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

class ImageScreen extends StatefulWidget {
  var images;
  ImageScreen({Key key, this.images}): super(key: key);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  var templist=[];
  @override
  void initState() {
    super.initState();

    for(int i=0;i<widget.images.length;i++){
      templist.add('http://huzefam.sg-host.com/'+widget.images[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        child: Center(
          child: CarouselImages(
            scaleFactor: 0.6,
            listImages: templist,
            height: 300.0,
            borderRadius: 30.0,
            cachedNetworkImage: true,
            verticalAlignment: Alignment.topCenter,
            onTap: (index){
              print('Tapped on page $index');
            },
          )
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
