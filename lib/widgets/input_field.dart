import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.hintText,
    required this.onTextChange,
    required this.isMultiLine,
  }) : super(key: key);

  final String hintText;
  final Function onTextChange;

  final bool isMultiLine;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: isMultiLine ? TextInputType.multiline : TextInputType.text,
      minLines: isMultiLine ? 6 : 1, //Normal textInputField will be displayed
      maxLines: isMultiLine ? 6 : 1, // when user presses enter it will adapt
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        filled: true,
        hintText: hintText,
        fillColor: Colors.white70,
      ),
      onChanged: (value) {
        onTextChange(value);
      },
    );
  }
}
