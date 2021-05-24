import 'package:flutter/material.dart';
import 'package:meditime/services/toastServices.dart';
import 'package:meditime/constants.dart';
import 'package:meditime/screens/patientScreens/components/timePickerWidget.dart';

class AddMedicineForm extends StatefulWidget {
  @override
  _AddMedicineFormState createState() => _AddMedicineFormState();
}

class _AddMedicineFormState extends State<AddMedicineForm> {
  TimeOfDay time = TimeOfDay.now();
  //String noOfTime;
  Map<UniqueKey, String> times = {};

  bool showCustom = false;

  bool checked = false;

  final _formKey = GlobalKey<FormState>();
  final List<String> timeOptions = ["1", "2", "3", "custom"];
  final List<String> unitOfDoses = ["mg", "ml", "pills"];
  final List<String> typeOfDoses = [
    "Injection",
    "Tablet",
    "Capsule",
    "Ointment",
    "Spray"
  ];

  dynamic interval = "Everyday";
  Widget selectIntervalWidgets = SizedBox();

  DateTimeRange dateRange;

  Map<String, dynamic> masterFormObject = {
    "name": "",
    "type": "",
    "amount":"",
    "units":"",
    "description":"",
    "timesADay": [],
    "interval":dynamic,
    "to-from": DateTimeRange,
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
//*************************** BACK BUTTON ******************************************
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  child: Icon(Icons.arrow_back),
                  style: TextButton.styleFrom(
                    primary: meditimePrimary,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
//************************** NAME OF MEDICINE ******************************************
            TextFormField(
              validator: (value) =>
                  (value == null || value.isEmpty) ? "fill the value" : null,
              decoration: InputDecoration(
                labelText: "Medicine Name",
                hintText: "Medicine Name",
                border: OutlineInputBorder(),
              ),
              onChanged: (value){
                masterFormObject["name"]=value;
              },
            ),
            SizedBox(
              height: 10,
            ),
//*************************** TYPE OF MEDICINE ******************************************
            DropdownButtonFormField(
              validator: (value) => (value == null) ? "Type?" : null,
              items: typeOfDoses
                  .map((type) => DropdownMenuItem(
                        child: Text(type),
                        value: type,
                      ))
                  .toList(),
              //value: null,
              onChanged: (value){
                masterFormObject["type"] = value;
              },
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
//*************************** AMOUNT OF MEDICINE ******************************************
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
                    onChanged: (value){
                      masterFormObject["amount"]=value;
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
//************************ UNITS OF MEDICINE ******************************************
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
                    onChanged: (value) => {masterFormObject["units"]=value},
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
//**************************** MEDICINE DESCRIPTION ******************************************
            TextFormField(
              decoration: InputDecoration(
                hintText: "Description",
                labelText: "Description (Optional)",
                border: OutlineInputBorder(),
              ),
              onChanged: (value)=>{masterFormObject["description"]=value},
            ),
            SizedBox(
              height: 10,
            ),

//*************************** NO. OF TIMES A DAY ******************************************
            Container(
              padding: EdgeInsets.all(20.0),
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
              child: Column(
                children: [
                  Text(
                    "How many times a day",
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
                        times = {};
                        if (value == "custom") {
                          showCustom = true;
                          addTimeInMap();
                        } else {
                          showCustom = false;
                          for (int i = 0; i < int.parse(value); i++) {
                            addTimeInMap();
                          }
                        }
                        setState(() {});
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
                  ...createTimeWidgets(),
                  (showCustom)
                      ? customOptionsButton()
                      : SizedBox(
                          height: 10,
                        )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
//*************** NO OF DAYS IN A WEEK, ETC ******************************************
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(color: meditimeLightColor, boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 2,
                  color: meditimePrimary,
                ),
              ]),
              child: Column(
                children: [
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Select Interval",
                      labelText: "Select Interval",
                    ),
                    value: "Everyday",
                    items: ["Everyday", "After Every", "Days Of Week"]
                        .map(
                          (option) => DropdownMenuItem(
                            child: Text(option),
                            value: option,
                          ),
                        )
                        .toList(),
                    onChanged: (option) {
                      if (option == "Everyday") {
                        interval = option;
                        setState(() {
                          selectIntervalWidgets = SizedBox();
                        });
                      } else {
                        selectIntervalWidgets = intervalWidget(option);
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  selectIntervalWidgets,
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),

//*************************** TO-FROM *********************************************
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: meditimeLightColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 2,
                    color: meditimePrimary,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    (dateRange != null)
                        ? "${dateRange.start.day}/${dateRange.start.month}/${dateRange.start.year}"
                        : "START",
                    style: TextStyle(fontSize: 20),
                  ),

                  Text(
                    ":",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    (dateRange != null)
                        ? "${dateRange.end.day}/${dateRange.end.month}/${dateRange.end.year}"
                        : "UNTIL",
                    style: TextStyle(fontSize: 20),
                  ),
                  //"${dateRange.end.day}/${dateRange.end.month}/${dateRange.end.year}"
                  TextButton(
                    onPressed: () async {
                      print(dateRange);
                      dateRange = await showDateRangePicker(
                          context: context,
                          // locale: Locale('de'),
                          initialEntryMode: DatePickerEntryMode.input,
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(Duration(days: 5 * 365)));
                      setState(() {});
                      print(dateRange);
                    },
                    child: Icon(Icons.calendar_today),
                    style: TextButton.styleFrom(primary: meditimePrimary),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
//************************ SUBMIT BUTTON ******************************************
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  masterFormObject["timesADay"] = times.values.toList();
                  masterFormObject["interval"] = interval;
                  masterFormObject["to-from"] = dateRange;


                  bool f = validateCustomFields(masterFormObject["timesADay"], masterFormObject["interval"], masterFormObject["to-from"]);
                  if(f){
                    print(masterFormObject);
                    ToastServices.defaultToast("good!!");
                  }
                  else{
                    ToastServices.defaultToast("fill all fields");
                  }


                  print(masterFormObject);
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

//********************** ******************************** *******************************
//********************** ******************************** *******************************
//********************** *** BUILD FUNCTION ENDS HERE *** *******************************
//********************** ******************************** *******************************
//********************** ******************************** *******************************

//*********** CHECK IF TIMESADAY INTERVAL AND TO-FROM IS FILLED PROPERLY ****************
bool validateCustomFields(tad, interval, tf){
  if(tad.length == 0){
    return false;
  }
  else if(tad.indexOf("Time") != -1){
    return false;
  }

  
  if(interval != "Everyday"){
    if(interval.runtimeType == 1.runtimeType && interval < 1){
      return false;
    }
    else if(interval.runtimeType == [].runtimeType){
      int falseCount = 0;
      interval.forEach((value){
        if(!value){
          falseCount += 1;
        }
      });
      if(falseCount == 7){
        return false;
      }
    }
  }

  if(tf==null){
    return false;
  }
  
  return true;
  
}






//********************** INTERVAL OF MEDICINES ******************************************
  Widget intervalWidget(option) {
    if (option == "After Every") {
      return TextFormField(
        validator: (value) =>
            (value == null || value.isEmpty) ? "Enter Interval" : null,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          interval = value;
        },
        decoration: InputDecoration(
          hintText: "Enter Interval",
          labelText: "Enter Interval",
          border: OutlineInputBorder(),
        ),
      );
    } else if (option == "Days Of Week") {
      List days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
      interval = [];

      List<Widget> w = [];

      for (int i = 0; i < 7; i++) {
        interval.add(false);
        w.add(Column(
          children: [
            StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Checkbox(
                  value: interval[i],
                  onChanged: (value) {
                    interval[i] = value;
                    print(interval);
                    setState(() {});
                  });
            }),
            Text(days[i]),
          ],
        ));
      }
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: w,
          mainAxisAlignment: MainAxisAlignment.start,
        ),
      );
    }
  }

//**************** ADD AND RESET BUTTON FOR x times a day *******************************
  Widget customOptionsButton() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: meditimePrimary,
              ),
              onPressed: () {
                addTimeInMap();
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
                times = {};
                addTimeInMap();
                setState(() {});
              },
              child: Icon(Icons.settings_backup_restore))
        ],
      ),
    );
  }

//************************ DELETE FROM MAP OF times[key:time] ******************************************
  bool deleteTimeFromMap(key) {
    if (key != null) {
      times.remove(key);
      return true;
    }
    return false;
  }

//********************** SETTING TIME VALUE IN MAP times[key:time] ******************************************
  bool setTimeInMap(key, time) {
    if (key != null) {
      times.update(key, (oldTime) => time, ifAbsent: () => time);
      return true;
    }
    return false;
  }

//************************ ADD TIME VALUE IN MAP times[key:time] ******************************************

  bool addTimeInMap() {
    var key = UniqueKey();
    times.putIfAbsent(key, () => "Time");
    return true;
  }

//******************** CREATING A WIDGET LIST FROM times.values LIST *****************************************
  List<Widget> createTimeWidgets() {
    List<Widget> widgetList = [];
    times.forEach((key, value) {
      widgetList.add(TimeWidgets(
        key: key,
        time: value,
        setTime: (key, value) {
          setTimeInMap(key, value);
          setState(() {});
        },
        deleteTime: (key) {
          deleteTimeFromMap(key);
          setState(() {});
        },
      ));
    });
    return widgetList;
  }
}
