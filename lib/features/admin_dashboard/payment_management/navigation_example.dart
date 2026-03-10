import 'package:flutter/material.dart';
import 'presentation/pages/admin_payment_dashboard_page.dart';

/// Example showing how to navigate to the Admin Payment Dashboard
/// from anywhere in your app - This is a STANDALONE module
class NavigationExample {
  /// Navigate to Admin Payment Dashboard from any page
  static void navigateToPaymentDashboard(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AdminPaymentDashboardPage(),
      ),
    );
  }

  /// Navigate with custom transition animation
  static void navigateToPaymentDashboardWithAnimation(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AdminPaymentDashboardPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  /// Navigate and replace current page
  static void navigateAndReplace(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const AdminPaymentDashboardPage(),
      ),
    );
  }
}

/// Example Widget: Button to navigate to Payment Dashboard
class PaymentDashboardButton extends StatelessWidget {
  const PaymentDashboardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => NavigationExample.navigateToPaymentDashboard(context),
      icon: const Icon(Icons.dashboard),
      label: const Text('Open Payment Dashboard'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

// ============================================================================
// EXAMPLE 1: Use as Main/Home Page
// ============================================================================
/// In your main.dart file:
///
/// ```dart
/// import 'package:flutter/material.dart';
/// import 'features/admin_dashboard/payment_management/presentation/pages/admin_payment_dashboard_page.dart';
///
/// void main() {
///   runApp(const MyApp());
/// }
///
/// class MyApp extends StatelessWidget {
///   const MyApp({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     return MaterialApp(
///       title: 'School Portal',
///       theme: ThemeData(
///         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
///         useMaterial3: true,
///       ),
///       home: const AdminPaymentDashboardPage(), // Set as home page
///     );
///   }
/// }
/// ```

// ============================================================================
// EXAMPLE 2: Create a Main Menu/Dashboard Landing Page
// ============================================================================
/// Create a new file: main_menu_page.dart
///
/// ```dart
/// import 'package:flutter/material.dart';
/// import 'features/admin_dashboard/payment_management/presentation/pages/admin_payment_dashboard_page.dart';
///
/// class MainMenuPage extends StatelessWidget {
///   const MainMenuPage({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       appBar: AppBar(
///         title: const Text('School Portal - Admin Dashboard'),
///         backgroundColor: Theme.of(context).primaryColor,
///       ),
///       body: Padding(
///         padding: const EdgeInsets.all(16),
///         child: GridView.count(
///           crossAxisCount: 2,
///           mainAxisSpacing: 16,
///           crossAxisSpacing: 16,
///           children: [
///             _buildMenuCard(
///               context,
///               title: 'Payment Management',
///               icon: Icons.payment,
///               color: Colors.blue,
///               onTap: () => Navigator.push(
///                 context,
///                 MaterialPageRoute(
///                   builder: (context) => const AdminPaymentDashboardPage(),
///                 ),
///               ),
///             ),
///             _buildMenuCard(
///               context,
///               title: 'Student Records',
///               icon: Icons.people,
///               color: Colors.green,
///               onTap: () {
///                 // Navigate to student records
///               },
///             ),
///             _buildMenuCard(
///               context,
///               title: 'Attendance',
///               icon: Icons.checklist,
///               color: Colors.orange,
///               onTap: () {
///                 // Navigate to attendance
///               },
///             ),
///             _buildMenuCard(
///               context,
///               title: 'Reports',
///               icon: Icons.bar_chart,
///               color: Colors.purple,
///               onTap: () {
///                 // Navigate to reports
///               },
///             ),
///           ],
///         ),
///       ),
///     );
///   }
///
///   Widget _buildMenuCard(
///     BuildContext context, {
///     required String title,
///     required IconData icon,
///     required Color color,
///     required VoidCallback onTap,
///   }) {
///     return Card(
///       elevation: 4,
///       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
///       child: InkWell(
///         onTap: onTap,
///         borderRadius: BorderRadius.circular(12),
///         child: Column(
///           mainAxisAlignment: MainAxisAlignment.center,
///           children: [
///             Icon(icon, size: 64, color: color),
///             const SizedBox(height: 12),
///             Text(
///               title,
///               textAlign: TextAlign.center,
///               style: const TextStyle(
///                 fontSize: 16,
///                 fontWeight: FontWeight.bold,
///               ),
///             ),
///           ],
///         ),
///       ),
///     );
///   }
/// }
/// ```

// ============================================================================
// EXAMPLE 3: Navigate from Any Button/ListTile
// ============================================================================
/// Add anywhere in your app:
///
/// ```dart
/// ElevatedButton(
///   onPressed: () {
///     Navigator.push(
///       context,
///       MaterialPageRoute(
///         builder: (context) => const AdminPaymentDashboardPage(),
///       ),
///     );
///   },
///   child: const Text('Go to Payment Dashboard'),
/// )
/// ```
///
/// Or as a ListTile:
///
/// ```dart
/// ListTile(
///   leading: const Icon(Icons.payment, color: Colors.blue),
///   title: const Text('Payment Management'),
///   subtitle: const Text('Manage school fees and payments'),
///   trailing: const Icon(Icons.arrow_forward_ios),
///   onTap: () {
///     Navigator.push(
///       context,
///       MaterialPageRoute(
///         builder: (context) => const AdminPaymentDashboardPage(),
///       ),
///     );
///   },
/// )
/// ```

// ============================================================================
// EXAMPLE 4: Using Named Routes
// ============================================================================
/// In main.dart, define routes:
///
/// ```dart
/// MaterialApp(
///   title: 'School Portal',
///   routes: {
///     '/': (context) => const MainMenuPage(),
///     '/payment-dashboard': (context) => const AdminPaymentDashboardPage(),
///   },
///   initialRoute: '/',
/// )
/// ```
///
/// Then navigate using:
///
/// ```dart
/// Navigator.pushNamed(context, '/payment-dashboard');
/// ```

