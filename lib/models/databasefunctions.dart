import 'package:sqflite/sqflite.dart';

class databasef {
  static Database? database;

  static Future<void> createDb() async {
    database = await openDatabase(
      'todotask',
      version: 1,
      onCreate: (Database db, int version) async {
        print('database created');
        await db
            .execute(
                'CREATE TABLE ToDoTasks (id INTEGER PRIMARY KEY, task TEXT, time TEXT, date TEXT)')
            .catchError((error) => print("error${error.toString()}"));
      },
    );
  }

  static Future insertDb(
      {required String task,
      required String time,
      required String date}) async {
    return await database?.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO ToDoTasks(task, time, date) VALUES("${task}", "${time}", "${date}")')
          .then((value) => print('insert successfuly'));
    });
  }

}
