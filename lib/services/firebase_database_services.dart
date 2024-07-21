import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gemini_app/models/todo_model.dart';

const String TODO_REF = 'todos';

class DBServices {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _todoRef;

  DBServices() {
    _todoRef = _firestore.collection(TODO_REF).withConverter<TodoModel>(
        fromFirestore: (snapshot, _) => TodoModel.fromJson(snapshot.data()!),
        toFirestore: (todo, _) => todo.toJson());
  }

  Stream<QuerySnapshot> getTodos() {
    return _todoRef.snapshots();
  }

  void addTodo(TodoModel todo) async {
    _todoRef.add(todo);
  }

  void updateTodo(String todoId, TodoModel todo) {
    _todoRef.doc(todoId).update(todo.toJson());
  }

  void deleteTodo(String todoId) {
    _todoRef.doc(todoId).delete();
  }
}
