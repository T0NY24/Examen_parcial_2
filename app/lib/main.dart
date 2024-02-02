import 'package:flutter/material.dart';
import 'todoapp.dart';
import 'app_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-do-App',
      theme: AppTheme.customTheme,
      home: Scaffold(
        backgroundColor: AppTheme.purple500,
        body: SafeArea(
          child: TodoListScreen(),
        ),
      ),
    );
  }
}
