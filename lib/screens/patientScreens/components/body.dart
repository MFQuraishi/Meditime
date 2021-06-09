import 'package:flutter/material.dart';
import 'package:meditime/notifications/notificationManager.dart';
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
            subtitle: Text(
              (tilesList[i]["interval"] == "Everyday")
                  ? tilesList[i]["interval"]
                  : (double.tryParse(tilesList[i]["interval"]) != null)
                      ? "after Every ${tilesList[i]["interval"]} day"
                      : getWeekDays(tilesList[i]["interval"]),
            ),
            tileColor: Colors.white,
            trailing: TextButton(
              child: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                deleteRow(tilesList[i]["_id"]);
                NotificationManager.nm.refreshNotifications();
              },
            ),
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: Container(
                        // width: size.width,
                        height: size.height * 0.6,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                medsInfoRow("Name", tilesList[i]["name"]),
                                medsInfoRow("Type", tilesList[i]["type"]),
                                medsInfoRow("Amount",
                                    tilesList[i]["amount"].toString()),
                                medsInfoRow("Units", tilesList[i]["units"]),
                                medsInfoRow(
                                    "Description", tilesList[i]["description"]),
                                fillIntervalValue(
                                    "Interval", tilesList[i]["interval"]),
                                medsInfoRow(
                                    "times list", tilesList[i]["times_a_day"]),
                                medsInfoRow("From",
                                    "${changeDateTimeFormat(tilesList[i]["from_date"])}"),
                                medsInfoRow("To",
                                    "${changeDateTimeFormat(tilesList[i]["to_date"])}"),
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

  medsInfoRow(parameter, value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          parameter,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget fillIntervalValue(parameter, value) {
    String intervalValue = "";
    if (value == "Everyday") {
      intervalValue = value;
    } else if (double.tryParse(value) != null) {
      intervalValue = "after every ${value} day";
    } else {
      intervalValue = getWeekDays(value);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          parameter,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Container(
          width: 110,
          child: Text(
            intervalValue != null ? intervalValue : '',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  String getWeekDays(input) {
    String intervalValue = "";
    List temp = input.split(" ");
    Map intervalDays = {
      0: "Sun",
      1: "Mon",
      2: "Tue",
      3: "Wed",
      4: "Thu",
      5: "Fri",
      6: "Sat",
    };

    for (int i = 0; i < temp.length; i++) {
      if (temp[i] == 'true') {
        intervalValue += "${intervalDays[i]} ";
      }
    }
    return intervalValue;
  }

  String changeDateTimeFormat(timeInString) {
    DateTime changedTime = DateTime.parse(timeInString);
    return changedTime.day.toString().padLeft(2, "0") +
        "/" +
        changedTime.month.toString().padLeft(2, "0") +
        "/" +
        changedTime.year.toString();
  }
}
