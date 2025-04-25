import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _checklist = [
    'Planejar um jantar romântico',
    'Assistir a um filme juntos',
    'Fazer uma caminhada no parque',
    'Escrever uma carta de amor',
    'Tirar uma foto especial do casal',
    'Experimentar uma receita nova',
    'Fazer uma viagem de um dia',
    'Montar um quebra-cabeça juntos',
    'Ter uma noite de jogos',
    'Relembrar fotos antigas',
  ];
  final List<bool> _checked = List.generate(10, (_) => false);

  void _addChecklistItem() async {
    String? newItem = await _showEditDialog(context, 'Novo item', '');
    if (newItem != null && newItem.trim().isNotEmpty) {
      setState(() {
        _checklist.add(newItem.trim());
        _checked.add(false);
      });
    }
  }

  void _editChecklistItem(int index) async {
    String? edited = await _showEditDialog(context, 'Renomear item', _checklist[index]);
    if (edited != null && edited.trim().isNotEmpty) {
      setState(() {
        _checklist[index] = edited.trim();
      });
    }
  }

  void _removeChecklistItem(int index) {
    setState(() {
      _checklist.removeAt(index);
      _checked.removeAt(index);
    });
  }

  Future<String?> _showEditDialog(BuildContext context, String title, String initial) {
    final controller = TextEditingController(text: initial);
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Digite o texto'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final String dia = DateFormat('d', 'pt_BR').format(now);
    final String mes = DateFormat('MMMM', 'pt_BR').format(now);

    return Scaffold(
      backgroundColor: const Color(0xFFFDF6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                // Avatares e coração
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage('assets/profile1.jpg'),
                    ),
                    const SizedBox(width: 24),
                    Icon(Icons.favorite, color: Colors.pink, size: 32),
                    const SizedBox(width: 24),
                    const CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage('assets/profile2.jpg'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Dias conectados
                Text(
                  '20 dias',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink.shade400,
                  ),
                ),
                const SizedBox(height: 6),
                // Botão conectar
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.pink.shade200),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Conectar',
                    style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 18),
                // Card de Anotações com dia grande e mês centralizado embaixo
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 18),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade200,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Dia e mês centralizados
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              dia,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 64,
                                height: 1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              mes[0].toUpperCase() + mes.substring(1),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 18),
                      // Anotações
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'anotações,\nanotações,\nanotações,\nanotações',
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Card de Checklist
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.shade50,
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
                          const Text(
                            'Checklist',
                            style: TextStyle(
                              color: Colors.pink,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.add, color: Colors.pink),
                            onPressed: _addChecklistItem,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ...List.generate(_checklist.length, (i) => Row(
                        children: [
                          Checkbox(
                            value: _checked[i],
                            onChanged: (val) {
                              setState(() => _checked[i] = val ?? false);
                            },
                            activeColor: Colors.pink,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _editChecklistItem(i),
                              child: Text(
                                _checklist[i],
                                style: const TextStyle(fontSize: 14, color: Colors.pink),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, size: 18, color: Colors.pink),
                            onPressed: () => _editChecklistItem(i),
                            tooltip: 'Renomear',
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, size: 18, color: Colors.redAccent),
                            onPressed: () => _removeChecklistItem(i),
                            tooltip: 'Excluir',
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}