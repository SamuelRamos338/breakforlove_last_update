import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _checklist = [];
  bool _isLoading = false;
  final String _conexaoId = '64f1a2b3c4d5e6f7a8b9c0d1'; // Substitua por um ObjectId válido

  @override
  void initState() {
    super.initState();
    _fetchChecklist();
  }

  Future<void> _fetchChecklist() async {
    setState(() => _isLoading = true);
    try {
      final response = await http.get(
        Uri.parse('http://192.168.0.104:3000/api/checkListRoute/listar/$_conexaoId'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        setState(() {
          _checklist.clear();
          _checklist.addAll(data.map((item) => {
            'id': item['_id'],
            'descricao': item['descricao'],
            'marcado': item['marcado'],
          }));
        });
      } else {
        _showError('Erro ao carregar checklist: ${response.statusCode}');
      }
    } catch (e) {
      _showError('Erro ao conectar ao servidor.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _addChecklistItem() async {
    String? newItem = await _showEditDialog(context, 'Novo item', '');
    if (newItem != null && newItem.trim().isNotEmpty) {
      try {
        final response = await http.post(
          Uri.parse('http://192.168.0.104:3000/api/checkListRoute/criar/$_conexaoId'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'descricao': newItem.trim()}),
        );
        if (response.statusCode == 201) {
          _fetchChecklist();
        } else {
          _showError('Erro ao adicionar item: ${response.statusCode}');
        }
      } catch (e) {
        _showError('Erro ao conectar ao servidor.');
      }
    }
  }

  Future<String?> _showEditDialog(BuildContext context, String title, String initial) {
    final controller = TextEditingController(text: initial);
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Digite o texto'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).iconTheme.color ?? Colors.pink;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage('assets/profile1.jpg'),
                    ),
                    const SizedBox(width: 24),
                    Icon(Icons.favorite, color: iconColor, size: 32),
                    const SizedBox(width: 24),
                    const CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage('assets/profile2.jpg'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '20 dias',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: iconColor,
                  ),
                ),
                const SizedBox(height: 6),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: iconColor.withOpacity(0.5)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Conectar',
                    style: TextStyle(
                        color: iconColor, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 18),
                Divider(
                  color: Theme.of(context).dividerColor,
                  thickness: 4,
                  height: 3,
                ),
                const SizedBox(height: 18),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: iconColor.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Checklist',
                            style: TextStyle(
                              color: iconColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: Icon(Icons.add, color: iconColor),
                            onPressed: _addChecklistItem,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ...List.generate(_checklist.length, (i) => Row(
                        children: [
                          Checkbox(
                            value: _checklist[i]['marcado'],
                            onChanged: (val) => {},
                            activeColor: iconColor,
                          ),
                          Expanded(
                            child: Text(
                              _checklist[i]['descricao'],
                              style: TextStyle(
                                  fontSize: 17, color: iconColor),
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}