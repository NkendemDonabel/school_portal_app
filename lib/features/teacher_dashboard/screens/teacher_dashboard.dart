import 'package:flutter/material.dart';
import 'teacher_dashboard_screen.dart';

void main() {
  runApp(const TeacherDashboardApp());
}

class TeacherDashboardApp extends StatelessWidget {
  const TeacherDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Teacher Dashboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const TeacherDashboardScreen(),
    );
  }
}