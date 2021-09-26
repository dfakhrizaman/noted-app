import 'package:flutter/material.dart';

class ConfirmAlert extends StatelessWidget {
  const ConfirmAlert({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure?"),
      content: Text("This draft will be discarded."),
      actions: [
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text("Discard"),
          onPressed: () {
            var nav = Navigator.of(context);
            nav.pop();
            nav.pop();
          },
        ),
      ],
    );
  }
}
