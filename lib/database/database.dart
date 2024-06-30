import 'package:drift/drift.dart';

// These additional imports are necessary to open the sqlite3 database
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'database.g.dart';

class TodoItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withDefault(const Constant(""))();

  // TextColumn get des => text().withDefault(const Constant(""))();
  // TextColumn get mark => text().withDefault(const Constant(""))();

  TextColumn get content => text().named('body')();

  IntColumn get category =>
      integer().nullable().references(TodoCategory, #id)();

  DateTimeColumn get createdAt => dateTime().nullable()();
}

class TodoCategory extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get description => text()();
}

@DriftDatabase(tables: [TodoItems, TodoCategory])
class AppDatabase extends _$AppDatabase {
  final Directory dbDir;
  final Directory tempFolder;

  final String sqliteFileName;

  AppDatabase(
      {required this.dbDir,
      required this.tempFolder,
      required this.sqliteFileName})
      : super(_openConnection(dbDir, tempFolder, sqliteFileName));

  @override
  int get schemaVersion => 12;

  // implement migration
  MigrationStrategy get migration {
    return MigrationStrategy(
      // onCreate is called only if no database has been created locally

        onCreate: (Migrator m) async {
          print("onCreate");
          await m.createAll();
        },


        // This will only fire if the current application version is greater than the local database version
        // It runs before any queries
        // from: from is the current version of the local database
        // to: to is the version number of the program currently running, which is schemaVersion

        onUpgrade: (Migrator m, int from, int to) async {
          print("onUpgrade from is $from to is $to");
          if(from<4){
            // not run
            print("addColumn todoItems.des");
            // await m.addColumn(todoItems, todoItems.des);
          }

          if (from<5){
            print("addColumn todoItems.mark");
            // await m.addColumn(todoItems, todoItems.mark);
          }

          if (from<6){
            print("alterTable");
            await m.alterTable(TableMigration(todoItems));

          }

          if (from<7){
            print("alterTable");
            await m.alterTable(TableMigration(todoItems));

          }

          if (from<8){
            print("columnTransformer");
            await m.alterTable(TableMigration(todoItems, columnTransformer: {
              todoItems.content: const Constant("columnTransformer"),
            }));

          }

          if (from<9){
            print("deleteTable");
            await m.deleteTable(todoItems.actualTableName);

          }

          if (from<10){
            print("createTable");
            await m.createTable(todoItems);
          }

          if (from<11){
            print("deleteTable all");
            await m.deleteTable(todoItems.actualTableName);
            await m.deleteTable(todoCategory.actualTableName);
          }

          if (from<12){
            print("createAll");
            await m.createAll();
          }
        },


        // Run before opening the database
        // It runs after migrations, but before any other query

        beforeOpen: (OpeningDetails details) async {
          print("beforeOpen details versionNow ${details.versionNow}");
          // The schema version after running migrations.
          // onUpgrade to
          print("beforeOpen details versionBefore ${details.versionBefore}");
          // When onCreate is triggered, it is set to true
          print("beforeOpen details wasCreated ${details.wasCreated}");
          // When onUpgrade is triggered, it is set to true
          print("beforeOpen details hadUpgrade ${details.hadUpgrade}");
        });
  }

}

LazyDatabase _openConnection(dbDir, tempFolder, sqliteFileName) {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final file = File(p.join(dbDir.path, '$sqliteFileName.sqlite'));
    print(file.path);

    // Also work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final cachebase = tempFolder.path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file, setup: (rawDb) {
      rawDb.execute('PRAGMA journal_mode=WAL;');
      rawDb.execute('PRAGMA busy_timeout = 100;');
    });
  });
}
