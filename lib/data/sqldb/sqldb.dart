import 'package:accounts_book/core/constant/constant.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _db;

  Future<Database> get db async {
    _db ??= await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, AppConstants.dbName);
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 2,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Perform necessary upgrades for version 2
      await db.execute('DROP TABLE IF EXISTS Customer');
      await _onCreate(db, newVersion);
    }
    print("onUpgrade =====================================");
  }

  Future<void> _onCreate(Database db, int version) async {
    var batch = db.batch();

    batch.execute('''
    CREATE TABLE "Customer" (
      "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
      "userType" INTEGER NOT NULL, 
      "name" TEXT NOT NULL, 
      "phone" TEXT NOT NULL,
      "phone2" TEXT NOT NULL,
      "address" TEXT NOT NULL,
      "create_at" TEXT NOT NULL,
      "update_at" TEXT NOT NULL
    )
    ''');

    batch.execute('''
    CREATE TABLE "Category" (
      "id" INTEGER NOT NULL PRIMARY KEY, 
      "type" INTEGER NOT NULL, 
      "name" TEXT NOT NULL, 
      "des" TEXT NOT NULL
    )
    ''');

    batch.execute('''
    CREATE TABLE "CatchReceipt" (
      "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "name" TEXT NOT NULL, 
      "customer_id" INTEGER NOT NULL, 
      "price" INTEGER NOT NULL, 
      "total" INTEGER NOT NULL, 
      "for_him" INTEGER NOT NULL, 
      "customer_name" TEXT NOT NULL,
      "create_at" TEXT NOT NULL,
      "update_at" TEXT NOT NULL
    )
    ''');

    batch.execute('''
    CREATE TABLE "Purchasing" (
      "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
      "name" TEXT NOT NULL, 
      "price" INTEGER NOT NULL, 
      "total" INTEGER NOT NULL, 
      "type" INTEGER NOT NULL, 
      "category_id" INTEGER NOT NULL, 
      "category_name" TEXT NOT NULL,
      "note" TEXT,
      "create_at" TEXT NOT NULL,
      "update_at" TEXT NOT NULL
    )
    ''');

    await batch.commit();
    print("onCreate =====================================");
  }

  Future<List<Map<String, dynamic>>> readData(String sql) async {
    Database mydb = await db;
    return await mydb.rawQuery(sql);
  }

  Future<int> insertData(String sql) async {
    Database mydb = await db;
    return await mydb.rawInsert(sql);
  }

  Future<int> updateData(String sql) async {
    Database mydb = await db;
    return await mydb.rawUpdate(sql);
  }

  Future<int> deleteData(String sql) async {
    Database mydb = await db;
    return await mydb.rawDelete(sql);
  }

  Future<List<Map<String, dynamic>>> read(String table) async {
    Database mydb = await db;
    return await mydb.query(table);
  }

  Future<List<Map<String, dynamic>>> readCondition(String table, String where) async {
    Database mydb = await db;
    return await mydb.query(table, where: where);
  }

  Future<int> insert(String table, Map<String, dynamic> map) async {
    Database mydb = await db;
    return await mydb.insert(table, map);
  }

  Future<int> insertCat(String table, Map<String, dynamic> map) async {
    Database mydb = await db;
    return await mydb.insert(table, map, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> update(String table, Map<String, dynamic> map, String where) async {
    Database mydb = await db;
    return await mydb.update(table, map, where: where);
  }

  Future<int> delete(String table, String where,int arg) async {
    Database mydb = await db;
    return await mydb.delete(table, where: where,whereArgs: [arg]);
  }

  Future<void> mDeleteDataBase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, AppConstants.dbName);
    await deleteDatabase(path);
  }

  Future<String> mGetDatabasesPath() async {
    return await getDatabasesPath();
  }







}