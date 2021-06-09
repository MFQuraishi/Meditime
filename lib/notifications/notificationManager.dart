import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meditime/database/helper/medsDBHelper.dart';
import 'package:meditime/database/tableConstants.dart';
import 'package:meditime/database/helper/medsDBHelper.dart';
import 'package:meditime/notifications/notifications.dart';

class NotificationManager {
  NotificationManager._privateConstructor();

  static final NotificationManager nm =
      NotificationManager._privateConstructor();

  MedsDBHelper dbHelper = new MedsDBHelper();
  List<Map<String, dynamic>> data;

  Future<List> getData() async {
    return await dbHelper.selectAll();
  }

  scheduleNotification(t, id) async {
    String s = t;
    var temp = await dbHelper.selectAtId(id);
    var row = temp[0];

    var t1 = DateTime.now();
    DateTime time = DateTime(t1.year, t1.month, t1.day,
        int.parse(s.substring(0, 2)), int.parse(s.substring(3, 5)));
    Notifications().scheduleNotification(time, row[MedsTableConstants.COL_NAME], id);
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  Future<List<Map<String, dynamic>>> getMedsInDateRange()async {
    //TODO: get list of medicines tom be taken today
    List<Map<String, dynamic>> MedsInDateRange = [];
    for (int i = 0; i < data.length; i++) {
      if (DateTime.now()
          .isAfter(DateTime.parse(data[i][MedsTableConstants.COL_FROM_DATE]))) {
        if (DateTime.now()
            .isAfter(DateTime.parse(data[i][MedsTableConstants.COL_TO_DATE]))) {
          await dbHelper.deleteRow(data[i][MedsTableConstants.COL_ID]);
        } else {
          MedsInDateRange.add(data[i]);
        }
      }
    }

    return MedsInDateRange;
  }

  List<Map<String, dynamic>> filterDatesValidForToday(MedsList) {
    List<Map<String, dynamic>> validDates = [];

    for (int i = 0; i < MedsList.length; i++) {
      String intervalType = MedsList[i][MedsTableConstants.COL_INTERVAL];
      if (intervalType == "Everyday") {
        validDates.add(MedsList[i]);
      } else if (isNumeric(intervalType)) {
        int diffInDays = DateTime.now()
            .difference(
                DateTime.parse(MedsList[i][MedsTableConstants.COL_FROM_DATE]))
            .inDays;
        if (diffInDays % int.parse(intervalType) == 0) {
          validDates.add(MedsList[i]);
        }
      } else {
        List weekDays =
            intervalType.split(" ").map((value) => value == 'true').toList();
        if(weekDays[DateTime.now().weekday]){
          validDates.add(MedsList[i]);
        }
      }
    }

    return validDates;
  }

  Map getListOfTimes(todaysMeds){
    Map timesList = {};
    for(int i=0; i<todaysMeds.length; i++){
      var key = todaysMeds[i][MedsTableConstants.COL_ID];
      var value = todaysMeds[i][MedsTableConstants.COL_TIMES_A_DAY].split(" ");
      timesList[key] = value;
    }

    return timesList;
  }

  Future<int> refreshNotifications() async {
    data = await getData();
    // seperateDifferentIntervalTypes();
    List<Map<String, dynamic>>  medsInDateRange = await getMedsInDateRange();
    List<Map<String, dynamic>> todaysMeds = await filterDatesValidForToday(medsInDateRange);
    Map timesMap = getListOfTimes(todaysMeds);

    List keys = timesMap.keys.toList();
    for(int i in keys){
      List timesList = timesMap[i];

      for(String j in timesList){
        await scheduleNotification(j, i);// here j is the time and i is the id
      }
    }
    print(" ************** Scheduled Notifications:");
    print(await Notifications().getListOfTodaysNotifications());
    print("*******************************************");
    return 1;
  }
}
