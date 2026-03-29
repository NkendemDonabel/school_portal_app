import 'package:flutter/material.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  DateTime _selectedDate = _dateOnly(DateTime.now());
  bool _showCoreOnly = false;

  static final List<_TimetableEntry> _baseSchedule = <_TimetableEntry>[
    _TimetableEntry(
      time: '08:00 - 09:00',
      subject: 'Mathematics',
      grade: 'Grade 5',
      room: 'Room A1',
      color: Color(0xFF1976D2),
      isCore: true,
      weekdays: [DateTime.monday, DateTime.wednesday, DateTime.friday],
    ),
    _TimetableEntry(
      time: '09:10 - 10:00',
      subject: 'English Language',
      grade: 'Grade 6',
      room: 'Room B2',
      color: Color(0xFF388E3C),
      isCore: true,
      weekdays: [DateTime.monday, DateTime.tuesday, DateTime.thursday],
    ),
    _TimetableEntry(
      time: '10:20 - 11:10',
      subject: 'Science',
      grade: 'Grade 5',
      room: 'Lab 1',
      color: Color(0xFF7B1FA2),
      isCore: false,
      weekdays: [DateTime.tuesday, DateTime.wednesday],
    ),
    _TimetableEntry(
      time: '11:20 - 12:10',
      subject: 'Civic Education',
      grade: 'Grade 6',
      room: 'Room C3',
      color: Color(0xFFE65100),
      isCore: false,
      weekdays: [DateTime.thursday],
    ),
    _TimetableEntry(
      time: '12:40 - 13:30',
      subject: 'Planning / Free Period',
      grade: '-',
      room: 'Staff Room',
      color: Color(0xFF546E7A),
      isCore: false,
      weekdays: [
        DateTime.monday,
        DateTime.tuesday,
        DateTime.wednesday,
        DateTime.thursday,
        DateTime.friday
      ],
    ),
  ];

  List<_TimetableEntry> get _entriesForSelectedDate {
    final weekday = _selectedDate.weekday;
    var result = _baseSchedule.where((e) => e.weekdays.contains(weekday)).toList();
    if (_showCoreOnly) {
      result = result.where((e) => e.isCore).toList();
    }
    return result;
  }

  static DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  void _goToPreviousDay() {
    setState(() {
      _selectedDate = _selectedDate.subtract(const Duration(days: 1));
    });
  }

  void _goToNextDay() {
    setState(() {
      _selectedDate = _selectedDate.add(const Duration(days: 1));
    });
  }

  void _goToToday() {
    setState(() {
      _selectedDate = _dateOnly(DateTime.now());
    });
  }

  Future<void> _pickDate() async {
    final today = _dateOnly(DateTime.now());
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(today.year - 5),
      lastDate: DateTime(today.year + 5),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = _dateOnly(picked);
      });
    }
  }

  List<DateTime> _dateStrip() {
    return List<DateTime>.generate(
      15,
      (index) => _selectedDate.add(Duration(days: index - 7)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.sizeOf(context).width >= 600;
    final entries = _entriesForSelectedDate;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text('Timetable', style: TextStyle(fontWeight: FontWeight.w700)),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _DateHeader(
              selectedDate: _selectedDate,
              onPrev: _goToPreviousDay,
              onNext: _goToNextDay,
              onToday: _goToToday,
              onPickDate: _pickDate,
            ),
            _DateStrip(
              dates: _dateStrip(),
              selectedDate: _selectedDate,
              onSelect: (d) => setState(() => _selectedDate = d),
            ),
            _FilterBar(
              showCoreOnly: _showCoreOnly,
              onToggle: (v) => setState(() => _showCoreOnly = v),
            ),
            Expanded(
              child: entries.isEmpty
                  ? _EmptySchedule(selectedDate: _selectedDate)
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 32 : 16,
                        vertical: 16,
                      ),
                      itemCount: entries.length,
                      itemBuilder: (_, index) => _TimetableCard(entry: entries[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateHeader extends StatelessWidget {
  const _DateHeader({
    required this.selectedDate,
    required this.onPrev,
    required this.onNext,
    required this.onToday,
    required this.onPickDate,
  });

  final DateTime selectedDate;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final VoidCallback onToday;
  final VoidCallback onPickDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1565C0),
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: onPrev,
                icon: const Icon(Icons.chevron_left, color: Colors.white),
                tooltip: 'Previous day',
              ),
              Expanded(
                child: InkWell(
                  onTap: onPickDate,
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      children: [
                        Text(
                          _weekdayName(selectedDate.weekday),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _fullDate(selectedDate),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: onNext,
                icon: const Icon(Icons.chevron_right, color: Colors.white),
                tooltip: 'Next day',
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onToday,
              icon: const Icon(Icons.today, size: 16, color: Colors.white),
              label: const Text('Today', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

class _DateStrip extends StatelessWidget {
  const _DateStrip({
    required this.dates,
    required this.selectedDate,
    required this.onSelect,
  });

  final List<DateTime> dates;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 74,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        itemCount: dates.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final d = dates[i];
          final isSelected = _sameDate(d, selectedDate);

          return InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => onSelect(d),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              width: 62,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF1565C0) : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected ? const Color(0xFF1565C0) : Colors.black12,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _shortWeekday(d.weekday),
                    style: TextStyle(
                      fontSize: 11,
                      color: isSelected ? Colors.white : Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${d.day}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? Colors.white : const Color(0xFF1A1A2E),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({
    required this.showCoreOnly,
    required this.onToggle,
  });

  final bool showCoreOnly;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Row(
        children: [
          const Text(
            'Class subject list',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Color(0xFF1A1A2E),
            ),
          ),
          const Spacer(),
          const Text('Core only', style: TextStyle(fontSize: 12)),
          Switch(
            value: showCoreOnly,
            onChanged: onToggle,
            activeColor: const Color(0xFF1565C0),
          ),
        ],
      ),
    );
  }
}

class _EmptySchedule extends StatelessWidget {
  const _EmptySchedule({required this.selectedDate});
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.event_busy, size: 54, color: Colors.grey.shade500),
            const SizedBox(height: 10),
            const Text(
              'No classes scheduled',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 6),
            Text(
              'There are no timetable entries for ${_fullDate(selectedDate)}.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimetableCard extends StatelessWidget {
  const _TimetableCard({required this.entry});
  final _TimetableEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 84,
            decoration: BoxDecoration(
              color: entry.color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.subject,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.group_rounded, size: 13, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      Text(entry.grade, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                      const SizedBox(width: 12),
                      Icon(Icons.door_back_door_rounded, size: 13, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          entry.room,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(Icons.access_time_rounded, size: 14, color: entry.color),
                const SizedBox(height: 4),
                Text(
                  entry.time,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: entry.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimetableEntry {
  const _TimetableEntry({
    required this.time,
    required this.subject,
    required this.grade,
    required this.room,
    required this.color,
    required this.isCore,
    required this.weekdays,
  });

  final String time;
  final String subject;
  final String grade;
  final String room;
  final Color color;
  final bool isCore;
  final List<int> weekdays;
}

bool _sameDate(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

String _weekdayName(int weekday) {
  const names = <int, String>{
    DateTime.monday: 'Monday',
    DateTime.tuesday: 'Tuesday',
    DateTime.wednesday: 'Wednesday',
    DateTime.thursday: 'Thursday',
    DateTime.friday: 'Friday',
    DateTime.saturday: 'Saturday',
    DateTime.sunday: 'Sunday',
  };
  return names[weekday] ?? '';
}

String _shortWeekday(int weekday) {
  const names = <int, String>{
    DateTime.monday: 'Mon',
    DateTime.tuesday: 'Tue',
    DateTime.wednesday: 'Wed',
    DateTime.thursday: 'Thu',
    DateTime.friday: 'Fri',
    DateTime.saturday: 'Sat',
    DateTime.sunday: 'Sun',
  };
  return names[weekday] ?? '';
}

String _monthName(int month) {
  const names = <int, String>{
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'September',
    10: 'October',
    11: 'November',
    12: 'December',
  };
  return names[month] ?? '';
}

String _fullDate(DateTime date) {
  return '${date.day} ${_monthName(date.month)} ${date.year}';
}