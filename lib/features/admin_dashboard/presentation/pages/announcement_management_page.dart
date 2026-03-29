import 'package:flutter/material.dart';

/// Announcement Management Page
/// This page allows admins to create, edit, delete, and manage announcements
class AnnouncementManagementPage extends StatefulWidget {
  const AnnouncementManagementPage({super.key});

  @override
  State<AnnouncementManagementPage> createState() => _AnnouncementManagementPageState();
}

class _AnnouncementManagementPageState extends State<AnnouncementManagementPage> {
  // Sample announcement data
  List<Map<String, dynamic>> announcements = [
    {
      'id': 'A001',
      'title': 'School Closure Notice',
      'content': 'School will be closed on March 15-17 for maintenance.',
      'date': 'March 10, 2026',
      'target': 'All Students & Parents',
      'status': 'Published',
    },
    {
      'id': 'A002',
      'title': 'Exam Schedule Released',
      'content': 'Final exams will start from March 20, 2026. Check the notice board for details.',
      'date': 'March 8, 2026',
      'target': 'All Students',
      'status': 'Published',
    },
    {
      'id': 'A003',
      'title': 'Parent-Teacher Meeting',
      'content': 'PTM scheduled for March 25, 2026 from 2 PM to 5 PM.',
      'date': 'March 5, 2026',
      'target': 'Parents & Teachers',
      'status': 'Draft',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcement Management'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Filter tabs
            _buildFilterTabs(),
            const SizedBox(height: 16),

            // Announcements List
            Expanded(
              child: announcements.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      itemCount: announcements.length,
                      itemBuilder: (context, index) {
                        return _buildAnnouncementCard(announcements[index], index);
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddAnnouncementDialog,
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Build filter tabs
  Widget _buildFilterTabs() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search announcements...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
      ],
    );
  }

  /// Build announcement card
  Widget _buildAnnouncementCard(Map<String, dynamic> announcement, int index) {
    final isPublished = announcement['status'] == 'Published';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isPublished ? Colors.green.shade100 : Colors.orange.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            isPublished ? Icons.check_circle : Icons.schedule,
            color: isPublished ? Colors.green : Colors.orange,
          ),
        ),
        title: Text(
          announcement['title'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              announcement['content'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            Text(
              'Posted: ${announcement['date']}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: const Text('View'),
              onTap: () => _showAnnouncementDetails(announcement),
            ),
            PopupMenuItem(
              child: const Text('Edit'),
              onTap: () => _showEditAnnouncementDialog(announcement, index),
            ),
            if (announcement['status'] == 'Draft')
              PopupMenuItem(
                child: const Text('Publish'),
                onTap: () => _publishAnnouncement(index),
              ),
            PopupMenuItem(
              child: const Text('Delete'),
              onTap: () => _deleteAnnouncement(index),
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
            Icons.notifications_none,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No announcements found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create a new announcement to get started',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  /// Show add announcement dialog
  void _showAddAnnouncementDialog() {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    String selectedTarget = 'All Students & Parents';
    bool isDraft = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Create New Announcement'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: contentController,
                  decoration: InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: selectedTarget,
                  items: ['All Students & Parents', 'All Students', 'Parents Only', 'Teachers Only']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    setState(() => selectedTarget = value ?? 'All Students & Parents');
                  },
                  decoration: InputDecoration(
                    labelText: 'Target Audience',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                CheckboxListTile(
                  title: const Text('Save as Draft'),
                  value: isDraft,
                  onChanged: (value) {
                    setState(() => isDraft = value ?? false);
                  },
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
                if (titleController.text.isNotEmpty &&
                    contentController.text.isNotEmpty) {
                  this.setState(() {
                    announcements.add({
                      'id': 'A${announcements.length + 1}',
                      'title': titleController.text,
                      'content': contentController.text,
                      'date': 'March 12, 2026',
                      'target': selectedTarget,
                      'status': isDraft ? 'Draft' : 'Published',
                    });
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(this.context).showSnackBar(
                    SnackBar(
                      content: Text(isDraft
                          ? 'Announcement saved as draft'
                          : 'Announcement published successfully'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }

  /// Show edit announcement dialog
  void _showEditAnnouncementDialog(Map<String, dynamic> announcement, int index) {
    final titleController = TextEditingController(text: announcement['title']);
    final contentController = TextEditingController(text: announcement['content']);
    String selectedTarget = announcement['target'];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Edit Announcement'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: contentController,
                  decoration: InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: selectedTarget,
                  items: ['All Students & Parents', 'All Students', 'Parents Only', 'Teachers Only']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    setState(() => selectedTarget = value ?? 'All Students & Parents');
                  },
                  decoration: InputDecoration(
                    labelText: 'Target Audience',
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
                if (titleController.text.isNotEmpty &&
                    contentController.text.isNotEmpty) {
                  this.setState(() {
                    announcements[index] = {
                      'id': announcement['id'],
                      'title': titleController.text,
                      'content': contentController.text,
                      'date': announcement['date'],
                      'target': selectedTarget,
                      'status': announcement['status'],
                    };
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(this.context).showSnackBar(
                    const SnackBar(content: Text('Announcement updated successfully')),
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
      ),
    );
  }

  /// Show announcement details
  void _showAnnouncementDetails(Map<String, dynamic> announcement) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(announcement['title']),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(announcement['content']),
              const SizedBox(height: 16),
              Text('Posted: ${announcement['date']}',
                  style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 8),
              Text('Target: ${announcement['target']}',
                  style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: announcement['status'] == 'Published'
                      ? Colors.green.shade100
                      : Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  announcement['status'],
                  style: TextStyle(
                    color: announcement['status'] == 'Published'
                        ? Colors.green
                        : Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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

  /// Publish a draft announcement
  void _publishAnnouncement(int index) {
    setState(() {
      announcements[index]['status'] = 'Published';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Announcement published successfully')),
    );
  }

  /// Delete an announcement
  void _deleteAnnouncement(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Announcement'),
        content: const Text('Are you sure you want to delete this announcement?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                announcements.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Announcement deleted successfully')),
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
}



