# Admin Dashboard - Payment Management Module

A comprehensive Flutter module for managing payments, fees, and payment methods in a school portal application.

## 📁 Module Structure

```
lib/features/admin_dashboard/payment_management/
├── models/
│   ├── payment_record.dart          # Payment transaction model
│   ├── fee_structure.dart           # School fee structure model
│   └── payment_method.dart          # Payment method configuration model
├── services/
│   └── payment_service.dart         # Business logic and data operations
├── presentation/
│   ├── pages/
│   │   └── admin_payment_dashboard_page.dart  # Main dashboard page
│   └── widgets/
│       ├── payment_summary_card.dart          # Summary metric cards
│       ├── payment_record_tile.dart           # Payment record list item
│       ├── fee_structure_card.dart            # Fee breakdown display
│       └── payment_method_switch_tile.dart    # Payment method toggle
├── navigation_example.dart          # Navigation integration examples
└── README.md                        # This file
```

## 🎯 Features

### 1. Payment Reports Dashboard
- **Summary Cards**: Display key metrics
  - Total Payments
  - Paid Fees
  - Pending Fees
  - Failed Payments
- **Visual Design**: Color-coded cards with gradient backgrounds
- **Real-time Updates**: Auto-calculates totals based on payment records

### 2. Payment History
- **Comprehensive List**: Shows all payment transactions
- **Detailed Information**:
  - Student name
  - Payment amount
  - Payment date
  - Transaction ID
  - Payment status (Paid/Pending/Failed)
- **Interactive Elements**:
  - Status dropdown for each record
  - Color-coded status chips
  - Transaction ID display

### 3. Payment Status Management
- **Update Status**: Change payment status via dropdown
  - Paid (Green)
  - Pending (Orange)
  - Failed (Red)
- **Visual Feedback**: Color-coded status indicators
- **Instant Updates**: Reflects changes immediately

### 4. Payment Reminders
- **Send Reminders**: Button for pending payments
- **Bulk Reminders**: Quick action to remind all pending students
- **Confirmation**: SnackBar notifications for user feedback

### 5. Fee Structure Management
- **Detailed Breakdown**:
  - Tuition Fee
  - Transport Fee
  - Exam Fee
  - Library Fee
  - Sports Fee
  - Other Charges
  - **Total Calculation**
- **Payment Deadline**: 
  - Visual countdown
  - Overdue warnings
  - Days remaining indicator
- **Edit Functionality**: Update fees via dialog

### 6. Payment Methods Configuration
- **Toggle Methods**:
  - Online Banking
  - Card Payment
  - Mobile Money
- **Method Details**:
  - Description
  - Transaction fees
  - Enable/Disable switches
- **Visual Icons**: Unique icon for each method

## 🚀 Usage

### Navigation from Main App

To navigate to the Admin Payment Dashboard from your main app, use standard Flutter navigation:

```dart
import 'package:flutter/material.dart';
import 'features/admin_dashboard/payment_management/presentation/pages/admin_payment_dashboard_page.dart';

// Basic navigation
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const AdminPaymentDashboardPage(),
  ),
);
```

### Set as Home Page

To use the Admin Payment Dashboard as your home page, update `main.dart`:

```dart
import 'package:flutter/material.dart';
import 'features/admin_dashboard/payment_management/presentation/pages/admin_payment_dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Portal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AdminPaymentDashboardPage(),
    );
  }
}
```

### Create a Menu/Dashboard Page

Create a main menu page that navigates to different features:

```dart
// Example: Create a main_menu_page.dart
import 'package:flutter/material.dart';
import 'features/admin_dashboard/payment_management/presentation/pages/admin_payment_dashboard_page.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('School Portal'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        children: [
          _MenuCard(
            title: 'Payment Management',
            icon: Icons.payment,
            color: Colors.blue,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdminPaymentDashboardPage(),
                ),
              );
            },
          ),
          // Add more menu items here
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _MenuCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
```

## 📊 Data Models

### PaymentRecord
```dart
PaymentRecord(
  id: 'PAY001',
  studentId: '1',
  studentName: 'Emma Johnson',
  amount: 5000.00,
  paymentDate: DateTime(2026, 2, 15),
  status: PaymentStatus.paid,
  transactionId: 'TXN001',
  paymentMethod: 'Online Banking',
)
```

### FeeStructure
```dart
FeeStructure(
  id: 'FEE001',
  academicYear: '2025-2026',
  tuitionFee: 3500.00,
  transportFee: 500.00,
  examFee: 300.00,
  libraryFee: 200.00,
  sportsFee: 350.00,
  otherCharges: 150.00,
  paymentDeadline: DateTime(2026, 3, 31),
)
```

### PaymentMethod
```dart
PaymentMethod(
  id: 'PM001',
  name: 'Online Banking',
  description: 'Direct bank transfer',
  isEnabled: true,
  iconName: 'account_balance',
  transactionFee: 0.0,
)
```

## 🎨 UI Components

### Payment Summary Cards
- Grid layout (2x2)
- Gradient backgrounds
- Icon badges
- Color-coded by metric type

### Payment Record Tiles
- Card-based design
- Status dropdown
- Send reminder button
- Transaction details

### Fee Structure Card
- Detailed breakdown table
- Edit functionality
- Deadline countdown
- Total calculation

### Payment Method Switches
- Switch tile design
- Method icons
- Transaction fee display
- Enable/disable toggle

## ⚙️ Customization

### Change Theme Colors

The module uses the app's primary color from the theme. Update in `main.dart`:

```dart
theme: ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), // Change color
  useMaterial3: true,
),
```

### Modify Sample Data

Edit the dummy data in `payment_service.dart`:

```dart
static List<PaymentRecord> getAllPaymentRecords() {
  return [
    // Add/modify payment records here
  ];
}
```

### Add New Payment Methods

```dart
PaymentMethod(
  id: 'PM004',
  name: 'Bank Transfer',
  description: 'Direct bank transfer',
  isEnabled: true,
  iconName: 'account_balance_wallet',
  transactionFee: 0.0,
)
```

## 🔌 Backend Integration

To connect with a real backend:

### 1. Replace PaymentService methods

```dart
// In payment_service.dart
static Future<List<PaymentRecord>> getAllPaymentRecords() async {
  final response = await http.get(Uri.parse('your-api-url/payments'));
  // Parse and return payment records
}
```

### 2. Add HTTP package

```yaml
# In pubspec.yaml
dependencies:
  http: ^1.1.0
```

### 3. Implement API calls

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentService {
  static const String baseUrl = 'https://your-api.com';
  
  static Future<List<PaymentRecord>> getAllPaymentRecords() async {
    final response = await http.get(Uri.parse('$baseUrl/payments'));
    
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => PaymentRecord.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load payment records');
    }
  }
}
```

## 📱 Screenshots Features

- ✅ Responsive design (works on all screen sizes)
- ✅ Scrollable content (no overflow issues)
- ✅ Material Design 3
- ✅ Clean and professional UI
- ✅ Color-coded status indicators
- ✅ Interactive elements
- ✅ Loading states
- ✅ Error handling
- ✅ Confirmation messages

## 🧪 Testing

### Manual Testing Checklist

- [ ] View payment summary cards
- [ ] Scroll through payment history
- [ ] Change payment status via dropdown
- [ ] Click "Send Reminder" button
- [ ] Edit fee structure
- [ ] Toggle payment methods on/off
- [ ] Test quick actions FAB
- [ ] Send bulk reminders
- [ ] Refresh data

## 🔄 State Management

Currently uses **setState** for simplicity. For production apps, consider:

- **Provider**: Simple and easy to learn
- **Bloc**: For complex state management
- **Riverpod**: Modern and flexible
- **GetX**: All-in-one solution

### Example with Provider

```dart
// Create a provider
class PaymentProvider extends ChangeNotifier {
  List<PaymentRecord> _records = [];
  
  void updateStatus(String id, PaymentStatus status) {
    // Update logic
    notifyListeners();
  }
}

// Use in widget
class AdminPaymentDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PaymentProvider(),
      child: // Your widget tree
    );
  }
}
```

## 📝 Notes

- **Dummy Data**: Currently uses sample data. Replace with API calls for production.
- **Reminders**: Currently shows SnackBar. Integrate with email/SMS service.
- **Export**: Export feature placeholder - implement PDF/Excel generation.
- **Analytics**: Analytics placeholder - add charts and graphs.

## 🚀 Future Enhancements

1. **Charts & Graphs**: Add payment analytics with charts
2. **Export to PDF/Excel**: Generate payment reports
3. **Search & Filter**: Find specific payments quickly
4. **Date Range Picker**: Filter by date range
5. **Email Integration**: Send automated reminders
6. **SMS Integration**: Send SMS notifications
7. **Receipt Generation**: Generate payment receipts
8. **Payment Gateway**: Integrate with payment providers
9. **Audit Log**: Track all changes and actions
10. **Multi-currency**: Support different currencies

## 📞 Support

For questions or issues with this module, please refer to:
- Flutter Documentation: https://flutter.dev/docs
- Material Design 3: https://m3.material.io

## ✨ Credits

Built with Flutter & Material Design 3 for School Portal App.

