import 'dart:convert';
import 'package:covid_tracker/model/country_data.dart';
import 'package:covid_tracker/ui/ipFetch.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Map content;

class CountriesAffected extends StatefulWidget {
  @override
  _CountriesAffectedState createState() => _CountriesAffectedState();
}

class _CountriesAffectedState extends State<CountriesAffected> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blueGrey.shade800,
          title: new Text(
            'Coronavirus Updates',
            style: new TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.blueGrey.shade900,
        body: Container(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Countries Affected: ${content['affectedCountries']}',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: GridViewWidget(),
              ),
            ],
          ),
        ));
  }
}

Future<Map> getData() async {
  String apiUrl = "https://corona.lmao.ninja/v2/all";
  http.Response response = await http.get(apiUrl);
  return json.decode(response.body);
}

String _getFormattedNumber(int number) {
  var _formattedNumber = NumberFormat.compactCurrency(
    decimalDigits: 2,
    symbol:
        '', // if you want to add currency symbol then pass that in this else leave it empty.
  ).format(number);
  return _formattedNumber;
}

class GridViewWidget extends StatefulWidget {
  @override
  _GridViewWidgetState createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38,
                        offset: Offset(22.22, 22.22), //(x,y)
                        blurRadius: 55.0,
                        spreadRadius: 3.5)
                  ]),
              child: GridView.count(
                crossAxisSpacing: 10,
                mainAxisSpacing: 5,
                crossAxisCount: 2,
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: customDecoration(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.asset(
                              'images/alert.png',
                              height: 50,
                              width: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                '${_getFormattedNumber(content['cases'])}',
                                style: TextStyle(
                                    color: Colors.blueAccent, fontSize: 11.2),
                              ),
                            )
                          ],
                        ),
                        ListTile(
                          title: new Text(
                            'Total Cases: ',
                            style:
                            TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(
                              top: 2.0,
                            ),
                            child: new Text(
                              '${NumberFormat.decimalPattern().format(content['cases'])}',
                              style:
                              TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: customDecoration(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.asset(
                              'images/heart.png',
                              height: 50,
                              width: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                '${_getFormattedNumber(content['deaths'])}',
                                style: TextStyle(
                                    color: Colors.redAccent, fontSize: 11.2),
                              ),
                            )
                          ],
                        ),
                        ListTile(
                          title: new Text(
                            'Total Deaths: ',
                            style:
                            TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(
                              top: 2.0,
                            ),
                            child: new Text(
                              '${NumberFormat.decimalPattern().format(content['deaths'])}',
                              style:
                              TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: customDecoration(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.asset(
                              'images/people.png',
                              height: 50,
                              width: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                '${_getFormattedNumber(content['recovered'])}',
                                style: TextStyle(
                                    color: Colors.greenAccent, fontSize: 11.2),
                              ),
                            )
                          ],
                        ),
                        ListTile(
                          title: new Text(
                            'Recovered: ',
                            style:
                            TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(
                              top: 2.0,
                            ),
                            child: new Text(
                              '${NumberFormat.decimalPattern().format(content['recovered'])}',
                              style:
                              TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: customDecoration(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.asset(
                              'images/active.png',
                              height: 50,
                              width: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                '${_getFormattedNumber(content['active'])}',
                                style: TextStyle(
                                    color: Colors.yellowAccent, fontSize: 11.2),
                              ),
                            )
                          ],
                        ),
                        ListTile(
                          title: new Text(
                            'Active Cases: ',
                            style:
                            TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(
                              top: 2.0,
                            ),
                            child: new Text(
                              '${NumberFormat.decimalPattern().format(content['active'])}',
                              style:
                              TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: MaterialButton(
                splashColor: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                elevation: 2,
                padding: const EdgeInsets.all(5),
                color: Colors.deepPurple.shade400,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => FetchLocation()
                  ));
                },
                child: ListTile(
                  leading: Image.asset(
                    'images/location.png',
                    height: 30,
                  ),
                  title: Center(child: Text('Find my Location', style: TextStyle(
                      color: Colors.white
                  ),)),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white)
              ),
              margin: const EdgeInsets.only(top: 8),
              child: MaterialButton(
                splashColor: Colors.blueGrey,
                animationDuration: Duration(seconds: 2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                elevation: 2,
                padding: const EdgeInsets.all(5),
                onPressed: () {
                  Navigator
                      .of(context)
                      .push(new MaterialPageRoute<Map>(builder: (BuildContext context) { //change to Map instead of dynamic for this to work
                    return new Country();
                  }));
                },
                child: ListTile(
                  leading: Image.asset(
                    'images/world.png',
                    height: 30,
                  ),
                  title: Center(child: Text('Search by Location', style: TextStyle(
                      color: Colors.white
                  ),)),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  BoxDecoration customDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade800,
        border: Border.all(color: Colors.blueGrey.shade200),
        boxShadow: [
          BoxShadow(
              color: Colors.black87,
              offset: Offset(3.0, 2.0), //(x,y)
              blurRadius: 10.0,
              spreadRadius: 3.5)
        ]);
  }
}
