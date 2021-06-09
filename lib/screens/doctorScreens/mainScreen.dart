import 'package:flutter/material.dart';
import 'package:meditime/constants.dart';
import 'package:meditime/screens/doctorScreens/components/appointments.dart';
import 'package:meditime/screens/doctorScreens/components/patients.dart';
import 'package:meditime/screens/doctorScreens/components/patients.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

   List<Widget> widgetOptions = [
     Patients(),
     Appointments(),
   ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("logged in as Doctor"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: meditimePrimary,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: "Patients",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
              ),
              label: "Appointments"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: onTapped,
      ),
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
  onTapped(int i){
    setState(() {
      _selectedIndex = i;
    });
  }
}