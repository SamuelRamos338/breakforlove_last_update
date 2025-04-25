import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _checklist = [
    'Assistir a um filme juntos',
    'Fazer uma caminhada no parque',
    'Escrever uma carta de amor',
    'Experimentar uma receita nova',
    'Fazer uma viagem de um dia',
    'Montar um quebra-cabeça juntos',
    'Ter uma noite de jogos',
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
    return showGeneralDialog<String>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Editar',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              elevation: 16,
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    TextField(
                      controller: controller,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Digite o texto',
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          onPressed: () => Navigator.pop(context, controller.text),
                          child: const Text('Salvar'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1,
          child: ScaleTransition(
            scale: CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final String dia = DateFormat('d', 'pt_BR').format(now);
    final String mes = DateFormat('MMMM', 'pt_BR').format(now);
    final iconColor = Theme.of(context).iconTheme.color ?? Colors.pink;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
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
                    style: TextStyle(color: iconColor, fontWeight: FontWeight.bold),
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
                  margin: const EdgeInsets.only(bottom: 18),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'anotações,\nanotações,\nanotações,\nanotações',
                                style: TextStyle(color: Colors.white, fontSize: 17, height: 1.5),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                            value: _checked[i],
                            onChanged: (val) {
                              setState(() => _checked[i] = val ?? false);
                            },
                            activeColor: iconColor,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _editChecklistItem(i),
                              child: Text(
                                _checklist[i],
                                style: TextStyle(fontSize: 17, color: iconColor),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit, size: 18, color: iconColor),
                            onPressed: () => _editChecklistItem(i),
                            tooltip: 'Renomear',
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, size: 18, color: Colors.grey),
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