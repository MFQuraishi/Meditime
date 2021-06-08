import 'package:meditime/database/helper/medsDBHelper.dart';
import 'package:meditime/database/tableConstants.dart';
import 'package:meditime/notifications/notifications.dart';

class NotificationManager {
  MedsDBHelper dbHelper = new MedsDBHelper();
  List<Map<String, dynamic>> data = null;

  Future<List> getData() async {
    if (data == null) {
      return await dbHelper.selectAll();
    }
    return data;
  }

  scheduleNotification() async {
    data = await getData();
    List timesList = data[0][MedsTableConstants.COL_TIMES_A_DAY].split(" ");
    String s = timesList[0];
    var t1 = DateTime.now();
    DateTime time = DateTime(t1.year, t1.month, t1.day,
        int.parse(s.substring(0, 2)), int.parse(s.substring(3, 5)));
    Notifications().scheduleNotification(time, data[0][MedsTableConstants.COL_NAME]);
  }

  

}
