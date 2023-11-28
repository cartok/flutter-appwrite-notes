import 'package:flutter/material.dart';

class MyDrawerScreens {
  final String title;
  final Widget Function(BuildContext) builder;

  const MyDrawerScreens(this.title, this.builder);
}

class MyDrawer extends StatelessWidget {
  final List<MyDrawerScreens> screens;

  const MyDrawer({
    super.key,
    required this.screens,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: screens
            .map((e) => ListTile(
                  title: Text(e.title),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: e.builder,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
