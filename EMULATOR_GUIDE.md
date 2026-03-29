# Running the Admin Dashboard on Emulator

## Prerequisites

Before running the app on the emulator, ensure you have:
1. Flutter SDK installed
2. Android Studio with Android SDK
3. Android Virtual Device (AVD) created in Android Studio
4. Or Xcode and iOS Simulator for macOS

## Step-by-Step Guide to Run on Emulator

### Option 1: Using Android Emulator (Windows/Mac/Linux)

#### Step 1: Start the Android Emulator
1. Open Android Studio
2. Go to **Tools** → **Device Manager**
3. Select your Android Virtual Device (AVD)
4. Click the **Play** button to start the emulator
5. Wait for the emulator to fully boot

#### Step 2: Run Flutter App
```powershell
cd C:\Users\chiki\AndroidStudioProjects\Shool_portal
flutter pub get
flutter run
```

The app will automatically detect the running emulator and install the app.

#### Step 3: View the Output
Once the app builds successfully, you'll see:
- The Admin Dashboard Main Page with the welcome message
- 4 colorful cards for:
  - Student Management (Blue)
  - Payment Management (Green)
  - Teachers Management (Orange)
  - Announcement Management (Red)

### Option 2: Using Hot Reload (Development)

After the app is running, you can:
1. Press **r** to hot reload the app
2. Press **R** to hot restart the app
3. Press **q** to quit the app

### Option 3: Using iOS Simulator (macOS only)

```bash
cd C:\Users\chiki\AndroidStudioProjects\Shool_portal
open -a Simulator
flutter run
```

## Troubleshooting

### Issue: Emulator not detected

**Solution:**
```powershell
flutter devices  # Check available devices
# If emulator is not listed, restart it
# Or specify device manually:
flutter run -d <device_id>
```

### Issue: Build fails

**Solution:**
```powershell
flutter clean
flutter pub get
flutter run
```

### Issue: App crashes on startup

**Solution:**
1. Ensure all dependencies are installed: `flutter pub get`
2. Check that the main.dart file imports are correct
3. Run: `flutter doctor` to verify your setup

## What to Expect on the Emulator

### Main Dashboard Screen
```
┌─────────────────────────────────┐
│  Admin Dashboard                │
├─────────────────────────────────┤
│                                 │
│  Welcome to Admin Dashboard     │
│  You have access because...     │
│  Here you can manage...          │
│                                 │
├─────────────────────────────────┤
│  What would you like to manage? │
│                                 │
│  ┌──────────────┬────────────┐  │
│  │ 👥 Student   │ 💳 Payment  │  │
│  │ Management   │ Management  │  │
│  │              │             │  │
│  ├──────────────┼────────────┤  │
│  │ 🏫 Teachers  │ 📢 Announce │  │
│  │ Management   │ Management  │  │
│  │              │             │  │
│  └──────────────┴────────────┘  │
└─────────────────────────────────┘
```

### Testing the App

1. **Tap on Student Management:**
   - See a list of sample students
   - Click the "+" button to add a new student
   - Tap on a student to see options (View, Edit, Delete)

2. **Tap on Teachers Management:**
   - See a list of sample teachers
   - Click the "+" button to add a new teacher
   - Manage teacher information

3. **Tap on Announcement Management:**
   - See sample announcements
   - Create new announcements
   - Save as draft or publish
   - Select target audience

4. **Tap on Payment Management:**
   - Opens the existing payment management dashboard
   - View payment records and summaries
   - Manage payment methods and fee structures

## Command Line Options

### Run with specific device
```powershell
flutter run -d <device_id>
```

### Run with verbose output (debugging)
```powershell
flutter run -v
```

### Run with profile (performance testing)
```powershell
flutter run --profile
```

### Run with release mode
```powershell
flutter run --release
```

## Recommended Emulator Settings

For best performance:
1. Open Device Manager in Android Studio
2. Edit your AVD settings:
   - RAM: 2GB or more
   - VM heap: 512MB or more
   - Graphics: Hardware

## Viewing Logs

To see app logs in real-time:
```powershell
flutter logs
```

## App Navigation

Once the app is running, you can:

1. **Main Dashboard:**
   - View 4 management options
   - Tap any card to navigate to that section

2. **Each Management Page:**
   - Has a back button (← in AppBar) to return to main dashboard
   - Search functionality
   - Add new items button (+ FAB)
   - Filter options

3. **Sample Data:**
   - Each module comes with sample data for testing
   - You can add, edit, and delete items
   - Changes are local to the app session

## Performance Tips

1. Use **Hardware Acceleration** in emulator settings
2. Allocate sufficient RAM to the emulator
3. Close unnecessary background apps
4. Use Android API level 28 or higher for better performance
5. For faster builds, use `flutter run --fast-start`

## Tips for Development

1. **Hot Reload:** Press 'r' to see changes instantly
2. **Device Menu:** Use the device selector to switch between devices
3. **Full Rebuild:** Use 'R' (capital) for complete rebuild if hot reload fails
4. **Inspect Widget:** Enable "Inspect Widget" from Flutter DevTools (press 'w')

## Next Steps

After successfully running the app:

1. **Add real data:** Replace sample data with actual database
2. **Implement backend:** Connect to a backend server
3. **Add authentication:** Implement login system
4. **Custom theming:** Adjust colors and styling
5. **Add more features:** Implement analytics, reports, etc.

## Common Gestures

- **Tap:** Select items or navigate
- **Long Press:** Context menu options (on student/teacher cards)
- **Swipe:** (Implemented in some pages for navigation)
- **Scroll:** View full list of items

---

For more detailed information about each module, see `ADMIN_DASHBOARD_GUIDE.md`

