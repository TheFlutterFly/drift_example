import 'package:flutter_drift_example/database/DBTodoHelper.dart';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;

import 'database/database.dart';

class MigrationTestPage extends StatefulWidget {
  const MigrationTestPage({super.key});

  @override
  State<MigrationTestPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MigrationTestPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("MigrationTestPage"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
                onPressed: () {
                  insertModelCompanion();
                },
                icon: const Text("insertModelCompanion")),
            IconButton(
                onPressed: () {
                  getAll();
                },
                icon: const Text("getAll")),

          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

    void insertModelCompanion() {
    DBTodoHelper.insertModelCompanion(TodoItemsCompanion.insert(
        title: const drift.Value("insertModelCompanion title"),
        content: "insertModelCompanion content"));
  }

  Future<void> getAll() async {
    List<TodoItem> list = await DBTodoHelper.getAll();
    print("list is $list");
  }
}
