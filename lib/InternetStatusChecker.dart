import 'package:flutter/material.dart';
import 'package:Macoma/enums/connectivity_status.dart';
import 'package:provider/provider.dart';

class NetworkSensitive extends StatelessWidget {
  final Widget child;
  final double opacity;

  NetworkSensitive({
    this.child,
    this.opacity = 0.2,
  });

  @override
  Widget build(BuildContext context) {
    // Get our connection status from the provider
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (connectionStatus == ConnectivityStatus.WiFi || connectionStatus == ConnectivityStatus.Cellular) {
      return child;
    }

    if (connectionStatus == ConnectivityStatus.Offline) {
      print('no net');
      //return Opacity(opacity: opacity, child: child);
      return Scaffold(
          body: Center(
            child:ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20.0),
              children: <Widget>[
                Icon(Icons.signal_wifi_off, size:30.0),
                Text('Whoops! No Internet Connection.',
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.black,
                    ),
                textAlign: TextAlign.center)
              ]
            )
          )
          );
    }

    return Scaffold(
        body: Center(
            child:ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20.0),
                children: <Widget>[
                  Icon(Icons.signal_wifi_off, size:30.0),
                  Text('Whoops! No Internet Connection.',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center)
                ]
            )
        )
    );
  }
}