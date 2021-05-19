import 'package:flutter/material.dart';
//import 'package:meditime/components/dynamicTimePicker.dart';
import 'package:meditime/services/toastServices.dart';
import 'package:meditime/constants.dart';

class AddMedicineForm extends StatefulWidget {
  @override
  _AddMedicineFormState createState() => _AddMedicineFormState();
}

class _AddMedicineFormState extends State<AddMedicineForm> {
  TimeOfDay time = TimeOfDay.now();
  String noOfTime;
  Map<UniqueKey, Widget> timesList = {};
  Map<UniqueKey, Object> times = {};

  final _formKey = GlobalKey<FormState>();
  final List<String> timeOptions = ["1", "2", "3", "custom"];
  final List<String> unitOfDoses = ["mg", "ml", "pills"];
  //DynamicTimePicker dtp = new DynamicTimePicker();
  //List<Widget> timesWidgetList = [];

  final List<String> typeOfDoses = [
    "Insulin",
    "Tablet",
    "Capsule",
    "Ointment",
    "Spray"
  ];

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (value) =>
                  (value == null || value.isEmpty) ? "fill the value" : null,
              decoration: InputDecoration(
                labelText: "Medicine Name",
                hintText: "Medicine Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            DropdownButtonFormField(
              validator: (value) => (value == null) ? "Type?" : null,
              items: typeOfDoses
                  .map((type) => DropdownMenuItem(
                        child: Text(type),
                        value: type,
                      ))
                  .toList(),
              //value: null,
              onChanged: (value) => print(value),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Type",
                labelText: "Type",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    validator: (value) => (value == null || value.isEmpty)
                        ? "no of medicines"
                        : null,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Amount",
                      labelText: "Amount",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 1,
                  child: DropdownButtonFormField(
                    validator: (value) => (value == null) ? 'Units?' : null,
                    items: unitOfDoses
                        .map((type) => DropdownMenuItem(
                              child: Text(type),
                              value: type,
                            ))
                        .toList(),
                    onChanged: (value) => {print(value)},
                    //value: unitOfDoses[0],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Units",
                      hintText: "Units",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Description",
                labelText: "Description (Optional)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text("How many times a day",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DropdownButtonFormField(
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          timesList = listOfPickers(value);
                        });
                      }
                    },
                    items: timeOptions
                        .map((option) => DropdownMenuItem(
                            child: Text(option), value: option))
                        .toList(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Times in a day",
                      labelText: "Times in a day",
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  //...timesList.values.toList(),
                  ...arrangedPickerFields(),
                ],
              ),
              decoration: BoxDecoration(
                color: meditimeLightColor,
                boxShadow: [
                  BoxShadow(
                    color: meditimePrimary,
                    spreadRadius: 2,
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  ToastServices.defaultToast("good!!");
                } else {
                  ToastServices.defaultToast("Some thing is invalid!!");
                }
              },
              child: Text("Add Medicine"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20),
                primary: meditimePrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<UniqueKey, Widget> listOfPickers(option) {
    timesList = {};
    times = {};
    if (option == "custom") {
      print(option);
      return customOptionPicker();
    } else {
      return addPickerFields(int.parse(option));
    }
  }

  Map<UniqueKey, Widget> customOptionPicker() {
    Map<Object, Object> tempTimerWidget = timerWidget();
    Map<Object, Object> tempcustomOptionsButton = customOptionsButton();

    if (timesList.isEmpty) {
      timesList[tempTimerWidget.keys.toList()[0]] =
          tempTimerWidget.values.toList()[0];
      timesList[tempcustomOptionsButton.keys.toList()[0]] =
          tempcustomOptionsButton.values.toList()[0];
    } else {
      timesList[tempTimerWidget.keys.toList()[0]] =
          tempTimerWidget.values.toList()[0];
    }
    return timesList;
  }

  Map<UniqueKey, Widget> customOptionsButton() {
    Widget w = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: meditimePrimary,
              ),
              onPressed: () {
                customOptionPicker();
                setState(() {});
              },
              child: Icon(Icons.add)),
          SizedBox(
            width: 10,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
              ),
              onPressed: () {
                timesList = {};
                times = {};
                customOptionPicker();
                setState(() {});
              },
              child: Icon(Icons.settings_backup_restore))
        ],
      ),
    );

    var key = UniqueKey();
    return {key: w};
  }

  Map<Object, Object> timerWidget() {
    var key = UniqueKey();
    times[key] = "Time";

    // print(times);
    // print(key);

    Widget w = Container(
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
                  times[key],
                  style: TextStyle(fontSize: 25),
                ),
              )
              ),
          Expanded(
            flex: 1,
            child: Container(
              child: TextButton(
                child: Icon(Icons.timelapse),
                onPressed: () async{
                  var temp = await showTimePicker(context: context, initialTime: time);

                  times[key] = temp.toString();
                  setState(() {});
                  print(times); 

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
                  print(key);
                  timesList.remove(key);
                  times.remove(key);
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
    return {key: w};
  }

  Map<UniqueKey, Widget> addPickerFields(option) {
    var temp = {};
    for (int i = 0; i < option; i++) {
      temp = timerWidget();
      timesList[temp.keys.toList()[0]] = temp.values.toList()[0];
    }

    return timesList;
  }

  List arrangedPickerFields() {
    var tl = timesList.values.toList();
    var temp;

    if (tl.length > 2) {
      temp = tl[1];
      tl[1] = tl[tl.length - 1];
      tl[tl.length - 1] = temp;
    }

    return tl;
  }
}