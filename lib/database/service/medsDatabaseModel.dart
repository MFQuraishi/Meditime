import 'dart:ffi';

import 'package:meditime/database/tableConstants.dart';


class MedsDatabaseModel{

  int id;
  String name;
  String type;
  double amount;
  String units;
  String description;
  String timesADay;
  dynamic interval;
  String from;
  String to;


  Map<String, dynamic> formObject;
  MedsDatabaseModel(this.formObject){
    name = formObject["name"];
    type = formObject["type"] ;
    amount = formObject["amount"] ;
    units = formObject["units"] ;
    description = formObject["description"];
    timesADay = formObject["timesADay"].join(" ");

    if(formObject["interval"].runtimeType == "".runtimeType){
      interval = formObject["interval"].toString();
    }
    else if(formObject["interval"].runtimeType == 1.runtimeType){
      interval = formObject["interval"].toString();
    }
    else{
      interval = formObject["interval"].join(" ");
    }
    from = formObject["to-from"].start.toString();
    to = formObject["to-from"].end.toString();
  }

  // IMPORTANT!!!!
  // To-from is recieved as a DateTimeRange object but being stored seperately
  // as to_from.start and to_from.end

  Map<String, dynamic> toMap() {

    Map<String, dynamic> meds = {};
    meds[MedsTableConstants.COL_NAME] = name;
    meds[MedsTableConstants.COL_TYPE] = type;
    meds[MedsTableConstants.COL_AMOUNT] = amount;
    meds[MedsTableConstants.COL_UNITS] = units;
    meds[MedsTableConstants.COL_DESCRIPTION] = description;
    meds[MedsTableConstants.COL_TIMES_A_DAY] = timesADay;
    meds[MedsTableConstants.COL_INTERVAL] = interval;
    meds[MedsTableConstants.COL_FROM_DATE] = from;
    meds[MedsTableConstants.COL_TO_DATE] = to;

    return meds;
  }
}