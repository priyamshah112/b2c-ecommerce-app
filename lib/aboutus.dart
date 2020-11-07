import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:url_launcher/url_launcher.dart';
class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
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
        title: Text(
          'About Us',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0,25.0,20.0,0.0),
        child: ListView(
          children: <Widget>[
            Container(
              child: Text(
                'Registered Brands',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(
                  'assets/images/musutang.png',
                  width: MediaQuery.of(context).size.width*0.43,
                ),
                Image.asset(
                  'assets/images/catalonia.png',
                  width: MediaQuery.of(context).size.width*0.43,
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(
                  'assets/images/siena.png',
                  width: MediaQuery.of(context).size.width*0.43,
                ),
                Image.asset(
                  'assets/images/macoma.png',
                  width: MediaQuery.of(context).size.width*0.43,
                ),
              ],
            ),
            SizedBox(height: 25,),
            Text(
              'Company Profile',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20,),
            Container(
              child: Text('AsgarAli Yousuf Trading Co. (AY Building Materials) is the UAE subsidiary of Macoma Group. The company has a well-established presence in the region and has now overseen three generations in business with a proven track record for excellent customer satisfaction. Our aim is to distribute the highest quality of Sanitaryware, Building Materials, and Fastener products at the lowest price.',
                style: TextStyle(
                fontSize: 14,
                ),
              ),
            ),
            SizedBox(height: 25),
            Container(
              child: Text(
               'In line with our company\'s vision, our goal through this E-Commerce platform is to ease the wholesale shopping experience for our customers by enabling you to choose and create LPO from the array of products listed on the platform that are updated regulary.',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(height: 25),
            Container(
              child: Row(
                children: [
                  Text('Know more about us at:'),
                  GestureDetector(
                    onTap: (){
                      _launchURL() async {
                        const url = 'http://www.macoma.co';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      }
                      _launchURL();
                    },
                    child: Text(
                      " www.macoma.co",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        //decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25,),
            Text(
              'Contact Us',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                FlutterOpenWhatsapp.sendSingleMessage("971508993201", "Hello team AY building Materials");
              },
              child: Row(
                children: <Widget>[
                  Image.asset(
                      'assets/images/whatsapplogo.png',
                    height: 30,
                    width: 30,
                  ),
                  SizedBox(width: 6,),
                  Text(
                      'Whatsapp',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: () => launch("tel://971508993201"),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'assets/images/call.png',
                    height: 30,
                    width: 30,
                  ),
                  SizedBox(width: 6,),
                  Text(
                    'Call',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
