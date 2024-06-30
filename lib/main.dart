import 'dart:io';

import 'package:flutter_drift_example/home.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'database/database.dart';
import 'migration_test_page.dart';

String sqliteFileName = "driftExample";
late AppDatabase database;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppDatabase();

  runApp(const MyApp());
}

Future<void> initAppDatabase() async {
  Directory appDocDir = await getApplicationDocumentsDirectory();

  Directory dbDir = Directory('${appDocDir.path}/$sqliteFileName');

  // Check if the data store directory exists and create it if not
  if (!await dbDir.exists()) {
    await dbDir.create();
    print('Folder created at: ${dbDir.path}');
  } else {
    print('Folder already exists at: ${dbDir.path}');
  }

  /// Create an AppDatabase instance
  database = AppDatabase(
      dbDir: dbDir, tempFolder: dbDir, sqliteFileName: sqliteFileName);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const MigrationTestPage(),
    );
  }
}
