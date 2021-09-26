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
}
