import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final List<_Student> _students = [
    _Student(name: 'Amina Yusuf', rollNo: 'S001', isPresent: true),
    _Student(name: 'John Peter', rollNo: 'S002', isPresent: false),
    _Student(name: 'Esther James', rollNo: 'S003', isPresent: true),
    _Student(name: 'David Paul', rollNo: 'S004', isPresent: false),
    _Student(name: 'Ruth Michael', rollNo: 'S005', isPresent: true),
    _Student(name: 'Samuel Obi', rollNo: 'S006', isPresent: true),
    _Student(name: 'Grace Emeka', rollNo: 'S007', isPresent: false),
    _Student(name: 'Daniel Chukwu', rollNo: 'S008', isPresent: true),
  ];

  final List<String> _lectures = const [
    'Mathematics - Grade 5',
    'English - Grade 6',
    'Science - Grade 5',
    'Civic Education - Grade 6',
  ];

  String _selectedLecture = 'Mathematics - Grade 5';
  DateTime _selectedDate = DateTime.now();

  int get _presentCount => _students.where((s) => s.isPresent).length;
  int get _absentCount => _students.where((s) => !s.isPresent).length;

  void _markAll(bool present) {
    setState(() {
      for (final s in _students) {
        s.isPresent = present;
      }
    });
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.sizeOf(context).width >= 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text(
          'Attendance',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xFF388E3C),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (v) => _markAll(v == 'all'),
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'all', child: Text('Mark All Present')),
              PopupMenuItem(value: 'none', child: Text('Mark All Absent')),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _LectureContextBar(
              selectedLecture: _selectedLecture,
              lectures: _lectures,
              selectedDateLabel: _formatDate(_selectedDate),
              onLectureChanged: (value) {
                if (value != null) {
                  setState(() => _selectedLecture = value);
                }
              },
              onPickDate: _pickDate,
            ),
            _AttendanceSummaryBar(
              present: _presentCount,
              absent: _absentCount,
              total: _students.length,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 32 : 16,
                  vertical: 12,
                ),
                itemCount: _students.length,
                itemBuilder: (_, index) {
                  final student = _students[index];
                  return _StudentAttendanceCard(
                    student: student,
                    onPresentChanged: (val) {
                      setState(() => student.isPresent = val ?? false);
                    },
                    onAbsentChanged: (val) {
                      setState(() => student.isPresent = !(val ?? false));
                    },
                  );
                },
              ),
            ),
            _SaveBar(
              onSave: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Saved: $_selectedLecture on ${_formatDate(_selectedDate)} '
                      '($_presentCount present, $_absentCount absent).',
                    ),
                    backgroundColor: const Color(0xFF388E3C),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LectureContextBar extends StatelessWidget {
  const _LectureContextBar({
    required this.selectedLecture,
    required this.lectures,
    required this.selectedDateLabel,
    required this.onLectureChanged,
    required this.onPickDate,
  });

  final String selectedLecture;
  final List<String> lectures;
  final String selectedDateLabel;
  final ValueChanged<String?> onLectureChanged;
  final VoidCallback onPickDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF388E3C),
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            value: selectedLecture,
            dropdownColor: Colors.white,
            iconEnabledColor: Colors.white,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.16),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(color: Colors.white, fontSize: 13),
            items: lectures
                .map((l) => DropdownMenuItem<String>(
                      value: l,
                      child: Text(
                        l,
                        style: const TextStyle(color: Colors.black87),
                      ),
                    ))
                .toList(),
            onChanged: onLectureChanged,
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton.icon(
              onPressed: onPickDate,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white.withValues(alpha: 0.65)),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              icon: const Icon(Icons.calendar_today_rounded, size: 16),
              label: Text('Lecture Date: $selectedDateLabel'),
            ),
          ),
        ],
      ),
    );
  }
}

class _AttendanceSummaryBar extends StatelessWidget {
  const _AttendanceSummaryBar({
    required this.present,
    required this.absent,
    required this.total,
  });

  final int present;
  final int absent;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF388E3C),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Row(
        children: [
          _SummaryChip(label: 'Total', value: '$total', color: Colors.white),
          const SizedBox(width: 12),
          _SummaryChip(
            label: 'Present',
            value: '$present',
            color: Colors.greenAccent,
          ),
          const SizedBox(width: 12),
          _SummaryChip(
            label: 'Absent',
            value: '$absent',
            color: Colors.redAccent.shade100,
          ),
        ],
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _StudentAttendanceCard extends StatelessWidget {
  const _StudentAttendanceCard({
    required this.student,
    required this.onPresentChanged,
    required this.onAbsentChanged,
  });

  final _Student student;
  final ValueChanged<bool?> onPresentChanged;
  final ValueChanged<bool?> onAbsentChanged;

  @override
  Widget build(BuildContext context) {
    final presentColor = const Color(0xFF388E3C);
    final absentColor = const Color(0xFFD32F2F);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 8, 8, 8),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: student.isPresent
                  ? presentColor.withValues(alpha: 0.15)
                  : absentColor.withValues(alpha: 0.12),
              child: Text(
                student.name[0],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: student.isPresent ? presentColor : absentColor,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    student.rollNo,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _CheckTag(
                  label: 'Present',
                  active: student.isPresent,
                  activeColor: presentColor,
                  value: student.isPresent,
                  onChanged: onPresentChanged,
                ),
                const SizedBox(width: 6),
                _CheckTag(
                  label: 'Absent',
                  active: !student.isPresent,
                  activeColor: absentColor,
                  value: !student.isPresent,
                  onChanged: onAbsentChanged,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckTag extends StatelessWidget {
  const _CheckTag({
    required this.label,
    required this.active,
    required this.activeColor,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool active;
  final Color activeColor;
  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: active ? activeColor.withValues(alpha: 0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: active ? activeColor.withValues(alpha: 0.35) : Colors.black12,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: active ? activeColor : Colors.grey.shade600,
            ),
          ),
          Checkbox(
            value: value,
            onChanged: onChanged,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: activeColor,
          ),
        ],
      ),
    );
  }
}

class _SaveBar extends StatelessWidget {
  const _SaveBar({required this.onSave});
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton.icon(
          onPressed: onSave,
          icon: const Icon(Icons.save_rounded),
          label: const Text(
            'Save Attendance',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF388E3C),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
        ),
      ),
    );
  }
}

class _Student {
  _Student({
    required this.name,
    required this.rollNo,
    required this.isPresent,
  });

  final String name;
  final String rollNo;
  bool isPresent;
}