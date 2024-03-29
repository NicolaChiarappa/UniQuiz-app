import 'auth.dart';
import './src/pages/home.dart';
import './src/pages/loginpage.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});
  @override
  State<WidgetTree> createState() => _WidgetTree();
}

class _WidgetTree extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const MainPage();
          } else {
            return const LoginPage();
          }
        });
  }
}
