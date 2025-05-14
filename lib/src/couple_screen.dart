import 'package:flutter/material.dart';

class CoupleScreen extends StatefulWidget {
  const CoupleScreen({super.key});

  @override
  State<CoupleScreen> createState() => _CoupleScreenState();
}

class _CoupleScreenState extends State<CoupleScreen> {
  final Map<String, String> _infos = {
    'Música favorita': 'Perfect - Ed Sheeran',
    'Filme favorito': 'A Culpa é das Estrelas',
    'Data especial': 'Primeiro encontro: 01/01/2023',
    'Próximo aniversário de namoro': '14/03/2024',
  };

  final Map<String, IconData> _icons = {
    'Música favorita': Icons.music_note,
    'Filme favorito': Icons.movie,
    'Data especial': Icons.calendar_today,
    'Próximo aniversário de namoro': Icons.cake,
  };

  bool _isEditing = false;
  String? _editingKey;
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    for (var key in _infos.keys) {
      _controllers[key] = TextEditingController(text: _infos[key]);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
      _editingKey = null;
    });
  }

  void _startEdit(String key) {
    setState(() {
      _editingKey = key;
      _controllers[key]?.text = '';
    });
  }

  void _saveEdit(String key) {
    setState(() {
      _infos[key] = _controllers[key]?.text ?? '';
      _editingKey = null;
    });
  }

  void _cancelEdit() {
    setState(() {
      _editingKey = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).iconTheme.color;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o Casal'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.close : Icons.edit),
            tooltip: _isEditing ? 'Cancelar edição' : 'Editar',
            onPressed: _toggleEditMode,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 48,
                  backgroundImage: AssetImage('assets/profile1.jpg'),
                ),
                const SizedBox(width: 16),
                Column(
                  children: [
                    const SizedBox(height: 58),
                    Icon(Icons.favorite, color: iconColor, size: 32),
                  ],
                ),
                const SizedBox(width: 16),
                const CircleAvatar(
                  radius: 48,
                  backgroundImage: AssetImage('assets/profile2.jpg'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Bolsonaro, Lula & Samuel',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Juntos desde: 14/02/2024',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 34),
            ..._infos.keys.map((key) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Card(
                child: ListTile(
                  leading: Icon(_icons[key], color: iconColor),
                  title: Text(key),
                  subtitle: _editingKey == key
                      ? Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controllers[key],
                          autofocus: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.check, color: Colors.green),
                        tooltip: 'Salvar',
                        onPressed: () => _saveEdit(key),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        tooltip: 'Cancelar',
                        onPressed: _cancelEdit,
                      ),
                    ],
                  )
                      : GestureDetector(
                    onTap: _isEditing
                        ? () => _startEdit(key)
                        : null,
                    child: Row(
                      children: [
                        Expanded(child: Text(_infos[key]!)),
                        if (_isEditing)
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(Icons.edit, size: 18, color: Colors.grey),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
