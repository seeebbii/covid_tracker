import 'dart:convert';

import 'package:awesome_loader/awesome_loader.dart';
import 'package:covid_tracker/model/CountryModel.dart';
import 'package:covid_tracker/ui/Detail_country.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String YOUR_IP_ADDRESS = '';

class FetchLocation extends StatefulWidget {
  @override
  _FetchLocationState createState() => _FetchLocationState();
}

class _FetchLocationState extends State<FetchLocation> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      fetchLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blueGrey.shade800,
          title: Text('Your Location'),
          centerTitle: true,
        ),
        backgroundColor: Colors.blueGrey.shade900,
        body: FutureBuilder(
          future: fetchLocation(),
          builder:
              (BuildContext context, AsyncSnapshot<CountryModel> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text('Generated from your IP Address', style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.2
                        ),)),
                  ),
                  Divider(
                    height: 20,
                    thickness: 15,
                    indent: 20,
                    endIndent: 20,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    leading: Image.network(snapshot.data.countryFlagUrl, height: 50, width: 50,),
                    title: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(snapshot.data.country, style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          letterSpacing: 2
                      ),),
                    ),
                    trailing: Text(YOUR_IP_ADDRESS, style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      letterSpacing: 2
                    ),),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 125,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white)
                          ),
                          child: MaterialButton(
                            splashColor: Colors.blueGrey,
                            animationDuration: Duration(seconds: 2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            elevation: 2,
                            onPressed: (){
                              setState(() {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.blueGrey.shade800,
                                  content: Text("Unable to find your Country!", style: TextStyle(
                                      color: Colors.white
                                  ),),
                                ));
                              });
                            },
                            child: Text(
                              'Incorrect',style:TextStyle(
                              color: Colors.white,

                            ),
                            ),
                          ),
                        ),
                        Container(
                          width: 125,
                          child: MaterialButton(
                            padding: const EdgeInsets.all(15),
                            splashColor: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            elevation: 2,
                            color: Colors.deepPurple.shade400,
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => DetailedCountry(country: snapshot.data,)
                              ));
                            },
                            child: Text('Correct', style: TextStyle(
                              color: Colors.white
                            ),),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Center(
                  child: AwesomeLoader(
                loaderType: AwesomeLoader.AwesomeLoader3,
                color: Colors.blueGrey.shade400,
              ));
            }
          },
        ));
  }

  Future<CountryModel> fetchLocation() async {
    String locUrl = 'https://tools.keycdn.com/geo.json?host=';
    String searchCountry = 'https://corona.lmao.ninja/v2/countries/';

    http.Response countryMap = await http.get(locUrl + YOUR_IP_ADDRESS);
    Map content = json.decode(countryMap.body);
    String countryName = content['data']['geo']['country_name'];
    Map objectMap;
    http.Response response = await http.get(searchCountry + countryName);
    objectMap = json.decode(response.body);

    CountryModel obj = CountryModel(
        objectMap['country'],
        objectMap['cases'],
        objectMap['deaths'],
        objectMap['countryInfo']['flag'],
        objectMap['active'],
        objectMap['recovered']);

    return obj;
  }
}
