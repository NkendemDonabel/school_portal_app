# School Portal - Admin Dashboard

A comprehensive Flutter application featuring a complete Admin Dashboard system for managing students, teachers, payments, and announcements in a school environment.

## 📋 Table of Contents

- [Features](#features)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Module Overview](#module-overview)
- [Running on Emulator](#running-on-emulator)
- [Architecture](#architecture)
- [Future Enhancements](#future-enhancements)

## ✨ Features

### Main Admin Dashboard
- **Welcome Message:** Informative message about admin access and responsibilities
- **Quick Navigation:** 4 main management modules with intuitive card UI
- **Responsive Design:** Works seamlessly on all device sizes
- **Material Design 3:** Modern UI with gradient backgrounds and smooth animations

### Student Management
- ✅ View all students
- ✅ Add new students with name, email, and grade
- ✅ Edit student information
- ✅ Delete students
- ✅ Search functionality
- ✅ Filter by status (Active/Inactive)

### Teachers Management
- ✅ View all teachers
- ✅ Add new teachers with detailed information
- ✅ Edit teacher profiles
- ✅ Delete teachers
- ✅ Search functionality
- ✅ Filter by subject
- ✅ Track experience levels

### Announcement Management
- ✅ Create new announcements
- ✅ Edit existing announcements
- ✅ Publish announcements
- ✅ Save as draft
- ✅ Select target audience
- ✅ Track announcement status
- ✅ Delete announcements

### Payment Management
- ✅ View payment records
- ✅ Update payment status
- ✅ Fee structure management
- ✅ Payment method configuration
- ✅ Send payment reminders
- ✅ Payment summary reports

## 📁 Project Structure

```
Shool_portal/
├── lib/
│   ├── features/
│   │   └── admin_dashboard/
│   │       ├── presentation/
│   │       │   └── pages/
│   │       │       ├── admin_dashboard_main_page.dart
│   │       │       ├── student_management_page.dart
│   │       │       ├── teachers_management_page.dart
│   │       │       └── announcement_management_page.dart
│   │       ├── payment_management/
│   │       │   ├── models/
│   │       │   ├── services/
│   │       │   └── presentation/
│   │       └── ADMIN_DASHBOARD_GUIDE.md
│   ├── main.dart
│   └── ...
├── pubspec.yaml
├── EMULATOR_GUIDE.md
├── README.md
└── ...
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.11.0)
- Dart SDK
- Android Studio or Xcode
- An Android Virtual Device (AVD) or iOS Simulator

### Installation

1. **Clone/Navigate to the project:**
   ```bash
   cd C:\Users\chiki\AndroidStudioProjects\Shool_portal
   ```

2. **Get dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

## 📱 Running on Emulator

### Android Emulator
1. Open Android Studio
2. Go to **Device Manager** → Select your AVD → Click **Play**
3. In terminal, run: `flutter run`
4. The app will automatically launch on the emulator

### iOS Simulator (macOS)
1. Open iOS Simulator: `open -a Simulator`
2. Run: `flutter run`

For detailed instructions, see [EMULATOR_GUIDE.md](./EMULATOR_GUIDE.md)

## 📦 Module Overview

### 1. Main Admin Dashboard (`admin_dashboard_main_page.dart`)
The landing page for all admin users featuring:
- Welcome message with admin responsibilities
- 4 navigation cards for different management modules
- Gradient UI design
- Color-coded module cards

**Colors:**
- Student Management: Blue
- Payment Management: Green
- Teachers Management: Orange
- Announcement Management: Red

### 2. Student Management (`student_management_page.dart`)
Complete student management system with:
- CRUD operations (Create, Read, Update, Delete)
- Search and filter functionality
- Student data includes: ID, Name, Email, Grade, Status
- Sample data for testing

### 3. Teachers Management (`teachers_management_page.dart`)
Full teacher management system featuring:
- CRUD operations
- Teacher information: ID, Name, Email, Subject, Experience, Status
- Filter by subject
- Search functionality

### 4. Announcement Management (`announcement_management_page.dart`)
Announcement system with:
- Create announcements with title and content
- Draft and publish functionality
- Target audience selection
- Status tracking (Published/Draft)
- Edit and delete capabilities

### 5. Payment Management (Pre-existing)
Complete payment system for:
- Payment record tracking
- Fee structure management
- Payment method configuration
- Payment reminders
- Payment summaries

## 🏗️ Architecture

The app follows **Clean Architecture** principles:

```
┌─────────────────────────┐
│  Presentation Layer     │
│  (UI & Pages)          │
├─────────────────────────┤
│  Domain Layer           │
│  (Business Logic)       │
├─────────────────────────┤
│  Data Layer             │
│  (Services & Models)    │
└─────────────────────────┘
```

### Design Patterns Used:
- **StatefulWidget:** For state management
- **Material Design 3:** Modern UI components
- **Modular Architecture:** Each feature in separate modules
- **Separation of Concerns:** Clear layer separation

## 🎨 Theme & Styling

**Primary Color:** `Colors.deepPurple`

**UI Components:**
- AppBar with custom styling
- Gradient backgrounds
- Material Design cards
- CustomButtons and icons
- Responsive layouts
- Shadow effects for depth

## 💾 Sample Data

Each module comes with sample data for testing:

**Students:**
```dart
{
  'id': '001',
  'name': 'John Doe',
  'email': 'john@example.com',
  'grade': '10-A',
  'status': 'Active',
}
```

**Teachers:**
```dart
{
  'id': 'T001',
  'name': 'Mrs. Sarah Williams',
  'email': 'sarah@example.com',
  'subject': 'Mathematics',
  'experience': '8 years',
  'status': 'Active',
}
```

**Announcements:**
```dart
{
  'id': 'A001',
  'title': 'School Closure Notice',
  'content': 'Content here...',
  'date': 'March 10, 2026',
  'target': 'All Students & Parents',
  'status': 'Published',
}
```

## 🔧 Usage Examples

### Adding a Student
1. Tap "Student Management" from main dashboard
2. Tap the "+" button (FAB)
3. Fill in student details
4. Tap "Add" button

### Publishing an Announcement
1. Tap "Announcement Management" from main dashboard
2. Tap the "+" button
3. Fill in title and content
4. Uncheck "Save as Draft"
5. Tap "Create" button

### Editing a Teacher
1. Tap "Teachers Management" from main dashboard
2. Tap the menu (⋮) on a teacher card
3. Select "Edit"
4. Update information
5. Tap "Update" button

## 📊 Navigation Flow

```
App Start (main.dart)
    ↓
Admin Dashboard Main Page
    ├→ Student Management Page
    │    ├→ View Students
    │    ├→ Add Student
    │    ├→ Edit Student
    │    └→ Delete Student
    │
    ├→ Teachers Management Page
    │    ├→ View Teachers
    │    ├→ Add Teacher
    │    ├→ Edit Teacher
    │    └→ Delete Teacher
    │
    ├→ Announcement Management Page
    │    ├→ Create Announcement
    │    ├→ Edit Announcement
    │    ├→ Publish Announcement
    │    └→ Delete Announcement
    │
    └→ Payment Management Page
         ├→ View Payments
         ├→ Update Status
         └→ Send Reminders
```

## 🎯 Key Features

### Search & Filter
- Search students, teachers, and announcements
- Filter by status, subject, or date
- Real-time filtering

### CRUD Operations
- Create new records
- Read/View all records
- Update existing information
- Delete records with confirmation

### User Feedback
- SnackBar notifications for actions
- Confirmation dialogs before deletion
- Error handling
- Loading indicators

### Responsive Design
- Works on phones and tablets
- Responsive grid layouts
- Adaptive UI elements

## 🚀 Future Enhancements

1. **Authentication System**
   - Admin login/logout
   - Role-based access control
   - Password management

2. **Backend Integration**
   - Connect to REST API
   - Database synchronization
   - Real-time updates

3. **Advanced Features**
   - Export data to CSV/PDF
   - Advanced analytics dashboard
   - Push notifications
   - Attendance tracking
   - Grade management

4. **Improvements**
   - Offline mode support
   - Dark theme
   - Multiple language support
   - Advanced search algorithms

5. **Security**
   - Data encryption
   - Secure storage
   - API authentication tokens
   - Input validation

## 📝 Important Files

| File | Purpose |
|------|---------|
| `main.dart` | App entry point |
| `admin_dashboard_main_page.dart` | Main dashboard landing page |
| `student_management_page.dart` | Student management module |
| `teachers_management_page.dart` | Teachers management module |
| `announcement_management_page.dart` | Announcement management module |
| `admin_payment_dashboard_page.dart` | Payment management module |
| `ADMIN_DASHBOARD_GUIDE.md` | Detailed module documentation |
| `EMULATOR_GUIDE.md` | Emulator setup and running guide |

## 🐛 Troubleshooting

### App won't run
```bash
flutter clean
flutter pub get
flutter run
```

### Emulator not detected
```bash
flutter devices
flutter run -d <device_id>
```

### Build errors
```bash
flutter doctor  # Check your setup
flutter pub get  # Get latest dependencies
```

## 💡 Tips for Development

1. **Hot Reload:** Press 'r' in terminal to instantly see changes
2. **Full Rebuild:** Press 'R' (capital) if hot reload fails
3. **Debug:** Use `flutter logs` to view app logs
4. **Performance:** Use `--profile` flag for performance testing

## 🔗 Dependencies

- **flutter:** Core Flutter framework
- **Material Design:** UI components and theming

For full dependency list, see `pubspec.yaml`

## 📞 Support & Contact

For issues or questions:
1. Check the documentation files
2. Review the sample data structures
3. Check Flutter/Dart official documentation
4. Create an issue in the project repository

## 📄 License

This project is part of the School Portal application.

---

**Created:** March 2026
**Platform:** Flutter (Dart)
**Version:** 1.0.0

For more detailed information about the emulator setup, see [EMULATOR_GUIDE.md](./EMULATOR_GUIDE.md)
For more information about the module structure, see [ADMIN_DASHBOARD_GUIDE.md](./lib/features/admin_dashboard/ADMIN_DASHBOARD_GUIDE.md)

