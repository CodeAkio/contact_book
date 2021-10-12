import 'package:path/path.dart';

import 'package:contact_book/shared/models/contact_model.dart';
import 'package:sqflite/sqflite.dart';

class ContactHelper {
  static const String contactTable = "contacts";
  static const String idColumn = "id";
  static const String nameColumn = "name";
  static const String emailColumn = "email";
  static const String phoneColumn = "phone";
  static const String imageColumn = "image";

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

  Future<Contact> saveContact(Contact contact) async {
    Database dbContact = await db;

    contact.id = await dbContact.insert(contactTable, contact.toMap());

    return contact;
  }

  Future<Contact?> getContact(int id) async {
    Database dbContact = await db;

    List<Map<String, dynamic>> maps = await dbContact.query(contactTable,
        columns: [idColumn, nameColumn, emailColumn, phoneColumn, imageColumn],
        where: "$idColumn = ?",
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Contact.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteContact(int id) async {
    Database dbContact = await db;

    return await dbContact
        .delete(contactTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateContact(Contact contact) async {
    Database dbContact = await db;

    return await dbContact.update(contactTable, contact.toMap(),
        where: "$idColumn = ?", whereArgs: [contact.id]);
  }

  Future<List<Contact>> getAllContacts() async {
    Database dbContact = await db;

    List<Map<String, dynamic>> listMap =
        await dbContact.rawQuery("SELECT * FROM $contactTable");

    List<Contact> listContact = [];

    for (var m in listMap) {
      listContact.add(Contact.fromMap(m));
    }

    return listContact;
  }

  Future<int?> getNumber() async {
    Database dbContact = await db;

    return Sqflite.firstIntValue(
        await dbContact.rawQuery("SELECT COUNT(*) FROM $contactTable"));
  }

  Future close() async {
    Database dbContact = await db;

    dbContact.close();
  }
}
