import 'package:bmi_calculator/bmi/bmi.dart';
import 'package:bmi_calculator/models/person.dart';
import 'package:bmi_calculator/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Person> patients = [];

  final nameEditingController = TextEditingController();
  final weightEditingController = TextEditingController();
  final heightEditingController = TextEditingController();

  Future<void> showAddUserModal() async {
    late Person? patient;

    nameEditingController.clear();
    weightEditingController.clear();
    heightEditingController.clear();

    onCloseDialog() {
      Navigator.pop(
        context,
        (
          name: nameEditingController.text,
          weight: double.parse(weightEditingController.text),
          height: double.parse(heightEditingController.text)
        ),
      );
    }

    patient = await Get.defaultDialog(
      title: "Add Patient",
      content: Column(
        children: [
          TextField(
            controller: nameEditingController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: 'Name',
            ),
          ),
          TextField(
            controller: weightEditingController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: 'Weight',
              suffix: Text("Kilograms"),
            ),
          ),
          TextField(
            controller: heightEditingController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.go,
            decoration: InputDecoration(
              hintText: 'Height',
              suffix: Text("Meters"),
            ),
            onSubmitted: (value) {
              onCloseDialog();
            },
          ),
        ],
      ),
      cancel: TextButton(
        onPressed: () {
          Navigator.pop(
            context,
            null,
          );
        },
        child: Text("Cancel"),
      ),
      confirm: TextButton(
        onPressed: () {
          onCloseDialog();
        },
        child: Text("Confirm"),
      ),
    );

    if (patient != null) {
      setState(() {
        patients.add(patient!);
      });
    }
  }

  @override
  void dispose() {
    nameEditingController.dispose();
    weightEditingController.dispose();
    heightEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("DIO's BMI Calculator Challenge"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Patients: "),
            if (patients.isEmpty) Text("No patients yet. Please add one by clicking on 'Add Patient' button"),
            if (patients.isNotEmpty)
              ...List.from(
                patients.map(
                  (patient) {
                    var fontSize = Theme.of(context).textTheme.bodyLarge!.fontSize;
                    var bmi = BMI.calculate(patient.weight, patient.height);
                    var classification = BMI.classify(bmi);
                    var color = getColorByClassification(classification);
                    return Card(
                      color: color,
                      child: Card(
                        child: Column(
                          children: [
                            AppBar(
                              title: Text(
                                patient.name,
                                style: TextStyle(
                                  color: Color(0xFF282A36),
                                ),
                              ),
                              backgroundColor: color,
                            ),
                            Column(
                              children: [
                                ListTile(
                                  minVerticalPadding: 0,
                                  leading: IconButton(
                                    onPressed: null,
                                    disabledColor: Colors.black,
                                    icon: Icon(
                                      Symbols.weight,
                                      size: fontSize,
                                    ),
                                  ),
                                  title: Text(
                                    "${patient.weight} kg",
                                  ),
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                ListTile(
                                  minVerticalPadding: 0,
                                  minLeadingWidth: fontSize,
                                  leading: IconButton(
                                    onPressed: null,
                                    disabledColor: Colors.black,
                                    icon: Icon(
                                      Symbols.height,
                                      size: fontSize,
                                    ),
                                  ),
                                  title: Text(
                                    "${patient.height.toStringAsFixed(2)} m",
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                ),
                                ListTile(
                                  minVerticalPadding: 0,
                                  leading: IconButton(
                                    onPressed: null,
                                    disabledColor: Colors.black,
                                    icon: Icon(
                                      Symbols.body_fat,
                                      size: fontSize,
                                    ),
                                  ),
                                  title: Text(
                                    "${bmi.toStringAsFixed(2)} ($classification)",
                                    style: TextStyle(color: color),
                                  ),
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddUserModal,
        tooltip: 'Add Patient',
        child: const Icon(Icons.add),
      ),
    );
  }
}
