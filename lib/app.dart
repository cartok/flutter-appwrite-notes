import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:notes_tasks/notes/notes_screen.dart';
import 'package:notes_tasks/login/login_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes & Tasks',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        initialRoute: '/notes',
        routes: {
          // TODO: Skip login screen if possible.
          '/': (context) => const LoginScreen(),
          '/login': (context) => const LoginScreen(),
          '/notes': (context) => const NotesScreen(),
        },
      );
    });
  }
}
