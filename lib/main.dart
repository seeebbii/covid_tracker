import 'dart:async';

import 'package:covid_tracker/ui/all_countries.dart';
import 'package:flutter/material.dart';
import 'ui/all_countries.dart' as countries;
import 'ui/ipFetch.dart' as ipFetch;
import 'package:http/http.dart' as http;

void main() async {
  String ipUrl = 'https://ident.me/';
  http.Response ip = await http.get(ipUrl);
  ipFetch.YOUR_IP_ADDRESS = ip.body;
  countries.content = await countries.getData();
  runApp(
      new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      )
  );
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () =>_moveToHomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade900
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                child: Image.asset('images/covidlogo.png', height: 100,),
                margin: const EdgeInsets.only(top: 125),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: Text(
                  "COVID-19 Tracker",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32.5
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                ),
                Container(
                  child: Text(
                    "Getting latest updates from server...",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.5
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 100.25),
            alignment: Alignment.bottomCenter,
            child: Text(
              "COVID-19 Worldwide Updates",
              style: new TextStyle(
                fontSize: 20.0,
                color: Colors.white
              ),
            ),
          )
        ],
      ),
    );
  }

  _moveToHomePage() {
    Route route = MaterialPageRoute(builder: (context) => CountriesAffected());
    Navigator.pushReplacement(context, route);
  }
}
