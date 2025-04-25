import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime? _selectedDate;
  final Map<String, String> _reminders = {};
  final TextEditingController _reminderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('pt_BR', null);
  }

  String _dateKey(DateTime date) =>
      "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDate = selectedDay;
      _reminderController.text = _reminders[_dateKey(selectedDay)] ?? "";
    });
  }

  Future<void> _showReminderDialog({bool isEditing = false}) async {
    if (_selectedDate == null) return;
    if (!isEditing) _reminderController.clear();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? "Editar Lembrete" : "Adicionar Lembrete"),
        content: TextField(
          controller: _reminderController,
          decoration: const InputDecoration(labelText: "Digite o lembrete"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              if (_selectedDate != null && _reminderController.text.trim().isNotEmpty) {
                final key = _dateKey(_selectedDate!);
                setState(() {
                  _reminders[key] = _reminderController.text.trim();
                });
              }
              Navigator.pop(context);
            },
            child: const Text("Salvar"),
          ),
        ],
      ),
    );

    setState(() {
      _reminderController.text = _reminders[_dateKey(_selectedDate!)] ?? "";
    });
  }

  Widget _buildReminderCard(String key, String reminder) {
    final date = DateTime.parse("$key 00:00:00");
    final dayString = date.day.toString();
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.pinkAccent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                dayString,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(reminder, style: const TextStyle(fontSize: 16)),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.grey),
              tooltip: "Editar Lembrete",
              onPressed: () {
                setState(() {
                  _selectedDate = date;
                  _reminderController.text = reminder;
                });
                _showReminderDialog(isEditing: true);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.grey),
              tooltip: "Apagar Lembrete",
              onPressed: () {
                setState(() {
                  _reminders.remove(key);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sortedReminders = _reminders.entries.toList()
      ..sort((a, b) => DateTime.parse(a.key).compareTo(DateTime.parse(b.key)));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Escolha um dia para adicionar lembretes",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Divider(
            color: Colors.pink.shade100,// Cor da linha
            thickness: 2,       // Espessura da linha
          ),
          const SizedBox(height: 20),
          TableCalendar(
            locale: "pt_BR",
            rowHeight: 50,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              leftChevronIcon: Icon(Icons.chevron_left),
              rightChevronIcon: Icon(Icons.chevron_right),
            ),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.pinkAccent.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.pinkAccent.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
            selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
            focusedDay: _selectedDate ?? DateTime.now(),
            firstDay: DateTime.utc(1990, 1, 1),
            lastDay: DateTime.utc(2040, 1, 1),
            onDaySelected: _onDaySelected,
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                final key = _dateKey(day);
                if (_reminders.containsKey(key)) {
                  return Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                if (_selectedDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("Selecione uma data primeiro!"),
                    ),
                  );
                }
                _showReminderDialog(isEditing: false);
              },
              icon: const Icon(Icons.add, size: 30),
              label: const Text("Adicionar Lembrete", style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink.shade100,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (_reminders.isNotEmpty) ...[
            const Text(
              "Lembretes",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            Builder(
              builder: (context) {
                final grouped = <String, List<MapEntry<String, String>>>{};
                for (final entry in sortedReminders) {
                  final date = DateTime.parse(entry.key + " 00:00:00");
                  final monthKey = "${date.year}-${date.month.toString().padLeft(2, '0')}";
                  grouped.putIfAbsent(monthKey, () => []);
                  grouped[monthKey]!.add(entry);
                }
                final sortedMonthKeys = grouped.keys.toList()
                  ..sort((a, b) {
                    final dtA = DateTime.parse("$a-01 00:00:00");
                    final dtB = DateTime.parse("$b-01 00:00:00");
                    return dtA.compareTo(dtB);
                  });
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: sortedMonthKeys.map((monthKey) {
                    final groupList = grouped[monthKey]!;
                    final date = DateTime.parse(groupList.first.key + " 00:00:00");
                    final monthName = DateFormat('MMMM yyyy', 'pt_BR').format(date);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            monthName[0].toUpperCase() + monthName.substring(1),
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ...groupList.map((entry) => _buildReminderCard(entry.key, entry.value)).toList(),
                      ],
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}