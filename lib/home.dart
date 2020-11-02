import 'dart:ui';
import 'package:building_materials_app/actualproduct.dart';
import 'package:building_materials_app/addtocart.dart';
import 'package:building_materials_app/category.dart';
import 'package:building_materials_app/productcategorypage.dart';
import 'package:building_materials_app/searchpage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex=0;
  List cardList=[
    Category1(),
    Category2(),
    Category3(),
  ];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: Icon(Icons.menu),
        title: Text(
            'Home',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        //centerTitle: true,
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 22,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddToCartPage()),
                );
              },
              child: Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
          //Icon(Icons.more_vert),
        ],
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20,20,20,0),
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
            SizedBox(height:20),
            CarouselSlider(
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
                return Builder(
                    builder:(BuildContext context){
                      return InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CategoryPage(categoryId: (categoryId+1))),
                          );
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.30,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            color: Colors.blueAccent,
                            child: card,
                          ),
                        ),
                      );
                    }
                );
              }).toList(),
            ),
            SizedBox(height:10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(cardList, (index, url) {
                return Container(
                  width: 7.0,
                  height: 7.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index ? Colors.black87 : Colors.grey,
                  ),
                );
              }),
            ),
            SizedBox(height: 18,),
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
              height: 205,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    height: 190,
                    width: 160,
                    constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
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
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ActualProductPage()),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/6061102/1.jpg',
                              height: 100,
                              width: 100,
                            ),
                            SizedBox(height: 5,),
                            SizedBox(
                              width: 180,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                        'Shovel Pointed Popular Handle -S503L (price per dozen)',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5,),
                            SizedBox(
                              width: 150,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                        '85.00/doz',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
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
                  ),
                  SizedBox(width: 20,),
                ],
              ),
            ),
            SizedBox(height: 25,),
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
              height: 205,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 200,
                        width: 160,
                        constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Colors.grey[350],
                          ),
                         // color: Colors.grey[200].withOpacity(0.40),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: FlatButton(
                            padding: const EdgeInsets.all(0.0),
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ActualProductPage()),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/6061102/1.jpg',
                                  height: 100,
                                  width: 100,
                                ),
                                SizedBox(height: 5,),
                                SizedBox(
                                  width: 180,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          'Shovel Pointed Popular Handle -S503L (price per dozen)',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey[600],
                                            //fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5,),
                                SizedBox(
                                  width: 150,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          '85.00/doz',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
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
                      ),
                      Center(
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
                      ),
                    ],
                  ),
                  SizedBox(width: 20,),
                ],
              ),
            ),
          ],
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
