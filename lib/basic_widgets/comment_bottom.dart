import 'package:flutter/material.dart';

class CommentButtom extends StatelessWidget {
  final Widget _commentEditor;
  CommentButtom(this._commentEditor);
  @override
  Widget build(context) {
    return FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.comment,
          color: Colors.red,
        ),
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return _commentEditor;
            }));
  }
}
