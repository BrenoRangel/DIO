import 'package:bmi_calculator/bmi/bmi.dart';
import 'package:bmi_calculator/models/person.dart';
import 'package:bmi_calculator/persistence/shared_preferences.dart';
import 'package:bmi_calculator/persistence/sqflite.dart';
import 'package:bmi_calculator/utils/theming.dart';
import 'package:bmi_calculator/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameEditingController = TextEditingController();
  final weightEditingController = TextEditingController();
  final heightEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("$kAppBarTitle"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: db.query(
            "Person",
            columns: [
              "id",
              "name",
              "weight",
              "height",
            ],
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) return const CircularProgressIndicator();
            final patients = snapshot.data!.map(Person.fromJson);
            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("$kPatients:"),
                gap,
                if (patients.isEmpty) Text("$kPatientsMissing"),
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
                          elevation: 0,
                          margin: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                            side: BorderSide(
                              color: Colors.black.withOpacity(0.125),
                              width: 2.0,
                            ),
                          ),
                          child: Card(
                            elevation: 0,
                            child: Column(
                              children: [
                                AppBar(
                                  toolbarHeight: kToolbarHeight / 2,
                                  elevation: 0,
                                  titleTextStyle: Theme.of(context).textTheme.bodyLarge,
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
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
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
                    ).expand(
                      (element) => [
                        element,
                        gap
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddUserModal,
        tooltip: "$kAddPatient",
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    nameEditingController.dispose();
    weightEditingController.dispose();
    heightEditingController.dispose();
    super.dispose();
  }

  Future<void> showAddUserModal() async {
    late Person? patient;

    nameEditingController.clear();
    weightEditingController.clear();
    heightEditingController.clear();

    onCloseDialog() {
      Navigator.pop(
        context,
        Person(
          name: nameEditingController.text,
          weight: double.parse(weightEditingController.text),
          height: double.parse(heightEditingController.text),
        ),
      );
    }

    patient = await Get.defaultDialog(
      title: "$kAddPatient",
      content: Column(
        children: [
          TextField(
            controller: nameEditingController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: '$kName',
            ),
          ),
          TextField(
            controller: weightEditingController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: '$kWeight',
              suffix: Text("$kKilograms"),
            ),
          ),
          TextField(
            controller: heightEditingController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.go,
            decoration: InputDecoration(
              hintText: '$kHeight',
              suffix: Text("$kMeters"),
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
        child: Text("$kCancel"),
      ),
      confirm: TextButton(
        onPressed: () {
          onCloseDialog();
        },
        child: Text("$kConfirm"),
      ),
    );

    if (patient != null) {
      final id = await db.insert("Person", patient.toJson());
      setState(() {
        patient!.id = id;
      });
    }
  }
}
