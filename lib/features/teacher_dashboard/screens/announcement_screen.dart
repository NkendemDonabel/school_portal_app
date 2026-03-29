import 'package:flutter/material.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final announcements = <({String title, String detail, String date})>[
      (
        title: 'Staff Meeting',
        detail: 'All teachers are to meet in the conference hall by 3:30 PM.',
        date: '29 Mar 2026',
      ),
      (
        title: 'Exam Preparation Week',
        detail: 'Ensure revision plans are uploaded before Friday.',
        date: '27 Mar 2026',
      ),
      (
        title: 'New Attendance Policy',
        detail: 'Attendance must be submitted before 2:00 PM daily.',
        date: '25 Mar 2026',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text('Announcements', style: TextStyle(fontWeight: FontWeight.w700)),
        backgroundColor: const Color(0xFF0D47A1),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: announcements.length,
          itemBuilder: (_, index) {
            final item = announcements[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFE3F2FD),
                  child: Icon(Icons.campaign_rounded, color: Color(0xFF1565C0)),
                ),
                title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w700)),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(item.detail),
                ),
                trailing: Text(
                  item.date,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

