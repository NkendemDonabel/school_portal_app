import 'package:flutter/material.dart';
import 'features/teacher_dashboard/screens/teacher_dashboard_screen.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const TeacherDashboardScreen(),
    );
  }
}