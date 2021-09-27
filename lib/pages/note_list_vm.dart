import 'package:flutter/cupertino.dart';
import 'package:noted_app/models/note.dart';
import 'package:noted_app/services/database_handler.dart';

class NoteListViewModel with ChangeNotifier {
  List<NoteModel> _notesList = [];
  DatabaseHandler databaseHandler = DatabaseHandler.instance;
  bool isLoading = true;

  List<NoteModel> get notesList => _notesList;

  int get length => _notesList.length;

  void updateList() async {
    _notesList = await databaseHandler.getNoteList();
    isLoading = false;
    notifyListeners();
  }

  void deleteNote(int id) async {
    print('ddd $id');
    isLoading = true;

    int result = await databaseHandler.deleteNote(id);
    _notesList.removeWhere((element) => element.id == id);

    print(result);
    isLoading = false;

    notifyListeners();
  }

  void updateStatus(NoteModel note, bool isDone) async {
    isDone ? note.isDone = 1 : note.isDone = 0;

    print(note.isDone);
    databaseHandler.updateNote(note);

    notifyListeners();
  }
}
