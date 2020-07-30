import 'package:covid_tracker/model/CountryModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailedCountry extends StatelessWidget {
  final CountryModel country;

  DetailedCountry({this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: new AppBar(
        title: new Text(country.country),
        backgroundColor: Colors.blueGrey.shade800,
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.network(
              country.countryFlagUrl,
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey.shade900,
                  border: Border.all(color: Colors.blueGrey.shade200),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black87,
                        offset: Offset(3.0, 2.0), //(x,y)
                        blurRadius: 10.0,
                        spreadRadius: 3.5)
                  ]
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Center(
                      child: new Text(
                        'Total Cases: ${NumberFormat.decimalPattern().format(country.cases)}',
                        style: customTextStyle(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.1,
                  ),
                  ListTile(
                    title: Center(
                      child: new Text(
                        'Total Deaths: ${NumberFormat.decimalPattern().format(country.deaths)}',
                        style: customTextStyle(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.1,
                  ),
                  ListTile(
                    title: Center(
                      child: new Text(
                        'Active Cases: ${NumberFormat.decimalPattern().format(country.active)}',
                        style: customTextStyle(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.1,
                  ),
                  ListTile(
                    title: Center(
                      child: new Text(
                        'Total Recoveries: ${NumberFormat.decimalPattern().format(country.recovered)}',
                        style: customTextStyle(),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  TextStyle customTextStyle() {
    return TextStyle(
        color: Colors.white,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.double
    );
  }
}
