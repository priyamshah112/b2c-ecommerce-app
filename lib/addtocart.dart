import 'package:building_materials_app/globalvars.dart';
import 'package:building_materials_app/home.dart';
import 'package:flutter/material.dart';
class AddToCartPage extends StatefulWidget {
  @override
  _AddToCartPageState createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        leading: Icon(
//          Icons.arrow_back_ios,
//          color: Colors.black87,
//          size: 22,
//        ),
//        title: Text(
//          'Home',
//          style: TextStyle(
//            color: Colors.red[300],
//            fontSize: 18,
//          ),
//        ),
        //centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: new BoxDecoration(color: Colors.grey[100]),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20,20,20,0),
          child: ListView(
            scrollDirection: Axis.vertical,
              children: (GlobalVariables.order_list.length==0)?Center(child: Text("No items in the cart.")):GlobalVariables.order_list.map((i){
                return Card(
                  child: SizedBox(
                    height: 85,
                    child: ListTile(
                      leading: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 60,
                          minHeight: 60,
                          maxWidth: 80,
                          maxHeight: 80,
                        ),
                        child: Image.network(
                            'http://huzefam.sg-host.com/'+i[5],
                            fit: BoxFit.cover,
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              i[4],
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: <Widget>[
                                Text(
                                  i[3].toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  GlobalVariables.currency,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
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
                                    SizedBox(width: 8,),
                                    SizedBox(
                                      width:30,
                                      height:30,
                                      child: FloatingActionButton(
                                        heroTag: "minus",
                                        onPressed: (){
                                          setState(() {
                                            if(GlobalVariables.order_list[i[0]][1]!=0){
                                              GlobalVariables.order_list[i[0]][1]-=1;
                                              GlobalVariables.order_list[i[0]][3]=GlobalVariables.order_list[i[0]][1] * GlobalVariables.order_list[i[0]][2];

                                              if(i[1]==0){
                                                GlobalVariables.order_list.removeWhere((product) => product[0] == i[0]);
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
                                        i[1].toString(),
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
                                            GlobalVariables.order_list[i[0]][1]+=1;
                                            GlobalVariables.order_list[i[0]][3]=GlobalVariables.order_list[i[0]][1] * GlobalVariables.order_list[i[0]][2];
                                            print(GlobalVariables.order_list);
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
                          ],
                        ),
                      ),
                      trailing: Icon(Icons.delete),
                    ),
                  ),
                );

              }).toList(),
          ),
        ),
      ),
      bottomNavigationBar: Card(
        child: SizedBox(
          height: 80,
          child: ListTile(
            leading: Padding(
              padding: EdgeInsets.only(left: 10, top: 10.0),
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
                    '100.00 Rs',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: RaisedButton(
                onPressed: () {},
                color: Colors.green[400],
                textColor: Colors.white,
                child: Text(
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
    );
  }
}

//                SizedBox(height: 15,),
//                RaisedButton(
//                  color: Colors.black87,
//                  textColor: Colors.white,
//                  //disabledColor: Colors.grey,
//                  //disabledTextColor: Colors.black,
//                  padding: EdgeInsets.all(8.0),
//                  splashColor: Colors.blueAccent,
//                  onPressed: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => HomePage()),
//                    );
//                  },
//                  child: Text(
//                    "Continue Shopping",
//                    style: TextStyle(
//                      fontSize: 16.0,
//                    ),
//                  ),
//                )