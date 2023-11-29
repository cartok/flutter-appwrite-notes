import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:notes_tasks/notes/bloc/note_bloc.dart';
import 'package:notes_tasks/notes/widgets/notes_list.dart';
import 'package:sizer/sizer.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes List')),
      body: Container(
        padding: EdgeInsets.all(10.sp),
        child: Stack(
          // alignment: AlignmentGeometry.lerp(a, b, t),
          children: [
            BlocProvider(
              create: (_) => NoteBloc()..add(RequestNotes()),
              child: const NotesList(),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: FloatingActionButton(
                onPressed: () {
                  showAboutDialog(context: context);
                },
                child: Icon(Icons.add),
              ),
            )
          ],
        ),
      ),
    );
  }
}
