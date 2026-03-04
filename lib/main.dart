import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Student {
  final String id;
  final String name;
  final String className;

  Student({required this.id, required this.name, required this.className});
}

enum SidebarItem { attendance, result, feePayment, discom }

extension SidebarItemExt on SidebarItem {
  String get title {
    switch (this) {
      case SidebarItem.attendance:
        return 'Attendance';
      case SidebarItem.result:
        return 'Result';
      case SidebarItem.feePayment:
        return 'Fee payment';
      case SidebarItem.discom:
        return 'Discom';
    }
  }

  IconData get icon {
    switch (this) {
      case SidebarItem.attendance:
        return Icons.check_circle_outline;
      case SidebarItem.result:
        return Icons.assessment_outlined;
      case SidebarItem.feePayment:
        return Icons.payment_outlined;
      case SidebarItem.discom:
        return Icons.info_outline;
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Info Landing',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StudentInfoPage(),
    );
  }
}

class StudentInfoPage extends StatefulWidget {
  // In real usage this page should receive the list of selected students from the previous page.
  // For this demo, if no students are provided, we fall back to sample data.
  final List<Student>? selectedStudents;

  const StudentInfoPage({super.key, this.selectedStudents});

  @override
  State<StudentInfoPage> createState() => _StudentInfoPageState();
}

class _StudentInfoPageState extends State<StudentInfoPage>
    with SingleTickerProviderStateMixin {
  late final List<Student> _students;
  int _currentStudentIndex = 0;
  SidebarItem _selectedItem = SidebarItem.attendance; // default view
  bool _sidebarOpen = false;
  late final AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _students = widget.selectedStudents ?? _sampleStudents();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  List<Student> _sampleStudents() {
    return [
      Student(id: 'S001', name: 'Amina Yusuf', className: 'Grade 10'),
      Student(id: 'S002', name: 'John Doe', className: 'Grade 11'),
    ];
  }

  void _toggleSidebar() {
    setState(() {
      _sidebarOpen = !_sidebarOpen;
      if (_sidebarOpen) {
        _animController.forward();
      } else {
        _animController.reverse();
      }
    });
  }

  void _selectItem(SidebarItem item) {
    setState(() {
      _selectedItem = item;
      _sidebarOpen = false;
      _animController.reverse();
      // When the user taps any sidebar option, the view shows that option for the first
      // student and subsequent taps on "Next student" will move through the selected students.
      _currentStudentIndex = 0;
    });
  }

  void _nextStudent() {
    if (_currentStudentIndex < _students.length - 1) {
      setState(() => _currentStudentIndex++);
    }
  }

  void _previousStudent() {
    if (_currentStudentIndex > 0) {
      setState(() => _currentStudentIndex--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final sidebarWidth = (width * 0.65).clamp(240.0, 360.0);
    final hasStudents = _students.isNotEmpty;
    final student = hasStudents ? _students[_currentStudentIndex] : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Info'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: _toggleSidebar,
          tooltip: 'Open sidebar',
        ),
      ),
      body: Stack(
        children: [
          // Main content
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: hasStudents
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            student!.name,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          Text(student.className),
                          const SizedBox(height: 18),
                          _buildSelectedContent(student),
                          const SizedBox(height: 18),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton.icon(
                                onPressed: _currentStudentIndex > 0
                                    ? _previousStudent
                                    : null,
                                icon: const Icon(Icons.chevron_left),
                                label: const Text('Previous'),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton.icon(
                                onPressed: _currentStudentIndex <
                                        _students.length - 1
                                    ? _nextStudent
                                    : null,
                                icon: const Icon(Icons.chevron_right),
                                label: Text(
                                    'Next (${_currentStudentIndex + 1}/${_students.length})'),
                              ),
                            ],
                          )
                        ],
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.person_off, size: 64),
                          const SizedBox(height: 12),
                          const Text('No students selected.'),
                        ],
                      ),
              ),
            ),
          ),

          // Floating sidebar overlay
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            left: _sidebarOpen ? 0 : -sidebarWidth - 16,
            top: 0,
            bottom: 0,
            child: Semantics(
              label: 'Sidebar',
              child: SizedBox(
                width: sidebarWidth,
                child: Material(
                  elevation: 12,
                  color: Theme.of(context).colorScheme.surface,
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Options',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: _toggleSidebar,
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 1),
                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            children: SidebarItem.values.map((item) {
                              final selected = item == _selectedItem;
                              return ListTile(
                                leading: Icon(item.icon,
                                    color: selected
                                        ? Theme.of(context)
                                            .colorScheme
                                            .primary
                                        : null),
                                title: Text(item.title),
                                selected: selected,
                                onTap: () => _selectItem(item),
                              );
                            }).toList(),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                  'Selected students: ${_students.length}',
                                  textAlign: TextAlign.center),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  // Example action: close and keep current selection
                                  _toggleSidebar();
                                },
                                child: const Text('Done'),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildSelectedContent(Student student) {
    switch (_selectedItem) {
      case SidebarItem.attendance:
        return _attendanceView(student);
      case SidebarItem.result:
        return _resultView(student);
      case SidebarItem.feePayment:
        return _feeView(student);
      case SidebarItem.discom:
        return _discomView(student);
    }
  }

  Widget _attendanceView(Student s) {
    // Dummy attendance data for demo
    final attendancePercent = 92;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green),
                const SizedBox(width: 8),
                const Text('Attendance'),
              ],
            ),
            const SizedBox(height: 12),
            Text('$attendancePercent% attendance',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: attendancePercent / 100,
            ),
          ],
        ),
      ),
    );
  }

  Widget _resultView(Student s) {
    // Dummy result data
    final Map<String, String> grades = {
      'Math': 'A',
      'English': 'B+',
      'Science': 'A-',
    };
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.assessment, color: Colors.blue),
                const SizedBox(width: 8),
                const Text('Result'),
              ],
            ),
            const SizedBox(height: 12),
            ...grades.entries.map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(e.key), Text(e.value)],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _feeView(Student s) {
    // Dummy fee data
    final due = 150.0;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(Icons.payment, color: Colors.orange),
                const SizedBox(width: 8),
                const Text('Fee payment'),
              ],
            ),
            const SizedBox(height: 12),
            Text('Amount due: \$${due.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Payment flow not implemented in demo')));
              },
              child: const Text('Pay now'),
            )
          ],
        ),
      ),
    );
  }

  Widget _discomView(Student s) {
    // Dummy discom / miscellaneous info
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.info, color: Colors.purple),
                const SizedBox(width: 8),
                const Text('Discom'),
              ],
            ),
            const SizedBox(height: 12),
            const Text('No additional information.'),
          ],
        ),
      ),
    );
  }
}
