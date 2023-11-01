import 'package:phone_app/phone.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sql.dart';

class DbHelper {
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""
        CREATE TABLE phones(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          phone_name TEXT NOT NULL,
          phone_detail TEXT NOT NULL
        )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('phone.db',
        version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTable(database);
    });
  }
  static Future<void> savePhone(Phone phone) async {
    final db = await DbHelper.db();
    db.insert('phones', phone.toJson());
  }
  static Future<List<Phone>> getPhones() async {
    final db = await DbHelper.db();
    final jsonPhones = await db.query('phones',orderBy: 'id');
    final List<Phone> phoneList = [];
    for(var i in jsonPhones) {
      phoneList.add(Phone.fromJson(i));
    }
    return phoneList;
  }
  static Future<int> update(int? id, Phone phone) async {
    final db = await DbHelper.db();
    return db.update('phones', phone.toJson(), where: 'id = ?',whereArgs: [id]);
  }
  static Future<void> delete(int? id) async {
    final db = await DbHelper.db();
    db.delete('phones', where: "id = ?", whereArgs: [id]);
  }
}










