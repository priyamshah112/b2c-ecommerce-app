import 'package:Macoma/addtocart.dart';
import 'package:Macoma/globalvars.dart';
import 'package:Macoma/home.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  int _currentindex = 0;

  Widget callpage(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return HomePage(
          cartbadgecallback: () {
            setState(() {});
          },
        );
      case 1:
        return AddToCartPage(
          cartbadgecallback: () {
            setState(() {});
          },
          backtohomecallback: () {
            setState(() {
              _currentindex = 0;
            });
          },
          fromHomePage: true,
        );
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
                  // FontAwesomeIcons.map,
                  size: 25.0,
                ),
              ),
              // title: SizedBox.shrink(),
              title: Text("Cart"),
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentindex = index;
            });
          }),
    );
  }
}
