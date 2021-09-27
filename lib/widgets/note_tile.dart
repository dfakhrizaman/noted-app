import 'package:flutter/material.dart';
import 'package:noted_app/models/note.dart';
import 'package:noted_app/pages/note_list_vm.dart';
import 'package:provider/provider.dart';

class NoteTile extends StatefulWidget {
  const NoteTile({
    Key? key,
    required this.onPress,
    required this.title,
    required this.description,
    required this.note,
  }) : super(key: key);

  final onPress;
  final String title;
  final String description;
  final NoteModel note;

  @override
  _NoteTileState createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<NoteListViewModel>(context);

    return Card(
      child: ListTile(
        onTap: () {
          openBottomSheet(context);
        },
        title: Text(widget.title),
        subtitle: Text(widget.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: widget.note.isDone == 1 ? true : false,
              onChanged: (value) {
                setState(() {
                  isChecked = value!;

                  model.updateStatus(widget.note, isChecked);
                });
              },
            ),
            IconButton(
              onPressed: () {
                //? Delete task
                model.deleteNote(widget.note.id);
              },
              icon: Icon(
                Icons.delete,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> openBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        var note = widget.note;

        return Wrap(children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  note.date,
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(height: 12),
                Text(
                  note.description,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Close'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]);
      },
    );
  }
}
