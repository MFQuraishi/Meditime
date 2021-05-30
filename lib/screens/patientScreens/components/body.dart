import 'package:flutter/material.dart';
import 'package:meditime/constants.dart';
import 'package:meditime/database/helper/medsDBHelper.dart';

class MedsList extends StatelessWidget {

  Function deleteRow;
  List<Map<String, dynamic>> tilesList;
  MedsList(this.tilesList, this.deleteRow);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
        itemCount: tilesList.length,
        itemBuilder: (BuildContext context, int i) {
          return Card(
              child: ListTile(
            leading: Icon(
              Icons.medical_services_rounded,
            ),
            title: Text(tilesList[i]["name"]),
            subtitle: Text(tilesList[i]["interval"]),
            tileColor: Colors.white,
            trailing: TextButton(
              child: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                deleteRow(tilesList[i]["_id"]);
              },
            ),
            onTap: () async {
              //TODO: show detailed information when a tile is tapped
              await showDialog(context: context, builder: (BuildContext context){
                return Dialog(
                  child: Container(
                    // width: size.width,
                    height: size.height*0.6,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            medsInfoRow("Name",tilesList[i]["name"]),
                            medsInfoRow("Type",tilesList[i]["type"]),
                            medsInfoRow("Amount",tilesList[i]["amount"].toString()),
                            medsInfoRow("Units",tilesList[i]["units"]),
                            medsInfoRow("Description",tilesList[i]["description"]),
                            medsInfoRow("Interval",tilesList[i]["interval"]),
                            medsInfoRow("From-To",tilesList[i]["from_date"]),
                            medsInfoRow("From-To",tilesList[i]["to_date"]),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
            },
          ));
        });
  }
  medsInfoRow(parameter ,value){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(parameter, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
        Text(value, style: TextStyle(fontSize: 15),)
      ],
    );
  }
}