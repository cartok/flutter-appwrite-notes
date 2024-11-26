import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:notes_tasks/appwrite/account.dart';
import 'package:notes_tasks/prefs.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  User? _loggedInUser;
  bool _obscurePassword = true;

  final TextEditingController _emailController = TextEditingController(
    text: prefs!.getString('userEmail'),
  );
  final TextEditingController _passwordController = TextEditingController(
    text: prefs!.getString('userPassword'),
  );

  @override
  void initState() {
    _emailController.addListener(() {
      if (_loggedInUser == null) {
        prefs!.setString('userEmail', _emailController.text);
      }
    });
    _passwordController.addListener(() {
      if (_loggedInUser == null) {
        prefs!.setString('userPassword', _passwordController.text);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: () async {
        try {
          print('Try to login.');
          return await account.get();
          // TODO: Automatically redirect if still logged in but create Navigation UI first.
        } catch (e) {
          print('Could not login.');
          print(e);
        }
      }(),
      builder: (context, snapshot) {
        print('LoginForm $snapshot');

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          _loggedInUser = snapshot.data;

          return Container(
            padding: EdgeInsets.all(20.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_loggedInUser != null
                    ? 'Logged in as ${_loggedInUser!.name}'
                    : 'Not logged in'),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.remove_red_eye),
                      onPressed: () => setState(() {
                        _obscurePassword = !_obscurePassword;
                      }),
                    ),
                  ),
                  obscureText: _obscurePassword,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    login(_emailController.text, _passwordController.text);
                  },
                  child: const Text('Login'),
                ),
                ElevatedButton(
                  onPressed: () {
                    register(
                      _emailController.text,
                      _passwordController.text,
                    );
                  },
                  child: const Text('Register'),
                ),
                // The OAUTH Section
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.sp),
                  child: Column(
                    children: [
                      Text('Login via ...'),
                      SizedBox(height: 5.sp),
                      Wrap(
                        direction: Axis.vertical,
                        spacing: 5.sp,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              print('auth asdfasdf');
                              final foo = await account.createOAuth2Session(
                                provider: 'github',
                              );
                              print('auth result: $foo');
                            },
                            child: const Text('Github'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final foo = await account.createOAuth2Session(
                                provider: 'google',
                              );
                              print(foo);
                            },
                            child: const Text('Google'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    logout();
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<void> login(String email, String password) async {
    await account.createEmailSession(email: email, password: password);
    final user = await account.get();

    setState(() {
      _loggedInUser = user;
    });

    Navigator.pushNamed(context, '/notes');
  }

  Future<void> register(String email, String password) async {
    try {
      await account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
      await login(email, password);

      Navigator.pushNamed(context, '/notes');
    } catch (exception) {
      // This should be logged on the server but the user must not be informed that there is an
      // account with the given email.
      print('LoginForm { email: $email }');
      print(exception);
    }
  }

  Future<void> logout() async {
    await account.deleteSession(sessionId: 'current');
    setState(() {
      _loggedInUser = null;
    });
  }
}
