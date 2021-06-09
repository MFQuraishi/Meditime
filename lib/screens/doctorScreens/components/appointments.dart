import 'package:flutter/material.dart';

class Appointments extends StatefulWidget {
  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {

  @override
  Widget build(BuildContext context) {
    Map<String, Map> appointmentsInfo = getAppointmentInfo();
    List keys = appointmentsInfo.keys.toList();

    return ListView.builder(
        itemCount: keys.length,
        itemBuilder: (BuildContext context, int i){
        return Card(
          margin: EdgeInsets.all(5),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListTile(
              title: Text(keys[i]),
              subtitle: Text("appointment at ${appointmentsInfo[keys[i]]["Place"]}"),
              trailing: Text("at ${appointmentsInfo[keys[i]]["Time"]}"),
            ),
          ),
        );
      }
    );
  }

  Map<String, Map> getAppointmentInfo(){
    Map<String, Map> appointmentsInfo = {
      "Mohsin": {
        "Time": "12:01 PM",
        "Place": "Home"
      },
      "Mohsina": {
        "Time": "12:45 PM",
        "Place": "Clinic"
      },
      "Ironman": {
        "Time": "01:15 PM",
        "Place": "Stark Tower"
      },
      "Thor": {
        "Time": "01:45 PM",
        "Place": "Asgard"
      }
    };
    return appointmentsInfo;
  }
}
