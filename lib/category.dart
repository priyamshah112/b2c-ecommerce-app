import 'dart:convert';

import 'package:building_materials_app/actualproduct.dart';
import 'package:building_materials_app/bottomnav.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'productcategorypage.dart';
class CategoryPage extends StatefulWidget {
  int categoryId;
  CategoryPage({Key key, this.categoryId}): super(key: key);
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  var product_category=[];
  //var products_no_category=[];

  @override
  void initState() {
    super.initState();
    print(widget.categoryId);

    Future<void> category_info() async {
      final response = await http.post(
          "http://huzefam.sg-host.com/getCategoryInfo.php",
          body: {
            "categoryId":widget.categoryId.toString(),
          }
       );
      var decodedResponse = json.decode(response.body);
      print(decodedResponse);
      print(decodedResponse['product_category']);
      //print(decodedResponse['products_no_category']);

      product_category=decodedResponse['product_category'];
      //products_no_category=decodedResponse['products_no_category'];
      setState(() {

      });
    }
    category_info();
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
          'Category',
          style: TextStyle(
            fontSize: 18,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        actions: [
          Icon(
            Icons.search,
            size: 22,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(
              Icons.shopping_cart,
              size: 22,
            ),
          ),
          //Icon(Icons.more_vert),
        ],
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        child: Container(
          height: 700,
          width: double.infinity,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: product_category.map((i){
              var imagepath="products/0T1YR2.jpg";
              if(i[2]!="no_image"){
                imagepath=i[2].toString();
              }

              return FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: (){
                  if(i[3]==1){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductCategoryPage(productCategoryId: int.parse(i[0]))),
                    );
                  }
                  else{
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ActualProductPage(productId: int.parse(i[0]))),
                    );
                  }
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Image.network(
                          'http://huzefam.sg-host.com/'+imagepath,
                          height: 90,
                          width: 90,
                        ),
                        SizedBox(width: 15,),
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
            }).toList(),
          ),
        ),
      ),
    );
  }
}
