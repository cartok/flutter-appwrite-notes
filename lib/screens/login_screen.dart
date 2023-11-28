// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:notes_tasks/screens/notes_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscure = true;
  final TextEditingController controller = TextEditingController();
  final Future<SharedPreferences> storage = SharedPreferences.getInstance();
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.sp),
        child: Column(
          children: [
            TextField(
              controller: controller,
              obscureText: obscure,
              decoration: InputDecoration(
                label: Text('Password'),
                suffixIcon: IconButton(
                  onPressed: () => setState(() => obscure = !obscure),
                  icon: Icon(Icons.visibility),
                ),
              ),
            ),
            SizedBox(height: 20.sp),
            ElevatedButton(
              onPressed: () async {
                // REFACTOR
                // --------------------------------------------------------------------
                // final password = await storage.then(
                //     (value) => value.getString(SetPasswordScreen.passwordKey));
                // if (!context.mounted) return;

                if ('foo' == controller.text) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotesScreen(),
                    ),
                  );
                } else {
                  fToast.showToast(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 12.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.deepPurple,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Wrong password',
                              style: TextStyle(color: Colors.white)),
                          SizedBox(width: 5.sp),
                          Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    gravity: ToastGravity.TOP,
                    toastDuration: Duration(seconds: 2),
                  );
                }
              },
              child: Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}
