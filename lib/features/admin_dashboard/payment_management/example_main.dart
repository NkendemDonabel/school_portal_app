// Example: How to use the Admin Payment Dashboard as your main/home page
//
// Copy this code to your lib/main.dart file to use the Payment Dashboard
// as the first screen when the app starts.

import 'package:flutter/material.dart';
import 'presentation/pages/admin_payment_dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Portal - Admin Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // The Payment Dashboard is set as the home page
      home: const AdminPaymentDashboardPage(),
    );
  }
}


