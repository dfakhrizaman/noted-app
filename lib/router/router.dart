import 'package:flutter/material.dart';
import 'package:noted_app/models/new_note_route_arguments.dart';
import 'package:noted_app/pages/new_note_page.dart';
import 'package:noted_app/pages/note_list_page.dart';
import 'route_constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case NoteListRoute:
      return MaterialPageRoute(
        builder: (_) => NoteListPage(),
      );
    case NewNoteRoute:
      NewNoteRouteArguments arguments =
          settings.arguments as NewNoteRouteArguments;

      return MaterialPageRoute(
        builder: (_) => NewNotePage(arguments: arguments),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}
