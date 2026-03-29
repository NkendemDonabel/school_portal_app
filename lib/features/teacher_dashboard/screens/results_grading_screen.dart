import 'package:flutter/material.dart';

class ResultsGradingScreen extends StatefulWidget {
  const ResultsGradingScreen({super.key});

  @override
  State<ResultsGradingScreen> createState() => _ResultsGradingScreenState();
}

class _ResultsGradingScreenState extends State<ResultsGradingScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<String> _subjects = const [
    'Mathematics',
    'English Language',
    'Science',
    'Civic Education',
  ];

  final List<_StudentResult> _results = [
    _StudentResult(
      name: 'Amina Yusuf',
      rollNo: 'S001',
      subject: 'Mathematics',
      score: 82,
      examType: 'Midterm',
      examDate: DateTime(2026, 2, 15),
    ),
    _StudentResult(
      name: 'John Peter',
      rollNo: 'S002',
      subject: 'Mathematics',
      score: 67,
      examType: 'Midterm',
      examDate: DateTime(2026, 2, 15),
    ),
    _StudentResult(
      name: 'Esther James',
      rollNo: 'S003',
      subject: 'Mathematics',
      score: 74,
      examType: 'Midterm',
      examDate: DateTime(2026, 2, 15),
    ),
    _StudentResult(
      name: 'David Paul',
      rollNo: 'S004',
      subject: 'Mathematics',
      score: 55,
      examType: 'Midterm',
      examDate: DateTime(2026, 2, 15),
    ),
    _StudentResult(
      name: 'Ruth Michael',
      rollNo: 'S005',
      subject: 'Mathematics',
      score: 91,
      examType: 'Midterm',
      examDate: DateTime(2026, 2, 15),
    ),
    _StudentResult(
      name: 'Samuel Obi',
      rollNo: 'S006',
      subject: 'Mathematics',
      score: 48,
      examType: 'Midterm',
      examDate: DateTime(2026, 2, 15),
    ),
    _StudentResult(
      name: 'Grace Emeka',
      rollNo: 'S007',
      subject: 'Mathematics',
      score: 79,
      examType: 'Midterm',
      examDate: DateTime(2026, 2, 15),
    ),
    _StudentResult(
      name: 'Daniel Chukwu',
      rollNo: 'S008',
      subject: 'Mathematics',
      score: 63,
      examType: 'Midterm',
      examDate: DateTime(2026, 2, 15),
    ),
  ];

  // Form state
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _rollNoController = TextEditingController();
  final TextEditingController _scoreController = TextEditingController();
  String _selectedSubject = 'Mathematics';
  String _selectedExamType = 'Class Test';
  DateTime _selectedExamDate = DateTime.now();

  // History table sort state
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _studentNameController.dispose();
    _rollNoController.dispose();
    _scoreController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  double get _average => _results.isEmpty
      ? 0
      : _results.map((r) => r.score).reduce((a, b) => a + b) / _results.length;

  int get _highScore => _results.isEmpty
      ? 0
      : _results.map((r) => r.score).reduce((a, b) => a > b ? a : b);

  int get _lowScore => _results.isEmpty
      ? 0
      : _results.map((r) => r.score).reduce((a, b) => a < b ? a : b);

  Future<void> _pickExamDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedExamDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked != null) {
      setState(() => _selectedExamDate = picked);
    }
  }

  void _submitMark() {
    if (!_formKey.currentState!.validate()) return;

    final score = int.parse(_scoreController.text.trim());
    final record = _StudentResult(
      name: _studentNameController.text.trim(),
      rollNo: _rollNoController.text.trim(),
      subject: _selectedSubject,
      score: score,
      examType: _selectedExamType,
      examDate: _selectedExamDate,
    );

    setState(() {
      _results.insert(0, record);
      _studentNameController.clear();
      _rollNoController.clear();
      _scoreController.clear();
      _selectedSubject = 'Mathematics';
      _selectedExamType = 'Class Test';
      _selectedExamDate = DateTime.now();
      _tabController.animateTo(0);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Exam mark added successfully.')),
    );
  }

  void _sortHistory<T>(
    int columnIndex,
    bool ascending,
    Comparable<T> Function(_StudentResult r) getField,
  ) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      _results.sort((a, b) {
        final aValue = getField(a);
        final bValue = getField(b);
        return ascending
            ? Comparable.compare(aValue, bValue)
            : Comparable.compare(bValue, aValue);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.sizeOf(context).width >= 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text(
          'Results & Grading',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xFF7B1FA2),
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Results'),
            Tab(text: 'Grade Summary'),
            Tab(text: 'Marks Input'),
            Tab(text: 'History Table'),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            _ResultsTab(results: _results, isTablet: isTablet),
            _GradeSummaryTab(
              results: _results,
              average: _average,
              highScore: _highScore,
              lowScore: _lowScore,
            ),
            _MarksInputTab(
              formKey: _formKey,
              studentNameController: _studentNameController,
              rollNoController: _rollNoController,
              scoreController: _scoreController,
              selectedSubject: _selectedSubject,
              selectedExamType: _selectedExamType,
              selectedExamDate: _selectedExamDate,
              subjects: _subjects,
              onSubjectChanged: (v) {
                if (v != null) setState(() => _selectedSubject = v);
              },
              onExamTypeChanged: (v) {
                if (v != null) setState(() => _selectedExamType = v);
              },
              onPickDate: _pickExamDate,
              onSubmit: _submitMark,
            ),
            _HistoryTableTab(
              results: _results,
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAscending,
              onSort: _sortHistory,
            ),
          ],
        ),
      ),
    );
  }
}

// Results tab
class _ResultsTab extends StatelessWidget {
  const _ResultsTab({required this.results, required this.isTablet});
  final List<_StudentResult> results;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 16, vertical: 16),
      itemCount: results.length,
      itemBuilder: (_, index) => _ResultCard(result: results[index]),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.result});
  final _StudentResult result;

  @override
  Widget build(BuildContext context) {
    final grade = _gradeLabel(result.score);
    final gradeColor = _gradeColor(result.score);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: gradeColor.withValues(alpha: 0.15),
              child: Text(
                result.name[0],
                style: TextStyle(fontWeight: FontWeight.bold, color: gradeColor),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.name,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${result.subject} - ${result.rollNo}',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: result.score / 100,
                      minHeight: 6,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(gradeColor),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: gradeColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    grade,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${result.score}%',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static String _gradeLabel(int score) {
    if (score >= 90) return 'A+';
    if (score >= 80) return 'A';
    if (score >= 70) return 'B';
    if (score >= 60) return 'C';
    if (score >= 50) return 'D';
    return 'F';
  }

  static Color _gradeColor(int score) {
    if (score >= 80) return const Color(0xFF388E3C);
    if (score >= 60) return const Color(0xFF1976D2);
    if (score >= 50) return const Color(0xFFF57C00);
    return const Color(0xFFD32F2F);
  }
}

// Grade summary tab
class _GradeSummaryTab extends StatelessWidget {
  const _GradeSummaryTab({
    required this.results,
    required this.average,
    required this.highScore,
    required this.lowScore,
  });

  final List<_StudentResult> results;
  final double average;
  final int highScore;
  final int lowScore;

  @override
  Widget build(BuildContext context) {
    final gradeCounts = <String, int>{};
    for (final r in results) {
      final g = _gradeLabel(r.score);
      gradeCounts[g] = (gradeCounts[g] ?? 0) + 1;
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _StatBox(
                  label: 'Class Avg',
                  value: '${average.toStringAsFixed(1)}%',
                  color: const Color(0xFF7B1FA2),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _StatBox(
                  label: 'Highest',
                  value: '$highScore%',
                  color: const Color(0xFF388E3C),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _StatBox(
                  label: 'Lowest',
                  value: '$lowScore%',
                  color: const Color(0xFFD32F2F),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Grade Distribution',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                const SizedBox(height: 14),
                ...gradeCounts.entries.map(
                  (e) => _GradeBar(
                    grade: e.key,
                    count: e.value,
                    total: results.length,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String _gradeLabel(int score) {
    if (score >= 90) return 'A+';
    if (score >= 80) return 'A';
    if (score >= 70) return 'B';
    if (score >= 60) return 'C';
    if (score >= 50) return 'D';
    return 'F';
  }
}

// Marks input tab
class _MarksInputTab extends StatelessWidget {
  const _MarksInputTab({
    required this.formKey,
    required this.studentNameController,
    required this.rollNoController,
    required this.scoreController,
    required this.selectedSubject,
    required this.selectedExamType,
    required this.selectedExamDate,
    required this.subjects,
    required this.onSubjectChanged,
    required this.onExamTypeChanged,
    required this.onPickDate,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController studentNameController;
  final TextEditingController rollNoController;
  final TextEditingController scoreController;
  final String selectedSubject;
  final String selectedExamType;
  final DateTime selectedExamDate;
  final List<String> subjects;
  final ValueChanged<String?> onSubjectChanged;
  final ValueChanged<String?> onExamTypeChanged;
  final VoidCallback onPickDate;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.sizeOf(context).width >= 600;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 16, vertical: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Exam Marks Input Form',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: studentNameController,
                decoration: const InputDecoration(
                  labelText: 'Student Name',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Enter student name' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: rollNoController,
                decoration: const InputDecoration(
                  labelText: 'Roll Number',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Enter roll number' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedSubject,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  border: OutlineInputBorder(),
                ),
                items: subjects
                    .map((s) => DropdownMenuItem<String>(value: s, child: Text(s)))
                    .toList(),
                onChanged: onSubjectChanged,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedExamType,
                decoration: const InputDecoration(
                  labelText: 'Exam Type',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'Class Test', child: Text('Class Test')),
                  DropdownMenuItem(value: 'Midterm', child: Text('Midterm')),
                  DropdownMenuItem(value: 'Final', child: Text('Final')),
                ],
                onChanged: onExamTypeChanged,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: scoreController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Score (0 - 100)',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Enter score';
                  final n = int.tryParse(v.trim());
                  if (n == null) return 'Score must be a number';
                  if (n < 0 || n > 100) return 'Score must be between 0 and 100';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: onPickDate,
                icon: const Icon(Icons.calendar_today_rounded),
                label: Text('Exam Date: ${_formatDate(selectedExamDate)}'),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onSubmit,
                  icon: const Icon(Icons.save_rounded),
                  label: const Text('Save Mark'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _formatDate(DateTime date) {
    const m = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${date.day} ${m[date.month]} ${date.year}';
  }
}

// History table tab
class _HistoryTableTab extends StatelessWidget {
  const _HistoryTableTab({
    required this.results,
    required this.sortColumnIndex,
    required this.sortAscending,
    required this.onSort,
  });

  final List<_StudentResult> results;
  final int sortColumnIndex;
  final bool sortAscending;
  final void Function<T>(
    int columnIndex,
    bool ascending,
    Comparable<T> Function(_StudentResult r) getField,
  ) onSort;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final minWidth = constraints.maxWidth < 800 ? 800.0 : constraints.maxWidth;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: minWidth,
              child: DataTable(
                sortColumnIndex: sortColumnIndex,
                sortAscending: sortAscending,
                columns: [
                  DataColumn(
                    label: const Text('Student'),
                    onSort: (i, asc) =>
                        onSort<String>(i, asc, (r) => r.name.toLowerCase()),
                  ),
                  DataColumn(
                    label: const Text('Roll No'),
                    onSort: (i, asc) =>
                        onSort<String>(i, asc, (r) => r.rollNo.toLowerCase()),
                  ),
                  DataColumn(
                    label: const Text('Subject'),
                    onSort: (i, asc) =>
                        onSort<String>(i, asc, (r) => r.subject.toLowerCase()),
                  ),
                  DataColumn(
                    label: const Text('Exam'),
                    onSort: (i, asc) =>
                        onSort<String>(i, asc, (r) => r.examType.toLowerCase()),
                  ),
                  DataColumn(
                    numeric: true,
                    label: const Text('Score'),
                    onSort: (i, asc) => onSort<num>(i, asc, (r) => r.score),
                  ),
                  DataColumn(
                    label: const Text('Grade'),
                    onSort: (i, asc) =>
                        onSort<String>(i, asc, (r) => _gradeLabel(r.score)),
                  ),
                  DataColumn(
                    label: const Text('Date'),
                    onSort: (i, asc) => onSort<num>(
                      i,
                      asc,
                      (r) => r.examDate.millisecondsSinceEpoch,
                    ),
                  ),
                ],
                rows: results.map((r) {
                  final grade = _gradeLabel(r.score);
                  return DataRow(
                    cells: [
                      DataCell(Text(r.name)),
                      DataCell(Text(r.rollNo)),
                      DataCell(Text(r.subject)),
                      DataCell(Text(r.examType)),
                      DataCell(Text('${r.score}%')),
                      DataCell(Text(grade)),
                      DataCell(Text(_formatDate(r.examDate))),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  static String _gradeLabel(int score) {
    if (score >= 90) return 'A+';
    if (score >= 80) return 'A';
    if (score >= 70) return 'B';
    if (score >= 60) return 'C';
    if (score >= 50) return 'D';
    return 'F';
  }

  static String _formatDate(DateTime date) {
    const m = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${date.day} ${m[date.month]} ${date.year}';
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({required this.label, required this.value, required this.color});
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
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
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}

class _GradeBar extends StatelessWidget {
  const _GradeBar({required this.grade, required this.count, required this.total});
  final String grade;
  final int count;
  final int total;

  @override
  Widget build(BuildContext context) {
    final ratio = total == 0 ? 0.0 : count / total;
    final color = _gradeColor(grade);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Text(
              grade,
              style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 13),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: ratio,
                minHeight: 14,
                backgroundColor: Colors.grey.shade100,
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text('$count', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }

  static Color _gradeColor(String grade) {
    switch (grade) {
      case 'A+':
      case 'A':
        return const Color(0xFF388E3C);
      case 'B':
        return const Color(0xFF1976D2);
      case 'C':
        return const Color(0xFFF57C00);
      case 'D':
        return const Color(0xFFFF8F00);
      default:
        return const Color(0xFFD32F2F);
    }
  }
}

class _StudentResult {
  const _StudentResult({
    required this.name,
    required this.rollNo,
    required this.subject,
    required this.score,
    required this.examType,
    required this.examDate,
  });

  final String name;
  final String rollNo;
  final String subject;
  final int score;
  final String examType;
  final DateTime examDate;
}