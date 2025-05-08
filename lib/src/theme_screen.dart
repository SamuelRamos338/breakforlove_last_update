import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_notifier.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  int _selected = 0;

  // Temas Populares
  final List<ThemeData> _popularThemes = [
    // Romântico
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.pink,
      scaffoldBackgroundColor: Colors.white,
      cardColor: const Color(0xFFFFE5E0),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFFADCD9)),
      iconTheme: const IconThemeData(color: Color(0xFFE5738A)),
      colorScheme: ColorScheme.light(
        primary: const Color(0xFFE5738A),
        secondary: const Color(0xFFF8BBD0),
        surface: const Color(0xFFFADCD9),
      ),
      dividerColor: const Color(0xFFE8B9B2),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFFE8B9B2)),
    ),
    // Escuro
    ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF181A20),
      cardColor: const Color(0xFF23242B),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF23242B)),
      iconTheme: const IconThemeData(color: Colors.white),
      colorScheme: ColorScheme.dark(
        primary: Colors.white,
        secondary: Colors.grey,
        surface: const Color(0xFF23242B),
      ),
      dividerColor: Colors.grey.shade700,
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF23242B)),
    ),
    // Claro
    ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.white,
      cardColor: const Color(0xFFF5F5F5),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
      iconTheme: const IconThemeData(color: Colors.blue),
      colorScheme: ColorScheme.light(
        primary: Colors.blue,
        secondary: Colors.blueAccent,
        surface: const Color(0xFFF5F5F5),
      ),
      dividerColor: Colors.blue,
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFFF5F5F5)),
    ),
    // Verde
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.green,
      scaffoldBackgroundColor: const Color(0xFFE8F5E9),
      cardColor: const Color(0xFFC8E6C9),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFC8E6C9)),
      iconTheme: const IconThemeData(color: Colors.green),
      colorScheme: ColorScheme.light(
        primary: Colors.green,
        secondary: Colors.greenAccent,
        surface: const Color(0xFFC8E6C9),
      ),
      dividerColor: Colors.green,
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFFC8E6C9)),
    ),
  ];
  final List<String> _popularNames = [
    'Romântico',
    'Escuro',
    'Claro',
    'Verde',
  ];

  // Temas Vivos
  final List<ThemeData> _vividThemes = [
    // Laranja
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.orange,
      scaffoldBackgroundColor: const Color(0xFFFFF3E0),
      cardColor: const Color(0xFFFFE0B2),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFFFE0B2)),
      iconTheme: const IconThemeData(color: Colors.orange),
      colorScheme: ColorScheme.light(
        primary: Colors.orange,
        secondary: Colors.deepOrangeAccent,
        surface: const Color(0xFFFFE0B2),
      ),
      dividerColor: Colors.orange,
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFFFFE0B2)),
    ),
    // Roxo
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.purple,
      scaffoldBackgroundColor: const Color(0xFFF3E5F5),
      cardColor: const Color(0xFFE1BEE7),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFE1BEE7)),
      iconTheme: const IconThemeData(color: Colors.purple),
      colorScheme: ColorScheme.light(
        primary: Colors.purple,
        secondary: Colors.purpleAccent,
        surface: const Color(0xFFE1BEE7),
      ),
      dividerColor: Colors.purple,
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFFE1BEE7)),
    ),
    // Turquesa
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.teal,
      scaffoldBackgroundColor: const Color(0xFFE0F2F1),
      cardColor: const Color(0xFFB2DFDB),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFB2DFDB)),
      iconTheme: const IconThemeData(color: Colors.teal),
      colorScheme: ColorScheme.light(
        primary: Colors.teal,
        secondary: Colors.tealAccent,
        surface: const Color(0xFFB2DFDB),
      ),
      dividerColor: Colors.teal,
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFFB2DFDB)),
    ),
    // Vermelho
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.red,
      scaffoldBackgroundColor: const Color(0xFFFFEBEE),
      cardColor: const Color(0xFFFFCDD2),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFFFCDD2)),
      iconTheme: const IconThemeData(color: Colors.red),
      colorScheme: ColorScheme.light(
        primary: Colors.red,
        secondary: Colors.redAccent,
        surface: const Color(0xFFFFCDD2),
      ),
      dividerColor: Colors.red,
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFFFFCDD2)),
    ),
    // Índigo
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: const Color(0xFFE8EAF6),
      cardColor: const Color(0xFFC5CAE9),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFC5CAE9)),
      iconTheme: const IconThemeData(color: Colors.indigo),
      colorScheme: ColorScheme.light(
        primary: Colors.indigo,
        secondary: Colors.indigoAccent,
        surface: const Color(0xFFC5CAE9),
      ),
      dividerColor: Colors.indigo,
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFFC5CAE9)),
    ),
    // Marinho
    ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFE3F2FD),
      cardColor: const Color(0xFF90CAF9),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF90CAF9)),
      iconTheme: const IconThemeData(color: Color(0xFF1565C0)),
      colorScheme: ColorScheme.light(
        primary: const Color(0xFF1565C0),
        secondary: Colors.blueAccent,
        surface: const Color(0xFF90CAF9),
      ),
      dividerColor: const Color(0xFF1565C0),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF90CAF9)),
    ),
    // Rosa Choque
    ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFFFF0F6),
      cardColor: const Color(0xFFFF80AB),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFFF80AB)),
      iconTheme: const IconThemeData(color: Color(0xFFD5006A)),
      colorScheme: ColorScheme.light(
        primary: const Color(0xFFD5006A),
        secondary: Colors.pinkAccent,
        surface: const Color(0xFFFF80AB),
      ),
      dividerColor: const Color(0xFFD5006A),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFFFF80AB)),
    ),
    // Verde Floresta
    ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFE8F5E9),
      cardColor: const Color(0xFF388E3C),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF388E3C)),
      iconTheme: const IconThemeData(color: Color(0xFF1B5E20)),
      colorScheme: ColorScheme.light(
        primary: const Color(0xFF1B5E20),
        secondary: Colors.greenAccent,
        surface: const Color(0xFF388E3C),
      ),
      dividerColor: const Color(0xFF1B5E20),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF388E3C)),
    ),
  ];
  final List<String> _vividNames = [
    'Laranja',
    'Roxo',
    'Turquesa',
    'Vermelho',
    'Índigo',
    'Marinho',
    'Rosa Choque',
    'Verde Floresta',
  ];

  // Temas Minimalistas
  final List<ThemeData> _minimalThemes = [
    // Marrom
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.brown,
      scaffoldBackgroundColor: const Color(0xFFD7CCC8),
      cardColor: const Color(0xFFBCAAA4),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFBCAAA4)),
      iconTheme: const IconThemeData(color: Colors.brown),
      colorScheme: ColorScheme.light(
        primary: Colors.brown,
        secondary: Colors.brown,
        surface: const Color(0xFFBCAAA4),
      ),
      dividerColor: Colors.brown,
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFFBCAAA4)),
    ),
    // Ciano
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.cyan,
      scaffoldBackgroundColor: const Color(0xFFE0F7FA),
      cardColor: const Color(0xFFB2EBF2),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFB2EBF2)),
      iconTheme: const IconThemeData(color: Colors.cyan),
      colorScheme: ColorScheme.light(
        primary: Colors.cyan,
        secondary: Colors.cyanAccent,
        surface: const Color(0xFFB2EBF2),
      ),
      dividerColor: Colors.cyan,
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFFB2EBF2)),
    ),
    // Lima
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.lime,
      scaffoldBackgroundColor: const Color(0xFFF9FBE7),
      cardColor: const Color(0xFFF0F4C3),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFF0F4C3)),
      iconTheme: const IconThemeData(color: Colors.lime),
      colorScheme: ColorScheme.light(
        primary: Colors.lime,
        secondary: Colors.limeAccent,
        surface: const Color(0xFFF0F4C3),
      ),
      dividerColor: Colors.lime,
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFFF0F4C3)),
    ),
    // Daltônico
    ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      cardColor: const Color(0xFFF7F7F7),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFF7F7F7)),
      iconTheme: const IconThemeData(color: Color(0xFF0072B2)),
      colorScheme: ColorScheme.light(
        primary: const Color(0xFF0072B2),
        secondary: const Color(0xFF009E73),
        surface: const Color(0xFFF7F7F7),
      ),
      dividerColor: const Color(0xFF009E73),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFFF7F7F7)),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: 16, color: Colors.black),
      ),
    ),
    // Amanhecer
    ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFFFF8E1),
      cardColor: const Color(0xFFFFECB3),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFFFECB3)),
      iconTheme: const IconThemeData(color: Color(0xFFFFB300)),
      colorScheme: ColorScheme.light(
        primary: const Color(0xFFFFB300),
        secondary: const Color(0xFFFFF176),
        surface: const Color(0xFFFFECB3),
      ),
      dividerColor: const Color(0xFFFFB300),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFFFFECB3)),
    ),
    // Café
    ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFD7CCC8),
      cardColor: const Color(0xFF8D6E63),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF8D6E63)),
      iconTheme: const IconThemeData(color: Color(0xFF4E342E)),
      colorScheme: ColorScheme.light(
        primary: const Color(0xFF4E342E),
        secondary: const Color(0xFFA1887F),
        surface: const Color(0xFF8D6E63),
      ),
      dividerColor: const Color(0xFF4E342E),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF8D6E63)),
    ),
  ];
  final List<String> _minimalNames = [
    'Marrom',
    'Ciano',
    'Lima',
    'Daltônico',
    'Amanhecer',
    'Café',
  ];

  // Unifica para seleção global
  List<ThemeData> get _allThemes => [
    ..._popularThemes,
    ..._vividThemes,
    ..._minimalThemes,
  ];
  List<String> get _allNames => [
    ..._popularNames,
    ..._vividNames,
    ..._minimalNames,
  ];

  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temas do App'),
        backgroundColor: currentTheme.appBarTheme.backgroundColor,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _allThemes.length,
        itemBuilder: (context, i) {
          return _ThemeCard(
            theme: _allThemes[i],
            name: _allNames[i],
            selected: i == _selected,
            onTap: () {
              setState(() => _selected = i);
              Provider.of<ThemeNotifier>(context, listen: false)
                  .setTheme(_allThemes[i]);
            },
          );
        },
      ),
    );
  }
}

class _ThemeCard extends StatelessWidget {
  final ThemeData theme;
  final String name;
  final bool selected;
  final VoidCallback onTap;

  const _ThemeCard({
    required this.theme,
    required this.name,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = theme.colorScheme.primary;
    final secondary = theme.colorScheme.secondary;
    return Card(
      elevation: selected ? 8 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: selected
            ? BorderSide(color: primary, width: 2)
            : BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: _ColorDots(primary: primary, secondary: secondary),
        title: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selected ? primary : Colors.black,
          ),
        ),
        trailing: selected
            ? Icon(Icons.check_circle, color: primary)
            : null,
        onTap: onTap,
      ),
    );
  }
}

class _ColorDots extends StatelessWidget {
  final Color primary;
  final Color secondary;
  const _ColorDots({required this.primary, required this.secondary});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: primary,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade400, width: 2),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: secondary,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade400, width: 2),
          ),
        ),
      ],
    );
  }
}
