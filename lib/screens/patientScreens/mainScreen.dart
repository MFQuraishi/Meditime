import 'package:flutter/material.dart';
import 'package:meditime/screens/patientScreens/components/body.dart';
import 'package:meditime/constants.dart';
import 'package:meditime/screens/patientScreens/components/addMedicineForm.dart';
import 'package:meditime/database/helper/medsDBHelper.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MedsDBHelper medsDBHelper = MedsDBHelper();
  List<Map<String, dynamic>> medsDataList = [];

  @override
  void initState() {
    super.initState();
    updateMedsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guest Session"),
      ),
      body: (medsDataList.length == 0)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/reminder.png",
                    width: 250,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "No Medicines Added",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          : MedsList(medsDataList, deleteRow),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: meditimePrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        onPressed: () {
          showModalForm(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void updateMedsData() async {
    medsDataList = await medsDBHelper.selectAll();
    setState((){});
    print(medsDataList);
  }
  
  deleteRow(id) async {
    await medsDBHelper.deleteRow(id);
    updateMedsData();
    print(medsDataList);
  }

  formFilledOrNot(bool result) {
    if(result){
      updateMedsData();
    }
  }

  showModalForm(context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AddMedicineForm(formFilledOrNot);
      },
      backgroundColor: meditimeLightColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
    );
  }
}
