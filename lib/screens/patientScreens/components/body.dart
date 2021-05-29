import 'package:flutter/material.dart';
import 'package:meditime/constants.dart';
import 'package:meditime/database/helper/medsDBHelper.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  MedsDBHelper medsDBHelper = MedsDBHelper();
  List<Map<String, dynamic>> medsDataList = [];
  List<Widget> medsListTile = [];

  @override
  Widget build(BuildContext context) {
    if (true) {
      updateMedsData();
    }
    return (medsListTile.length == 0)
        ? Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/reminder.png",width: 250,),
                SizedBox(height: 10,),
                Text("No Medicines Added", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                ],
            ),
        )
        : ListView(
            children: [
              ...medsListTile,
              GestureDetector(
                child: Icon(Icons.add),
                onTap: () {
                  print(medsListTile);
                  print("inside gesture detecter");
                  setState(() {
                    medsListTile.insert(0, generateListTile());
                    print(medsListTile);
                  });
                },
              ),
            ],
          );
  }

  void updateMedsData() async {
    medsDataList = await medsDBHelper.selectAll();
    print(medsDataList);
  }

  Widget generateListTile() {
    
    return ListTile(
      leading: Text("leading"),
      title: Text("title"),
      subtitle: Text("subtitle"),
      trailing: TextButton(
        child: Icon(Icons.delete,color: Colors.red,),
        onPressed: (){
        //TODO: add functions to on pressed 
        },
      ),
      tileColor: meditimePrimary,
    );
  }
}
