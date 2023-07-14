import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences preferences;

Future<void> initPreferences() async {
  preferences = await SharedPreferences.getInstance();

  if (kDebugMode) {
    await preferences.clear();
  }

  if (kAppTitle == null) {
    seed();
  }
}

void seed() {
  //Labels
  preferences.setString("appTitle", "BMI Calculator");
  preferences.setString("appBarTitle", "DIO's BMI Calculator Challenge");
  preferences.setString("patients", "Patients");
  preferences.setString("patientsMissing", "No patients found. Please add one by clicking on 'Add Patient' button");
  preferences.setString("name", "Name");
  preferences.setString("weight", "Weight");
  preferences.setString("height", "Height");
  preferences.setString("kilograms", "Kilograms");
  preferences.setString("meters", "Meters");

  //Buttons
  preferences.setString("addPatient", "Add Patient");
  preferences.setString("cancel", "Cancel");
  preferences.setString("confirm", "Confirm");

  //Errors
  preferences.setString("invalidPersonName", "Invalid person name");
  preferences.setString("invalidPersonWeight", "Invalid person weight");
  preferences.setString("invalidPersonHeight", "Invalid person height");
}

//Labels
String? get kAppTitle => preferences.getString("appTitle");
String? get kAppBarTitle => preferences.getString("appBarTitle");
String? get kPatientsMissing => preferences.getString("patientsMissing");
String? get kPatients => preferences.getString("patients");
String? get kName => preferences.getString("name");
String? get kWeight => preferences.getString("weight");
String? get kHeight => preferences.getString("height");
String? get kKilograms => preferences.getString("kilograms");
String? get kMeters => preferences.getString("meters");

//Buttons
String? get kAddPatient => preferences.getString("addPatient");
String? get kCancel => preferences.getString("cancel");
String? get kConfirm => preferences.getString("confirm");

//Errors
String? get kInvalidPersonName => preferences.getString("invalidPersonName");
String? get kInvalidPersonWeight => preferences.getString("invalidPersonWeight");
String? get kInvalidPersonHeight => preferences.getString("invalidPersonHeight");
