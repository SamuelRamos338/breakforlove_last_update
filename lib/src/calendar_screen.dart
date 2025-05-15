import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime? _selectedDate;
  List<Map<String, dynamic>> _reminders = [];
  final TextEditingController _reminderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchReminders(); // Carrega os lembretes ao iniciar
  }

  // Função para buscar lembretes do backend
  Future<void> _fetchReminders() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.0.104:3000/api/lembreteRoute'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        setState(() {
          _reminders = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        });
      } else {
        _showError('Erro ao carregar lembretes.');
      }
    } catch (e) {
      _showError('Erro ao conectar ao servidor.');
    }
  }

  // Função para adicionar ou editar lembrete
  Future<void> _saveReminder({String? id}) async {
    if (_selectedDate == null || _reminderController.text.isEmpty) return;

    final body = jsonEncode({
      'descricao': _reminderController.text,
      'data': _selectedDate!.toIso8601String(),
    });

    try {
      final response = id == null
          ? await http.post(
        Uri.parse('http://192.168.0.104:3000/api/lembreteRoute'),
        headers: {'Content-Type': 'application/json'},
        body: body,
      )
          : await http.put(
        Uri.parse('http://192.168.0.104:3000/api/lembreteRoute/$id'),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        _fetchReminders(); // Atualiza a lista de lembretes
        Navigator.pop(context);
      } else {
        _showError('Erro ao salvar lembrete.');
      }
    } catch (e) {
      _showError('Erro ao conectar ao servidor.');
    }
  }

  // Função para deletar lembrete
  Future<void> _deleteReminder(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('http://192.168.0.104:3000/api/lembreteRoute/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        _fetchReminders(); // Atualiza a lista de lembretes
      } else {
        _showError('Erro ao deletar lembrete.');
      }
    } catch (e) {
      _showError('Erro ao conectar ao servidor.');
    }
  }

  // Exibe o diálogo para adicionar ou editar lembretes
  Future<void> _showReminderDialog({String? id, String? descricao}) async {
    if (_selectedDate == null) return;
    _reminderController.text = descricao ?? '';

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(id == null ? 'Adicionar Lembrete' : 'Editar Lembrete'),
        content: TextField(
          controller: _reminderController,
          decoration: const InputDecoration(labelText: 'Lembrete'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => _saveReminder(id: id),
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  // Exibe mensagem de erro
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Constrói o cartão de lembrete
  Widget _buildReminderCard(Map<String, dynamic> reminder) {
    final date = DateTime.parse(reminder['data']);
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Text(
          date.day.toString(),
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        title: Text(reminder['descricao']),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.grey),
              onPressed: () => _showReminderDialog(
                id: reminder['_id'],
                descricao: reminder['descricao'],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.grey),
              onPressed: () => _deleteReminder(reminder['_id']),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
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
              color: theme.colorScheme.secondary.withOpacity(0.5),
              thickness: 2,
            ),
            const SizedBox(height: 20),
            TableCalendar(
              locale: "pt_BR",
              rowHeight: 50,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
                leftChevronIcon: Icon(Icons.chevron_left, color: theme.colorScheme.primary),
                rightChevronIcon: Icon(Icons.chevron_right, color: theme.colorScheme.primary),
              ),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: theme.colorScheme.secondary.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                todayTextStyle: const TextStyle(color: Colors.black),
                selectedDecoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                defaultTextStyle: TextStyle(color: theme.colorScheme.onSurface),
                weekendTextStyle: TextStyle(color: theme.colorScheme.secondary),
              ),
              selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
              focusedDay: _selectedDate ?? DateTime.now(),
              firstDay: DateTime.utc(1990, 1, 1),
              lastDay: DateTime.utc(2040, 1, 1),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                });
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  if (_selectedDate == null) return;
                  _showReminderDialog();
                },
                icon: const Icon(Icons.add, size: 30, color: Colors.white),
                label: const Text(
                  "Adicionar Lembrete",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.8),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_reminders.isNotEmpty) ...[
              const Text(
                "Lembretes",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ..._reminders.map((reminder) => _buildReminderCard(reminder)),
            ],
          ],
        ),
      ),
    );
  }
}