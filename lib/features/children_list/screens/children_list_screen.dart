import 'package:flutter/material.dart';
import '../models/child_model.dart';
import '../widgets/child_list_item.dart';

class ChildrenListScreen extends StatefulWidget {
  const ChildrenListScreen({super.key});

  @override
  State<ChildrenListScreen> createState() => _ChildrenListScreenState();
}

class _ChildrenListScreenState extends State<ChildrenListScreen> {
  // List to store selected children IDs
  final Set<String> _selectedChildrenIds = {};

  // Sample data - Replace this with actual data from your backend/database
  final List<Child> _children = [
    Child(id: '1', name: 'Emma Johnson', grade: 'Grade 1'),
    Child(id: '2', name: 'Liam Smith', grade: 'Grade 2'),
    Child(id: '3', name: 'Olivia Williams', grade: 'Grade 3'),
    Child(id: '4', name: 'Noah Brown', grade: 'Grade 1'),
    Child(id: '5', name: 'Ava Jones', grade: 'Grade 4'),
    Child(id: '6', name: 'Ethan Davis', grade: 'Grade 2'),
    Child(id: '7', name: 'Sophia Miller', grade: 'Grade 5'),
    Child(id: '8', name: 'Mason Wilson', grade: 'Grade 3'),
    Child(id: '9', name: 'Isabella Moore', grade: 'Grade 1'),
    Child(id: '10', name: 'Lucas Taylor', grade: 'Grade 4'),
  ];

  void _toggleChildSelection(String childId, bool? selected) {
    setState(() {
      if (selected == true) {
        _selectedChildrenIds.add(childId);
      } else {
        _selectedChildrenIds.remove(childId);
      }
    });
  }

  void _submitSelection() {
    if (_selectedChildrenIds.isEmpty) {
      // Show a message if no children are selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one child'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Get the selected children
    final selectedChildren = _children
        .where((child) => _selectedChildrenIds.contains(child.id))
        .toList();

    // Navigate to the details page (replace with your actual page)
    // For now, we'll just show a dialog with the selected children
    _showSelectedChildrenDialog(selectedChildren);

    // TODO: Replace the above with your actual navigation
    // Example:
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ChildrenDetailsScreen(
    //       selectedChildren: selectedChildren,
    //     ),
    //   ),
    // );
  }

  void _showSelectedChildrenDialog(List<Child> selectedChildren) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Selected Children'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('You have selected ${selectedChildren.length} child(ren):'),
            const SizedBox(height: 12),
            ...selectedChildren.map(
              (child) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text('• ${child.name} (${child.grade})'),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Replace this dialog with navigation to your details page.',
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'List of Children',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header section with selection count
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Children: ${_children.length}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Selected: ${_selectedChildrenIds.length}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          // Children list
          Expanded(
            child: _children.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No children found',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: _children.length,
                    itemBuilder: (context, index) {
                      final child = _children[index];
                      final isSelected = _selectedChildrenIds.contains(child.id);
                      return ChildListItem(
                        child: child,
                        isSelected: isSelected,
                        onChanged: (selected) =>
                            _toggleChildSelection(child.id, selected),
                      );
                    },
                  ),
          ),
          // Submit button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(0, -2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: _submitSelection,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: Text(
                'Submit (${_selectedChildrenIds.length} selected)',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


