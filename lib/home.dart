// import 'package:drift/drift.dart' as drift;
// import 'package:flutter_drift_example/database/DBTodoHelper.dart';
// import 'package:flutter/material.dart';
//
// import 'database/database.dart';
// import 'main.dart';
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   void _insert() {
//     database.into(database.todoItems).insert(TodoItemsCompanion.insert(
//         title: "title_text", content: "content_test"));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // IconButton(
//             //     onPressed: () {
//             //       insertModel();
//             //     },
//             //     icon: Text("insertModel")),
//             // IconButton(
//             //     onPressed: () {
//             //       insertModelCompanion();
//             //     },
//             //     icon: Text("insertModelCompanion")),
//             //
//             // IconButton(
//             //     onPressed: () {
//             //       insertReturningModel();
//             //     },
//             //     icon: Text("insertReturningModel")),
//             // IconButton(
//             //     onPressed: () {
//             //       insertReturningModelCompanion();
//             //     },
//             //     icon: Text("insertReturningModelCompanion")),
//
//             // IconButton(
//             //     onPressed: () {
//             //       getAll();
//             //     },
//             //     icon: Text("getAll")),
//             //
//             // IconButton(
//             //     onPressed: () {
//             //       getAllByTitle("insertModel title");
//             //     },
//             //     icon: Text("getAllByTitle")),
//
//             // IconButton(
//             //     onPressed: () {
//             //       getSingleOrNull();
//             //     },
//             //     icon: Text("getSingleOrNull")),
//             //
//             // IconButton(
//             //     onPressed: () {
//             //       getSingleOrNullById();
//             //     },
//             //     icon: Text("getSingleOrNullById")),
//             //
//             // IconButton(
//             //     onPressed: () {
//             //       getSingleOrNullByTitle("title_text");
//             //     },
//             //     icon: Text("getSingleOrNullByTitle")),
//
//             // IconButton(
//             //     onPressed: () {
//             //       updateTitle();
//             //     },
//             //     icon: Text("updateTitle")),
//             //
//             // IconButton(
//             //     onPressed: () {
//             //       updateTitleById();
//             //     },
//             //     icon: Text("updateTitleById")),
//
//             // IconButton(
//             //     onPressed: () {
//             //       replaceModel();
//             //     },
//             //     icon: Text("replaceModel")),
//             //
//             // IconButton(
//             //     onPressed: () {
//             //       replaceModelCompanion();
//             //     },
//             //     icon: Text("replaceModelCompanion")),
//
//             IconButton(
//                 onPressed: () {
//                   deleteById();
//                 },
//                 icon: Text("deleteById")),
//
//             IconButton(
//                 onPressed: () {
//                   deleteAll();
//                 },
//                 icon: Text("deleteAll")),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _insert,
//         tooltip: 'Insert',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
//
//   void insertModel() {
//     DBTodoHelper.insertModel(TodoItem(
//         id: 3, title: "insertModel title", content: "insertModel content"));
//   }
//
//   void insertModelCompanion() {
//     DBTodoHelper.insertModelCompanion(TodoItemsCompanion.insert(
//         title: "insertModelCompanion title",
//         content: "insertModelCompanion content"));
//   }
//
//   Future<void> insertReturningModel() async {
//     TodoItem? model = await DBTodoHelper.insertReturningModel(TodoItem(
//         id: 8, title: "insertModel title", content: "insertModel content"));
//     print("insertReturningModel model is $model");
//   }
//
//   Future<void> insertReturningModelCompanion() async {
//     TodoItem? model = await DBTodoHelper.insertReturningModelCompanion(
//         TodoItemsCompanion.insert(
//             title: "insertModelCompanion title",
//             content: "insertModelCompanion content"));
//     print("insertReturningModelCompanion model is $model");
//   }
//
//   Future<void> getAll() async {
//     List<TodoItem> list = await DBTodoHelper.getAll();
//     print("list is $list");
//     print("list length is ${list.length}");
//   }
//
//   Future<void> getAllByTitle(String title) async {
//     List<TodoItem> list = await DBTodoHelper.getAllByTitle(title);
//     print("list is $list");
//     print("list length is ${list.length}");
//   }
//
//   Future<void> getSingleOrNull() async {
//     TodoItem? model = await DBTodoHelper.getSingleOrNull();
//     print("getSingleOrNull model is $model");
//   }
//
//   Future<void> getSingleOrNullById() async {
//     TodoItem? model = await DBTodoHelper.getSingleOrNullById(3);
//     print("getSingleOrNullById model is $model");
//   }
//
//   Future<void> getSingleOrNullByTitle(String title) async {
//     TodoItem? model = await DBTodoHelper.getSingleOrNullByTitle(title);
//     print("getSingleOrNullByTitle model is $model");
//   }
//
//   Future<void> updateTitle() async {
//     await DBTodoHelper.updateTitle("updateTitle");
//   }
//
//   Future<void> updateTitleById() async {
//     await DBTodoHelper.updateTitleById(1, "updateTitleById");
//   }
//
//   Future<void> replaceModel() async {
//     TodoItem? item = await DBTodoHelper.getSingleOrNullById(4);
//     TodoItem model = TodoItem(
//         id: item!.id, title: item!.title, content: "replaceModel content");
//     await DBTodoHelper.replaceModel(model);
//   }
//
//   Future<void> replaceModelCompanion() async {
//     TodoItem? model = await DBTodoHelper.getSingleOrNullById(6);
//     TodoItemsCompanion companion = model!.toCompanion(false);
//     await DBTodoHelper.replaceModelCompanion(companion.copyWith(
//         content: drift.Value("replaceModelCompanion content")));
//   }
//
//   Future<void> deleteById() async {
//     await DBTodoHelper.deleteById(8);
//     await DBTodoHelper.deleteById(9);
//     await DBTodoHelper.deleteById(10);
//   }
//
//   Future<void> deleteAll() async {
//     await DBTodoHelper.deleteAll();
//   }
// }
