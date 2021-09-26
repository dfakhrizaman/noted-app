import 'package:flutter/material.dart';
import 'package:noted_app/pages/note_list_page.dart';
import 'package:noted_app/pages/note_list_vm.dart';
import 'package:noted_app/router/route_constants.dart';
import 'package:provider/provider.dart';
import 'router/router.dart' as router;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NoteListViewModel>(
      create: (_) => NoteListViewModel(),
      child: MaterialApp(
        title: 'Noted',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          // primaryColor: Colors.grey[800],
        ),
        onGenerateRoute: router.generateRoute,
        initialRoute: NoteListRoute,
        home: NoteListPage(),
      ),
    );
  }
}
