import 'package:flutter/material.dart';
import 'package:noted_app/models/new_note_route_arguments.dart';
import 'package:noted_app/pages/note_list_vm.dart';
import 'package:noted_app/router/route_constants.dart';
import 'package:noted_app/widgets/note_tile.dart';
import 'package:provider/provider.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({Key? key}) : super(key: key);

  @override
  _NoteListPageState createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  @override
  void initState() {
    super.initState();
    final model = Provider.of<NoteListViewModel>(context, listen: false);
    model.updateList();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<NoteListViewModel>(context);
    model.updateList();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            NewNoteRoute,
            arguments: NewNoteRouteArguments(
              titleText: 'Create new task',
              buttonText: 'Add Task',
            ),
          );

          final model = Provider.of<NoteListViewModel>(context, listen: false);
          model.updateList();
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 60,
                ),
                child: Text(
                  'My Tasks',
                  style: TextStyle(fontSize: 28),
                ),
              ),
              Consumer<NoteListViewModel>(
                builder: (context, model, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return NoteTile(
                        title: model.notesList[index].title,
                        description: model.notesList[index].description,
                        onPress: () {
                          Navigator.pushNamed(
                            context,
                            NewNoteRoute,
                            arguments: NewNoteRouteArguments(
                              titleText: 'Edit your task',
                              buttonText: 'Update Task',
                            ),
                          );

                          model.updateList();
                        },
                      );
                    },
                    itemCount: model.length,
                  );
                },
              ),
              SizedBox(height: 96),
            ],
          ),
        ),
      ),
    );
  }
}
