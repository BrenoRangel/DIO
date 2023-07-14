import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite/sqflite.dart';

late Database db;

Future<void> initDb() async {
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }

  db = await openDatabase(
    'bmi_calculator.db',
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
        '''
CREATE TABLE Person ( 
  id INTEGER PRIMARY KEY AUTOINCREMENT, 
  name TEXT NOT NULL,
  weight REAL NOT NULL,
  height REAL NOT NULL
)
      ''',
      );
    },
  );
}
