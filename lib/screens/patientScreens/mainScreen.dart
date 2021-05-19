import 'package:flutter/material.dart';
import 'package:meditime/screens/patientScreens/components/body.dart';
import 'package:meditime/constants.dart';
import 'package:meditime/screens/patientScreens/components/addMedicineForm.dart';

class MainScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("logged in as Patient"),
      ),
      body: Body(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: meditimePrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        onPressed: (){
            showModalForm(context);
          },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  showModalForm(context){
    // print("just able to come here");
    showModalBottomSheet(
        context: context,
        builder:(context){          
            return AddMedicineForm();
        },
        backgroundColor: meditimeLightColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),topRight: Radius.circular(15.0))),

    );
  }
}