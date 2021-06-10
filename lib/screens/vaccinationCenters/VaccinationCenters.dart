import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:meditime/constants.dart';

class VaccinationCenters extends StatefulWidget {
  @override
  _VaccinationCentersState createState() => _VaccinationCentersState();
}

class _VaccinationCentersState extends State<VaccinationCenters> {
  //https://cdn-api.co-vin.in/api/v2/appointment/centers/public/findByLatLong?lat=25.321684&long=82.987289
  String address = "";
  Widget centersList;

  @override
  void initState() {
    centersList = Center(
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Container(
          child: Text(
            "search addess with pincode to get vaccination centers near you",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,),
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic> centers = getCenters(25.321684, 82.987289);
    // var lat = 26.837009;
    // var long = 80.938767;
    Size size = MediaQuery.of(context).size;


    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Flexible(
          flex: 2,
          child: Container(
            color: Colors.grey,
            child: Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                  Container(
                    width: size.width * 0.7,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "enter address",
                        labelText: "enter address",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        address = value;
                      },
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          centersList = Center(child: CircularProgressIndicator());
                        });
                        var ll = await getLatAndLong(address);

                        if(ll != null) {
                          var data = await getCenters(ll[0], ll[1]);
                          print(data);
                          setState(() {
                            if (data != null) {
                              centersList = buildCentersList(data["centers"]);
                            }
                            else {
                              centersList = showErrorMessage();
                            }
                          });
                        }
                        else{
                          setState(() {
                            centersList = showErrorMessage();
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                      ))
                ])),
          ),
        ),
        Flexible(
          flex: 9,
          child: Container(
            child: centersList,
          ),
        ),
      ]),
    );
  }

  Widget showErrorMessage(){
    return Center(
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Container(
          child: Text(
            "Either the address was invalid or there is a problem with internet",
            style: TextStyle(fontSize: 15,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,),
        ),
      ),
    );
  }

  Widget buildCentersList(data) {
    Size size = MediaQuery.of(context).size;
    // print(data.length);
    return ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int i) {
          return Card(
            child: ListTile(
              title: Text(data[i]["name"]),
              trailing: Icon(Icons.list_alt),
              onTap: () async {
                await showDialog(context: context, builder: (BuildContext context){
                  return Dialog(
                    child: Container(
                      height: size.height*0.8,
                      width: size.width*0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          Text(data[i]["name"]),
                          Text("district name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          Text(data[i]["district_name"]),
                          Text("state name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          Text(data[i]["state_name"]),
                          Text("location", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          Text(data[i]["location"]),
                          Text("pincode", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          Text(data[i]["pincode"]),
                          Text("block name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          Text(data[i]["block_name"]),
                        ],
                      ),
                    ),
                  );
                });
              },
            ),
          );
        });
    // return Text("centers");
  }

  Future<dynamic> getCenters(lat, long) async {
    var url = Uri.parse(
        "https://cdn-api.co-vin.in/api/v2/appointment/centers/public/findByLatLong?lat=${lat}&long=${long}");
    var response;
    try{
      response = await http.get(url).timeout(Duration(seconds: 25));
    } catch(e){
      return null;
    }


    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  Future<dynamic> getLatAndLong(address) async {
    if(address == null || address.length == 0){
      return null;
    }
    List ll = [];
    
    String encodesAddress = Uri.encodeComponent(address);

    var turl = Uri.parse(
        "https://trueway-geocoding.p.rapidapi.com/Geocode?address="+encodesAddress);

    var tresponse;
    try{
      tresponse = await http.get(turl, headers: {
        "x-rapidapi-key": "ab725230c7msh894c28fe284646dp18c719jsn42d7a13e649e",
        "x-rapidapi-host": "trueway-geocoding.p.rapidapi.com"
      }).timeout(Duration(seconds: 25));
    } catch(e){
      return null;
    }


    if (tresponse.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(tresponse.body) as Map<String, dynamic>;
      print(jsonResponse);
      ll.add(jsonResponse["results"][0]["location"]["lat"]);
      ll.add(jsonResponse["results"][0]["location"]["lng"]);
    } else {
      print('Request failed with status: ${tresponse.statusCode}.');
      return null;
    }
    return ll;
  }
}
