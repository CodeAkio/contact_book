import 'package:path/path.dart';

import 'package:contact_book/shared/models/contact_model.dart';
import 'package:sqflite/sqflite.dart';

class ContactHelper {
  static const String contactTable = "contacts";
  static const String idColumn = "id";
  static const String nameColumn = "name";
  static const String emailColumn = "email";
  static const String phoneColumn = "phone";
  static const String imgColumn = "img";

  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  ContactHelper.internal();

  Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initDb();
      return _db!;
    }
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "contacts.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int newVesion) async {
        await db.execute("CREATE TABLE $contactTable("
            "$idColumn INTEGER PRIMARY KEY, "
            "$nameColumn VARCHAR, "
            "$emailColumn VARCHAR, "
            "$phoneColumn VARCHAR, "
            "$imageColumn VARCHAR)");
      },
    );
  }
}
