import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:notes_tasks/app.dart';
import 'package:notes_tasks/prefs.dart';
import 'package:notes_tasks/bloc_logs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await dotenv.load(fileName: ".env");

  // TODO: Understand `runZoned` and replace cause deprecated.
  BlocOverrides.runZoned(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(const App());
    },
    blocObserver: BlocLogs(),
  );
}
