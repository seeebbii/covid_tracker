import 'dart:convert';

import 'package:covid_tracker/model/CountryModel.dart';
import 'package:covid_tracker/ui/Detail_country.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:english_words/english_words.dart' as words;
import 'package:awesome_loader/awesome_loader.dart';


class Country extends StatefulWidget {
  @override
  _CountryState createState() => _CountryState();
}
List content;
List<CountryModel> countriesList = new List<CountryModel>();
class _CountryState extends State<Country> {

  Icon searchIcon = Icon(Icons.search);
  Widget appBar = Text('');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: appBar,
        backgroundColor: Colors.blueGrey.shade800,
        actions: <Widget>[
          new IconButton(
              icon: searchIcon,
              onPressed: () {
                setState(() {
                  // ignore: unrelated_type_equality_checks
                  if(this.searchIcon.icon == Icons.search){
                    showSearch(context: context, delegate: SearchBar());
                  }else{
                    searchIcon = Icon(Icons.search);
                    appBar = Text('');
                  }
                });
              }
          )
        ],
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: Container(
        child: FutureBuilder(
          future: loadCountries(),
          builder: (BuildContext context, AsyncSnapshot<List<CountryModel>> snapshot){
            if(snapshot.hasData && snapshot.data.isNotEmpty){
              return ListView.builder(
                itemCount: 215,
                addRepaintBoundaries: true,
                reverse: false,
                itemBuilder: (BuildContext context, int position){
                  return Column(
                    children: <Widget>[
                      Divider(
                        height: 10.4,
                      ),
                      ListTile(
                        onTap: (){
                          CountryModel obj = CountryModel(content[position]['country'], content[position]['cases'], content[position]['deaths'],content[position]['countryInfo']['flag'], content[position]['active'], content[position]['recovered']);
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => DetailedCountry(country: obj,)
                          ));
                        },
                        title: new Text(
                          '${content[position]['country']}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        leading: new Image.network('${content[position]['countryInfo']['flag']}', height: 200, width: 90,),
                      )
                    ] ,
                  );
                },
              );
            }else{
              return Center(child: AwesomeLoader(
                loaderType: AwesomeLoader.AwesomeLoader3,
                color: Colors.blueGrey.shade400,
              ));
            }
          },
        ),
      ),
    );
  }

  Future<List<CountryModel>> loadCountries() async{
    String apiUrl = 'https://corona.lmao.ninja/v3/covid-19/countries';
    http.Response response = await http.get(apiUrl);
    setState(() {
      content = json.decode(response.body);
      for(int i = 0; i< 215; i++){
        CountryModel obj = CountryModel(content[i]['country'], content[i]['cases'], content[i]['deaths'],content[i]['countryInfo']['flag'], content[i]['active'], content[i]['recovered']);
        countriesList.add(obj);
      }
    });
    return  countriesList;
  }
}



class SearchBar extends SearchDelegate<String>{

  List<CountryModel> getData(){
    List<CountryModel> myList = new List<CountryModel>();
    for(int i = 0; i< 215; i++){
      CountryModel obj = CountryModel(content[i]['country'], content[i]['cases'], content[i]['deaths'],content[i]['countryInfo']['flag'], content[i]['active'], content[i]['recovered']);
      myList.add(obj);
    }
    return myList;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(
      icon: Icon(Icons.clear,),
      onPressed: (){
        query = "";
      },
    )];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: Icon(Icons.arrow_back),
    onPressed: () => Navigator.of(context).pop());
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final myList = getData().where((element) => element.country.startsWith(query)).toList();
    return myList.isEmpty ? Center(child: Text("No Result Found!", style: TextStyle(
      color: Colors.black87,
      fontSize: 18),)
      ,) : ListView.builder(
        itemCount: myList.length,
        itemBuilder: (BuildContext context, int index){
          final CountryModel row = myList[index];
          return ListTile(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => DetailedCountry(country: row,)
              ));
            },
            title: RichText(
              text:  TextSpan(
                text: myList[index].country.substring(0, query.length),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: myList[index].country.substring(query.length),
                    style: TextStyle(
                      color: Colors.black38
                    )
                  )
                ]
              ),
            ),
          );
        }
    );
  }
}


