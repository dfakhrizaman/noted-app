import 'package:flutter/material.dart';
import 'package:noted_app/models/new_note_route_arguments.dart';
import 'package:noted_app/models/note.dart';
import 'package:noted_app/pages/new_note_vm.dart';
import 'package:noted_app/widgets/confirm_alert.dart';
import 'package:noted_app/widgets/input_field.dart';
import 'package:provider/provider.dart';

class NewNotePage extends StatefulWidget {
  const NewNotePage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final NewNoteRouteArguments arguments;

  @override
  _NewNotePageState createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewNoteViewModel>(
      create: (_) => NewNoteViewModel(),
      child: WillPopScope(
        onWillPop: () async {
          bool willLeave = false;

          // show the confirm dialog
          await showDialog(
            context: context,
            builder: (_) => ConfirmAlert(),
          );
          return willLeave;
        },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Consumer<NewNoteViewModel>(
                builder: (context, model, child) {
                  return Column(
                    children: [
                      // Title
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(
                          '${widget.arguments.titleText}',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),

                      // Task Name Field
                      InputField(
                        hintText: 'Task name',
                        onTextChange: (value) {
                          model.changeTitle(value);
                        },
                        isMultiLine: false,
                      ),

                      // Description Field
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: InputField(
                          hintText: 'Write your description here...',
                          onTextChange: (value) {
                            model.changeDescription(value);
                          },
                          isMultiLine: true,
                        ),
                      ),

                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                model.createDate();

                                print(model.date);
                                print(model.title);
                                print(model.description);

                                model.addNote(
                                  NoteModel(
                                    title: model.title,
                                    description: model.description,
                                    date: model.date,
                                  ),
                                );

                                Navigator.pop(context);
                              },
                              child: Text(
                                '${widget.arguments.buttonText}',
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ConfirmAlert();
                                  },
                                );
                              },
                              child: Text('Cancel'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
