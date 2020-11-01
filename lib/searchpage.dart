import 'package:flutter/material.dart';
class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 60.0, 10.0, 0.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios,
                    size: 22,
                  ),
                  color: Colors.black87,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 7,),
                Container(
                  width: 260,
                  child: TextField(
                    //controller: myController,
//                onChanged: (text) {
//                  print("Text $text");
//                },
                    decoration: InputDecoration(
                      //border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: 'Search',
                      contentPadding: EdgeInsets.only(left: 20, top: 2),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.black87,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 17.0,
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Colors.grey[100],
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Colors.grey[100],
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                height: 600,
                child: ListView(
                  scrollDirection: Axis.vertical,
                    children: <Widget>[
                      ListTile(
//                        leading: Icon(
//                          Icons.location_on,
//                        ),
                        title: Text('Blue Water Stopper Plug(Price per 100pc'),
                        subtitle: Text("yo"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
