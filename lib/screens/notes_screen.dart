// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 30.h,
            width: 80.w,
            child: Column(
              children: [
                Text('New note'),
                TextField(controller: _controller),
                Container(
                  height: 20.sp,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(onPressed: () {}, child: Text('save')),
                      ElevatedButton(
                        onPressed: Navigator.of(context).pop,
                        child: Text('abort'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          createNewTask();
        },
      ),
      appBar: AppBar(
        title: const Text('Notes'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.sp),
        child: Column(children: [
          Text('Open Tasks'),
          SizedBox(height: 2.sp),
          // TODO: NoteList
        ]),
      ),
    );
  }
}
