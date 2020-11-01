import 'dart:convert';

import 'package:building_materials_app/actualproduct.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductCategoryPage extends StatefulWidget {
  int productCategoryId;
  ProductCategoryPage({Key key, this.productCategoryId}): super(key: key);
  @override
  _ProductCategoryPageState createState() => _ProductCategoryPageState();
}

class _ProductCategoryPageState extends State<ProductCategoryPage> {
  var product=[];
  var series_product=[

  ];

  @override
  void initState() {
    super.initState();
    print(widget.productCategoryId.toString());
    var x=["1",[]];
    series_product.add(x);
    Future<void> product_category_info() async {
      final response = await http.post(
          "http://huzefam.sg-host.com/getProductCategoryInfo.php",
          body: {
            "productCategoryId":widget.productCategoryId.toString(),
          }
      );
      var decodedResponse = json.decode(response.body);
      print(decodedResponse);
      print(decodedResponse['product_info']);

      product=decodedResponse['product_info'];

      for(int i=0;i<product.length;i++) {
        //if(product[i][2]!="0") {
          var flag=false;  //false means series not found
          int j=0;
          for(;j<series_product.length;j++){
            if(series_product[j][0]==product[i][2]){
              flag=true;
              break;
            }
          }

          if(flag==false){
            var temp=[product[i][2],[product[i]]];
            series_product.add(temp);
          }
          else{
            series_product[j][1].add(product[i]);
          }
        }
      //}
      print(series_product);

      setState(() {
      });
    }
    product_category_info();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
              Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          'Single Handle',
        ),
        centerTitle: true,
        actions: [
          Icon(Icons.search),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.shopping_cart),
          ),
          //Icon(Icons.more_vert),
        ],
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: series_product.map((j){
            if(j[1].length!=0) {
              var series_no = j[0];
              var series_list = j[1];
              print(series_no);
              print(series_list);

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
                          height: 205,
                          width: double.infinity,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: series_list.map<Widget>((i){
                              return Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Container(
                                  height: 190,
                                  width: 160,
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
                                          MaterialPageRoute(builder: (context) =>
                                              ActualProductPage(productId: int.parse(i[0]))),
                                        );
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: <Widget>[
                                          Image.network(
                                            'http://huzefam.sg-host.com/'+i[3],
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
                                                    i[1],
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
                              );
                            }).toList(),
                          )
                      ),
                      SizedBox(height: 20,),
                    ],
                  );
                }
                else {
                  return Column(
                    children: series_list.map<Widget>((i){
                      print(i);
                      return FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ActualProductPage(productId: int.parse(i[0]))),
                          );
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Image.network(
                                  'http://huzefam.sg-host.com/'+i[3].toString(),
                                  height: 90,
                                  width: 90,
                                ),
                                //SizedBox(width: 15,),
                                Text(
                                  i[1].toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[800],
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
            }
            else {
              return Container();
            }
          }).toList(),
        ),
      ),
    );
  }
}
