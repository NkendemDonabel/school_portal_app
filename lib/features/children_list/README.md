# Children List Feature Module

This module handles the display and selection of children in the School Portal app.

## Module Structure

```
lib/features/children_list/
├── models/
│   └── child_model.dart          # Child data model
├── screens/
│   └── children_list_screen.dart # Main screen for listing children
└── widgets/
    └── child_list_item.dart      # Reusable list item widget
```

## Features

- **Display List of Children**: Shows all children with their names and grades
- **Multi-Selection**: Allows selecting one or more children using checkboxes
- **Visual Feedback**: Highlights selected items with colored borders
- **Selection Counter**: Displays the total number of children and selected count
- **Submit Button**: Shows the number of selected children and allows submission
- **Validation**: Prevents submission if no children are selected

## Usage

### Model: Child

The `Child` model represents a child entity with the following properties:
- `id`: Unique identifier
- `name`: Child's full name
- `grade`: Current grade level
- `photoUrl`: Optional profile photo URL

### Screen: ChildrenListScreen

The main screen that displays the list of children with selection capability.

```dart
import 'package:flutter/material.dart';
import 'features/children_list/screens/children_list_screen.dart';

// Navigate to the children list screen
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const ChildrenListScreen(),
  ),
);
```

### Widget: ChildListItem

A reusable widget for displaying a single child item with a checkbox.

```dart
ChildListItem(
  child: child,
  isSelected: isSelected,
  onChanged: (selected) => handleSelection(child.id, selected),
)
```

## Navigation

When children are selected and the submit button is pressed, you need to navigate to your details page. 

Replace the `_showSelectedChildrenDialog` call in the `_submitSelection()` method with:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => YourDetailsScreen(
      selectedChildren: selectedChildren,
    ),
  ),
);
```

## Customization

### Sample Data

The screen currently uses sample data. To integrate with real data:

1. Replace the `_children` list initialization in `_ChildrenListScreenState`
2. Fetch data from your backend/database
3. Use a state management solution (Provider, Bloc, etc.) for better data handling

Example:
```dart
final List<Child> _children = [];

@override
void initState() {
  super.initState();
  _fetchChildren();
}

Future<void> _fetchChildren() async {
  // Fetch from your API/database
  final children = await yourApiService.getChildren();
  setState(() {
    _children.addAll(children);
  });
}
```

### Styling

The module uses Material 3 design with the app's theme. To customize:

- **Colors**: Modify in the theme definition in `main.dart`
- **Card Style**: Edit in `child_list_item.dart`
- **Button Style**: Edit in `children_list_screen.dart`

## Dependencies

This module uses only Flutter's built-in packages:
- `flutter/material.dart`

No additional dependencies are required.

## Integration with Kotlin (Android)

This Flutter module can interact with Kotlin code through platform channels if needed:

1. Create a platform channel in Dart
2. Implement the corresponding channel in Kotlin (Android)
3. Use for native Android functionality (e.g., notifications, device features)

For more information, see: https://docs.flutter.dev/platform-integration/platform-channels

## Next Steps

To complete the implementation:

1. **Integrate with your backend**: Replace sample data with real API calls
2. **Add navigation**: Connect the submit button to your details screen
3. **Add error handling**: Handle network errors and edge cases
4. **Add loading states**: Show progress indicators during data fetch
5. **Add search/filter**: Allow users to search or filter children
6. **Add persistence**: Save selections locally if needed

