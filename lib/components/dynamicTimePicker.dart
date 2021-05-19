import 'package:flutter/material.dart';

class DynamicTimePicker {
  TimeOfDay time = TimeOfDay.now();
  String noOfTime;
  List<Widget> timesList = [];

  List<Widget> listOfPickers(option) {
    timesList = [];
    if (option == "custom") {
      print(option);
      return customOptionPicker();
    } else {
      return addPickerFields(int.parse(option));
    }
  }

  List<Widget> customOptionPicker() {
    if (timesList.isEmpty) {
      timesList.add(timerWidget());
      timesList.add(customOptionsButton());
    }else{
      timesList.insert(timesList.length, timerWidget());
      //print(timesList.length);
    }
    return timesList;
  }

  Widget customOptionsButton() {
    return Container(
      child: Row(
        children: [
          ElevatedButton(onPressed: () { this.customOptionPicker(); }, child: Icon(Icons.add)),
          SizedBox(width: 10,),
          ElevatedButton(
              onPressed: () {}, child: Icon(Icons.settings_backup_restore))
        ],
      ),
    );
  }

  Widget timerWidget() {
    print("inside timer body");
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(4),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 4,
              child: Container(
                child: Text(
                  "abcd",
                  style: TextStyle(fontSize: 20.0),
                ),
              )),
          Expanded(flex: 1, child: Container(child: Icon(Icons.timelapse))),
          Expanded(flex: 1, child: Container(child: Icon(Icons.delete)))
        ],
      ),
    );
  }

  List<Widget> addPickerFields(option) {
    for (int i = 0; i < option; i++) {
      timesList.add(timerWidget());
    }
    return timesList;
  }

  Future createPicker(context) async {
    TimeOfDay time = TimeOfDay.now();
    TimeOfDay newTime;

    time = await showTimePicker(context: context, initialTime: time);

    return newTime;
  }
}
