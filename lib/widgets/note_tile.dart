import 'package:flutter/material.dart';

class NoteTile extends StatefulWidget {
  const NoteTile({
    Key? key,
    required this.onPress,
    required this.title,
    required this.description,
  }) : super(key: key);

  final onPress;
  final String title;
  final String description;

  @override
  _NoteTileState createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: widget.onPress,
        // leading: FlutterLogo(size: 40.0),
        title: Text(widget.title),
        subtitle: Text(widget.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
            Icon(
              Icons.delete,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
