import 'package:flutter/material.dart';

//******************* TIME PICKER WIDGET CLASS WITH TIME AND A DELETE ICON ******************************************
class TimeWidgets extends StatelessWidget {
  final String time;
  final UniqueKey key;
  final Function setTime;
  final Function deleteTime;

  TimeWidgets({this.time, this.key, this.setTime, this.deleteTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(4),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                child: Text(
                  time,
                  style: TextStyle(fontSize: 23),
                ),
              )),
          Expanded(
            flex: 1,
            child: Container(
              child: TextButton(
                child: Icon(Icons.timelapse),
                onPressed: () async {
                  var temp = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  var time = temp.hour.toString().padLeft(2, "0") +
                      ":" +
                      temp.minute.toString().padLeft(2, "0");
                  setTime(key, time);
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: TextButton(
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  deleteTime(key);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
