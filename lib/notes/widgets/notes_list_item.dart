import 'package:flutter/material.dart';

import 'package:notes_tasks/notes/models/note.dart';

class NotesListItem extends StatelessWidget {
  const NotesListItem({required this.note, super.key});

  final Note note;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text('${note.index}', style: textTheme.bodySmall),
        title: Text(note.text),
        isThreeLine: true,
        subtitle: const Text('need some ui..'),
        dense: true,
      ),
    );
  }
}
