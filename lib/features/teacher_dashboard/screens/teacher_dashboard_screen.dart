import 'package:flutter/material.dart';

import 'announcement_screen.dart';
import 'attendance_screen.dart';
import 'results_grading_screen.dart';
import 'timetable_screen.dart';

class TeacherDashboardScreen extends StatelessWidget {
  const TeacherDashboardScreen({super.key});

  static const _sections = <_TeacherSection>[
    _TeacherSection(
      title: 'Timetable',
      subtitle: 'View and manage your class schedule',
      icon: Icons.calendar_today_rounded,
      gradient: [Color(0xFF1976D2), Color(0xFF42A5F5)],
      destination: TimetableScreen(),
    ),
    _TeacherSection(
      title: 'Attendance',
      subtitle: 'Mark and review student attendance',
      icon: Icons.fact_check_rounded,
      gradient: [Color(0xFF388E3C), Color(0xFF66BB6A)],
      destination: AttendanceScreen(),
    ),
    _TeacherSection(
      title: 'Results & Grading',
      subtitle: 'Manage scores, grades and feedback',
      icon: Icons.grading_rounded,
      gradient: [Color(0xFF7B1FA2), Color(0xFFBA68C8)],
      destination: ResultsGradingScreen(),
    ),
    _TeacherSection(
      title: 'Announcements',
      subtitle: 'View school updates and notices',
      icon: Icons.campaign_rounded,
      gradient: [Color(0xFF0D47A1), Color(0xFF1976D2)],
      destination: AnnouncementScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isTablet = size.width >= 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 32 : 16,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _WelcomeBanner(isTablet: isTablet),
              const SizedBox(height: 28),
              _SectionLabel(label: 'Quick Access'),
              const SizedBox(height: 14),
              _ResponsiveGrid(sections: _sections, isTablet: isTablet),
              const SizedBox(height: 28),
              _SectionLabel(label: "Today's Summary"),
              const SizedBox(height: 14),
              _SummaryRow(isTablet: isTablet),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      elevation: 0,
      backgroundColor: const Color(0xFF1565C0),
      foregroundColor: Colors.white,
      title: const Text(
        'Teacher Dashboard',
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {},
          tooltip: 'Notifications',
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: CircleAvatar(
            backgroundColor: Colors.white24,
            child: const Icon(Icons.person, color: Colors.white, size: 20),
          ),
        ),
      ],
    );
  }
}

// ─── Welcome Banner ────────────────────────────────────────────────────────────

class _WelcomeBanner extends StatelessWidget {
  const _WelcomeBanner({required this.isTablet});
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isTablet ? 24 : 18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1565C0), Color(0xFF1E88E5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1565C0).withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back, Teacher! 👋',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTablet ? 22 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'You have access to this dashboard to manage your '
                  'daily classroom activities. Use the sections below '
                  'to get started.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.88),
                    fontSize: isTablet ? 14 : 13,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.calendar_month_rounded, color: Colors.white, size: 14),
                      SizedBox(width: 6),
                      Text(
                        'Monday, Term 2 — 2025/2026',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isTablet) ...[
            const SizedBox(width: 16),
            const Icon(Icons.school_rounded, size: 72, color: Colors.white24),
          ],
        ],
      ),
    );
  }
}

// ─── Section Label ─────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: const Color(0xFF1565C0),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A2E),
          ),
        ),
      ],
    );
  }
}

// ─── Responsive Grid ───────────────────────────────────────────────────────────

class _ResponsiveGrid extends StatelessWidget {
  const _ResponsiveGrid({required this.sections, required this.isTablet});
  final List<_TeacherSection> sections;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = isTablet ? 3 : 2;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sections.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: isTablet ? 1.2 : 1.05,
      ),
      itemBuilder: (context, index) {
        return _ManagementCard(section: sections[index]);
      },
    );
  }
}

// ─── Management Card ───────────────────────────────────────────────────────────

class _ManagementCard extends StatelessWidget {
  const _ManagementCard({required this.section});
  final _TeacherSection section;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => section.destination),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.07),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: section.gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(section.icon, color: Colors.white, size: 22),
              ),
              const Spacer(),
              Text(
                section.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                section.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Open',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: section.gradient.first,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.arrow_forward_rounded, size: 13, color: section.gradient.first),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Summary Row ───────────────────────────────────────────────────────────────

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.isTablet});
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    final stats = [
      _Stat(label: 'Classes Today', value: '4', icon: Icons.class_rounded, color: const Color(0xFF1976D2)),
      _Stat(label: 'Present', value: '28', icon: Icons.check_circle_rounded, color: const Color(0xFF388E3C)),
      _Stat(label: 'Absent', value: '3', icon: Icons.cancel_rounded, color: const Color(0xFFD32F2F)),
    ];

    return Row(
      children: stats.map((stat) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _StatCard(stat: stat),
          ),
        );
      }).toList(),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.stat});
  final _Stat stat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
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
      child: Column(
        children: [
          Icon(stat.icon, color: stat.color, size: 24),
          const SizedBox(height: 6),
          Text(
            stat.value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: stat.color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            stat.label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

// ─── Data Models ───────────────────────────────────────────────────────────────

class _TeacherSection {
  const _TeacherSection({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.destination,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradient;
  final Widget destination;
}

class _Stat {
  const _Stat({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;
}

