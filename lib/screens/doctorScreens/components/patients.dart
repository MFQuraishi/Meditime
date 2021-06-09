import 'package:flutter/material.dart';

class Patients extends StatefulWidget {
  @override
  _PatientsState createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  @override
  Widget build(BuildContext context) {
    Map<String, Map> patientsInfo = getPatientsInfo();
    List keys = patientsInfo.keys.toList();
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
        itemCount: keys.length,
        itemBuilder: (BuildContext context, int i) {
          return Card(
            margin: EdgeInsets.all(5),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: ListTile(
                title: Text(keys[i]),
                leading: Icon(Icons.perm_identity),
                subtitle: Text("Problem ${patientsInfo[keys[i]]["Problem"]}"),
                trailing: Text("Age ${patientsInfo[keys[i]]["Age"]}"),
                onTap: ()async{
                  await showDialog(context: context, builder: (BuildContext context){
                    return Dialog(
                      child: Container(
                        height: size.height * 0.5,
                        width: size.width * 0.5,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              patientRow("Name", keys[i]),
                              patientRow("Age", patientsInfo[keys[i]]["Age"]),
                              patientRow("Sex", patientsInfo[keys[i]]["Sex"]),
                              patientRow("Height", patientsInfo[keys[i]]["Height"]),
                              patientRow("Weight", patientsInfo[keys[i]]["Weight"]),
                              patientRow("Problem", patientsInfo[keys[i]]["Problem"]),
                              patientRow("Others-Disease", patientsInfo[keys[i]]["Others-Disease"]),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
                },
              ),
            ),
          );
        }
        );
  }

  Widget patientRow(parameter, value){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(parameter, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
        Text(value, style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),),
      ],
    );
  }

  Map<String, Map> getPatientsInfo() {
    Map<String, Map> PatientsInfo = {
      "Mohsin": {
        "Problem": "Alzheimer",
        "Age": "34",
        "Height": "5'6''",
        "Weight": "69",
        "Sex": "Male",
        "Others-Disease": "Low-BP Diabetes"
      },
      "Mohsina": {
        "Problem": "Cardiovascular Disease",
        "Age": "19",
        "Height": "5'8''",
        "Weight": "56",
        "Sex": "Female",
        "Others-Disease": "None"
      },
      "Tony Stark": {
        "Problem": "Respiratory Disease",
        "Age": "42",
        "Height": "6'0''",
        "Weight": "85",
        "Sex": "Male",
        "Others-Disease": "High-BP"
      },
      "Thor": {
        "Problem": "Tuberculosis",
        "Age": "25",
        "Height": "6'3''",
        "Weight": "92",
        "Sex": "Male",
        "Others-Disease": "Brain Tumour"
      },
      "Kakarot": {
        "Problem": "Malaria",
        "Age": "108",
        "Height": "6'1''",
        "Weight": "89",
        "Sex": "Male",
        "Others-Disease": "Diarrhea"
      }
    };
    return PatientsInfo;
  }
}
