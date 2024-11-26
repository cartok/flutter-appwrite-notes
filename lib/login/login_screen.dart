import 'package:flutter/material.dart';
import 'package:notes_tasks/login/widgets/login_form.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: LoginForm(),
      ),
      // TODO: Temporary
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: 20.sp),
            ListTile(
              title: const Text('Notes'),
              onTap: () {
                Navigator.pushNamed(context, '/notes');
              },
            ),
          ],
        ),
      ),
    );
  }
}
