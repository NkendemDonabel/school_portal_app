# Quick Reference Guide - Admin Dashboard

## 🎯 Quick Start

```bash
# Navigate to project
cd C:\Users\chiki\AndroidStudioProjects\Shool_portal

# Get dependencies
flutter pub get

# Run the app
flutter run
```

## 📱 What You'll See

When you launch the app, you'll see the **Admin Dashboard Main Page** with:

1. **Welcome Section**
   - Title: "Welcome to Admin Dashboard"
   - Brief message about admin access
   - Explanation of responsibilities

2. **4 Management Cards**
   - Student Management (Blue icon: 👥)
   - Payment Management (Green icon: 💳)
   - Teachers Management (Orange icon: 🏫)
   - Announcement Management (Red icon: 📢)

## 🎮 Interactive Features

### In Each Management Page:

| Action | How | Result |
|--------|-----|--------|
| **Search** | Type in search box | Filter items by name |
| **Filter** | Tap filter icon | Advanced filtering options |
| **Add Item** | Tap + button (FAB) | Open add dialog |
| **View Details** | Long press card → View | Show item details |
| **Edit** | Long press card → Edit | Modify item |
| **Delete** | Long press card → Delete | Remove item (with confirmation) |
| **Back** | Tap ← in AppBar | Return to main dashboard |

## 📋 Page Structure

### Student Management Page
```
Search Bar | Filter ⊙
──────────────────────
👤 John Doe          ⋮
   ID: 001           
   Grade: 10-A

👤 Jane Smith        ⋮
   ID: 002
   Grade: 10-B
   
[+ Add Student Button]
```

### Teachers Management Page
```
Search Bar | Filter ⊙
──────────────────────
🏫 Mrs. Sarah Williams ⋮
   Subject: Mathematics
   Experience: 8 years

🏫 Mr. David Brown    ⋮
   Subject: English
   Experience: 5 years
   
[+ Add Teacher Button]
```

### Announcement Management Page
```
Search Bar
──────────────────────
📌 School Closure Notice     ⋮
   Content preview...
   Posted: March 10, 2026
   Status: Published ✓

📌 Exam Schedule Released    ⋮
   Content preview...
   Posted: March 8, 2026
   Status: Published ✓
   
[+ Create Announcement Button]
```

### Payment Management Page
```
(Pre-existing page with payment records)
- View payment records
- Update payment status
- Send payment reminders
- Fee structure
- Payment methods
```

## 🗂️ File Locations

Quick file reference:

```
lib/
├── main.dart                    ← App entry point
└── features/
    └── admin_dashboard/
        ├── ADMIN_DASHBOARD_GUIDE.md   ← Detailed guide
        ├── presentation/
        │   └── pages/
        │       ├── admin_dashboard_main_page.dart      ← Main page
        │       ├── student_management_page.dart        ← Students
        │       ├── teachers_management_page.dart       ← Teachers
        │       └── announcement_management_page.dart   ← Announcements
        └── payment_management/
            └── presentation/pages/
                └── admin_payment_dashboard_page.dart   ← Payments
```

## 🔄 Navigation Map

```
START
  ↓
Admin Dashboard Main Page (Landing)
  ├─ Tap "Student Management" →          Student Management Page
  ├─ Tap "Payment Management" →          Payment Management Page
  ├─ Tap "Teachers Management" →         Teachers Management Page
  └─ Tap "Announcement Management" →     Announcement Management Page

In Any Management Page:
  ├─ Tap "+" button →           Add New Item Dialog
  ├─ Tap Card → "View" →        Item Details
  ├─ Tap Card → "Edit" →        Edit Item Dialog
  ├─ Tap Card → "Delete" →      Delete Confirmation
  ├─ Use Search →               Filter by name
  ├─ Use Filter →               Advanced filter options
  └─ Tap "←" in AppBar →        Back to Main Dashboard
```

## 📊 Sample Data Provided

### Students (3 samples)
- John Doe (Grade 10-A)
- Jane Smith (Grade 10-B)
- Michael Johnson (Grade 9-A)

### Teachers (3 samples)
- Mrs. Sarah Williams (Mathematics, 8 years)
- Mr. David Brown (English, 5 years)
- Mrs. Emily Davis (Science, 10 years)

### Announcements (3 samples)
- School Closure Notice
- Exam Schedule Released
- Parent-Teacher Meeting

## 🎨 Color Scheme

| Module | Color | Icon |
|--------|-------|------|
| Student Management | Blue | 👥 |
| Payment Management | Green | 💳 |
| Teachers Management | Orange | 🏫 |
| Announcement Management | Red | 📢 |
| Primary App Color | Deep Purple | - |

## ⌨️ Keyboard Shortcuts (In Development)

| Command | Action |
|---------|--------|
| `r` | Hot reload (see changes instantly) |
| `R` | Full restart |
| `w` | Toggle widget inspector |
| `q` | Quit app |

## 🚀 Common Tasks

### Adding a Student
1. Tap "Student Management"
2. Tap "+" button
3. Enter: Name, Email, Grade
4. Tap "Add"

### Publishing an Announcement
1. Tap "Announcement Management"
2. Tap "+" button
3. Enter: Title, Content
4. Select: Target Audience
5. Uncheck "Save as Draft" (if desired)
6. Tap "Create"

### Editing a Teacher
1. Tap "Teachers Management"
2. Tap ⋮ on a teacher card
3. Tap "Edit"
4. Modify information
5. Tap "Update"

### Deleting a Student
1. Tap "Student Management"
2. Tap ⋮ on a student card
3. Tap "Delete"
4. Confirm deletion

## 💡 Pro Tips

1. **Hot Reload:** Press 'r' in terminal while app is running to see code changes instantly
2. **Test with Sample Data:** Each page comes with sample data already loaded
3. **No Internet Required:** App works offline with sample data
4. **Responsive Design:** Works on phones and tablets
5. **Instant Navigation:** All pages are instantly accessible

## 🐛 If Something Goes Wrong

```bash
# Option 1: Clean and rebuild
flutter clean
flutter pub get
flutter run

# Option 2: Check device
flutter devices

# Option 3: See detailed logs
flutter run -v

# Option 4: Check your setup
flutter doctor
```

## 📱 Running on Different Devices

### Android Emulator
```bash
flutter run                    # Auto-selects emulator
flutter run -d emulator-5554   # Specific device
```

### iOS Simulator (macOS)
```bash
open -a Simulator             # Start simulator
flutter run                   # Run app
```

### Physical Device
```bash
flutter devices               # List connected devices
flutter run -d <device_id>    # Run on device
```

## 📚 Documentation Files

| File | Purpose |
|------|---------|
| `ADMIN_DASHBOARD_README.md` | Main overview and features |
| `lib/features/admin_dashboard/ADMIN_DASHBOARD_GUIDE.md` | Detailed module structure |
| `EMULATOR_GUIDE.md` | How to run on emulator |
| `QUICK_REFERENCE.md` | This file - quick commands |

## ✅ Verification Checklist

After launching the app, verify:

- [ ] Main dashboard page displays with welcome message
- [ ] 4 colored boxes are visible
- [ ] Can tap Student Management and see sample students
- [ ] Can tap Teachers Management and see sample teachers
- [ ] Can tap Announcement Management and see sample announcements
- [ ] Can tap Payment Management and see payment dashboard
- [ ] Back button returns to main dashboard
- [ ] + button adds new items
- [ ] Search functionality works
- [ ] Edit and delete functions work

## 🎓 Learn More

- **Flutter Documentation:** https://flutter.dev/docs
- **Dart Documentation:** https://dart.dev/docs
- **Material Design 3:** https://m3.material.io/

---

**Quick Links:**
- [Full README](./ADMIN_DASHBOARD_README.md)
- [Emulator Guide](./EMULATOR_GUIDE.md)
- [Module Guide](./lib/features/admin_dashboard/ADMIN_DASHBOARD_GUIDE.md)

Last Updated: March 2026

