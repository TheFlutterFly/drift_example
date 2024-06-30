import 'package:drift/drift.dart';
import 'package:flutter_drift_example/main.dart';

import 'database.dart';

class DBTodoHelper {
  /// insert
  static Future<void> insertModel(TodoItem model) async {
    await database.into(database.todoItems).insert(model);
  }

  static Future<void> insertModelCompanion(
      TodoItemsCompanion modelCompanion) async {
    await database.into(database.todoItems).insert(modelCompanion);
  }

  static Future<TodoItem?> insertReturningModel(TodoItem model) async {
    return await database.into(database.todoItems).insertReturning(model);
  }

  static Future<TodoItem?> insertReturningModelCompanion(
      TodoItemsCompanion modelCompanion) async {
    return await database
        .into(database.todoItems)
        .insertReturning(modelCompanion);
  }

  /// get
  static Future<List<TodoItem>> getAll() async {
    return await database.managers.todoItems.get();
  }

  static Future<List<TodoItem>> getAllByTitle(String title) async {
    return await database.managers.todoItems
        .filter((f) => f.title(title))
        .get();
  }

  static Future<TodoItem?> getSingleOrNull() async {
    return await database.managers.todoItems.getSingleOrNull();
  }

  static Future<TodoItem?> getSingleOrNullById(int id) async {
    return await database.managers.todoItems
        .filter((f) => f.id(id))
        .getSingleOrNull();
  }

  static Future<TodoItem?> getSingleOrNullByTitle(String title) async {
    return await database.managers.todoItems
        .filter((f) => f.title(title))
        .getSingleOrNull();
  }

  /// update
  static Future<void> updateTitle(String title) async {
    await database.managers.todoItems.update((o) => o(title: Value(title)));
  }

  static Future<void> updateTitleById(int id, String title) async {
    await database.managers.todoItems
        .filter((f) => f.id(id))
        .update((o) => o(title: Value(title)));
  }

  static Future<void> replaceModel(TodoItem model) async {
    await database.managers.todoItems.replace(model);
  }

  static Future<void> replaceModelCompanion(
      TodoItemsCompanion modelCompanion) async {
    await database.managers.todoItems.replace(modelCompanion);
  }

  /// delete
  static Future<void> deleteById(int id) async {
    await database.managers.todoItems.filter((f) => f.id(id)).delete();
  }

  static Future<void> deleteAll() async {
    await database.managers.todoItems.delete();
  }
}
