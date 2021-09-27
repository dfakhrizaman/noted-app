import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:noted_app/models/note.dart';
import 'package:noted_app/services/database_handler.dart';

class NewNoteViewModel with ChangeNotifier {
  DatabaseHandler databaseHandler = DatabaseHandler.instance;

  String _title = '';
  String _description = '';
  String _date = '';

  String get title => _title;
  String get description => _description;
  String get date => _date;

  void changeTitle(String newValue) {
    _title = newValue;
  }

  void changeDescription(String newValue) {
    _description = newValue;
  }

  String createDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd/MM/yyyy');
    _date = formatter.format(now);

    return _date;
  }

  void addNote(NoteModel note) async {
    note.date = createDate();

    int result = await databaseHandler.insertNote(note);
    print(result);
    notifyListeners();
  }
}
