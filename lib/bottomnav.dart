import 'package:building_materials_app/addtocart.dart';
import 'package:building_materials_app/home.dart';
import 'package:flutter/material.dart';

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {

  int _currentindex=0;

  Widget callpage(int currentIndex){
    switch(currentIndex){
      case 0: return HomePage();
      case 1: return AddToCartPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: callpage(_currentindex),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 10,
          currentIndex: _currentindex,
          //unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.black87,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 25.0,
                // color: Colors.tealAccent[700],
              ),
              // title: SizedBox.shrink(),
              title: Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                // FontAwesomeIcons.map,
                size: 25.0,
              ),
              // title: SizedBox.shrink(),
              title: Text("Cart"),
            ),
          ],
          onTap: (index){
            setState(() {
              _currentindex=index;
            });
          }
      ),
    );
  }
}
