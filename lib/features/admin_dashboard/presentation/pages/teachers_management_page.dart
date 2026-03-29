import 'package:flutter/material.dart';

/// Teachers Management Page
/// This page allows admins to manage teachers - add, edit, delete, and view teacher details
class TeachersManagementPage extends StatefulWidget {
  const TeachersManagementPage({super.key});

  @override
  State<TeachersManagementPage> createState() => _TeachersManagementPageState();
}

class _TeachersManagementPageState extends State<TeachersManagementPage> {
  // Sample teacher data
  List<Map<String, dynamic>> teachers = [
    {
      'id': 'T001',
      'name': 'Mrs. Sarah Williams',
      'email': 'sarah@example.com',
      'subject': 'Mathematics',
      'experience': '8 years',
      'status': 'Active',
    },
    {
      'id': 'T002',
      'name': 'Mr. David Brown',
      'email': 'david@example.com',
      'subject': 'English',
      'experience': '5 years',
      'status': 'Active',
    },
    {
      'id': 'T003',
      'name': 'Mrs. Emily Davis',
      'email': 'emily@example.com',
      'subject': 'Science',
      'experience': '10 years',
      'status': 'Active',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teachers Management'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search and Filter Section
            _buildSearchBar(),
            const SizedBox(height: 20),

            // Teachers List
            Expanded(
              child: teachers.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      itemCount: teachers.length,
                      itemBuilder: (context, index) {
                        return _buildTeacherCard(teachers[index], index);
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTeacherDialog,
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Build search bar and filter options
  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search teachers...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterOptions,
          ),
        ),
      ],
    );
  }

  /// Build teacher card
  Widget _buildTeacherCard(Map<String, dynamic> teacher, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.orange,
          child: Text(
            teacher['name'][0],
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          teacher['name'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Subject: ${teacher['subject']}'),
            Text('Experience: ${teacher['experience']}'),
          ],
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: const Text('View'),
              onTap: () => _showTeacherDetails(teacher),
            ),
            PopupMenuItem(
              child: const Text('Edit'),
              onTap: () => _showEditTeacherDialog(teacher, index),
            ),
            PopupMenuItem(
              child: const Text('Delete'),
              onTap: () => _deleteTeacher(index),
            ),
          ],
        ),
      ),
    );
  }

  /// Build empty state widget
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.school_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No teachers found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add a new teacher to get started',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  /// Show add teacher dialog
  void _showAddTeacherDialog() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final subjectController = TextEditingController();
    final experienceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Teacher'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Teacher Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: subjectController,
                decoration: InputDecoration(
                  labelText: 'Subject',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: experienceController,
                decoration: InputDecoration(
                  labelText: 'Experience',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  emailController.text.isNotEmpty &&
                  subjectController.text.isNotEmpty &&
                  experienceController.text.isNotEmpty) {
                setState(() {
                  teachers.add({
                    'id': 'T${teachers.length + 1}',
                    'name': nameController.text,
                    'email': emailController.text,
                    'subject': subjectController.text,
                    'experience': experienceController.text,
                    'status': 'Active',
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Teacher added successfully')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  /// Show edit teacher dialog
  void _showEditTeacherDialog(Map<String, dynamic> teacher, int index) {
    final nameController = TextEditingController(text: teacher['name']);
    final emailController = TextEditingController(text: teacher['email']);
    final subjectController = TextEditingController(text: teacher['subject']);
    final experienceController = TextEditingController(text: teacher['experience']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Teacher'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Teacher Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: subjectController,
                decoration: InputDecoration(
                  labelText: 'Subject',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: experienceController,
                decoration: InputDecoration(
                  labelText: 'Experience',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  emailController.text.isNotEmpty &&
                  subjectController.text.isNotEmpty &&
                  experienceController.text.isNotEmpty) {
                setState(() {
                  teachers[index] = {
                    'id': teacher['id'],
                    'name': nameController.text,
                    'email': emailController.text,
                    'subject': subjectController.text,
                    'experience': experienceController.text,
                    'status': teacher['status'],
                  };
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Teacher updated successfully')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
            ),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  /// Show teacher details
  void _showTeacherDetails(Map<String, dynamic> teacher) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(teacher['name']),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ID: ${teacher['id']}'),
              const SizedBox(height: 8),
              Text('Email: ${teacher['email']}'),
              const SizedBox(height: 8),
              Text('Subject: ${teacher['subject']}'),
              const SizedBox(height: 8),
              Text('Experience: ${teacher['experience']}'),
              const SizedBox(height: 8),
              Text('Status: ${teacher['status']}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  /// Delete a teacher
  void _deleteTeacher(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Teacher'),
        content: const Text('Are you sure you want to delete this teacher?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                teachers.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Teacher deleted successfully')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  /// Show filter options
  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter by Subject',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text('Mathematics'),
              value: false,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: const Text('English'),
              value: false,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: const Text('Science'),
              value: false,
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                child: const Text('Apply Filters'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

