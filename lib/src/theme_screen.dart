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
  bool _loading = false;

  // Temas claros
  final List<ThemeData> _lightThemes = [
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.pink,
      scaffoldBackgroundColor: Colors.white,
      cardColor: const Color(0xFFFFE5E0),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFADCD9),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      iconTheme: const IconThemeData(color: Color(0xFFE5738A)),
      colorScheme: ColorScheme.light(
        primary: Color(0xFFE5738A),
        secondary: Color(0xFFF8BBD0),
        surface: Color(0xFFFADCD9),
      ),
      dividerColor: const Color(0xFFE8B9B2),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFFE8B9B2)),
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      cardColor: const Color(0xFFE3F0FF),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFB3D1F7),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      iconTheme: const IconThemeData(color: Color(0xFF1976D2)),
      colorScheme: ColorScheme.light(
        primary: Color(0xFF1976D2),
        secondary: Color(0xFF64B5F6),
        surface: Color(0xFFB3D1F7),
      ),
      dividerColor: const Color(0xFFB3D1F7),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFFB3D1F7)),
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.green,
      scaffoldBackgroundColor: Colors.white,
      cardColor: const Color(0xFFE0F7E9),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFC8E6C9),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      iconTheme: const IconThemeData(color: Color(0xFF388E3C)),
      colorScheme: ColorScheme.light(
        primary: Color(0xFF388E3C),
        secondary: Color(0xFFA5D6A7),
        surface: Color(0xFFC8E6C9),
      ),
      dividerColor: const Color(0xFFA5D6A7),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFFA5D6A7)),
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.orange,
      scaffoldBackgroundColor: Colors.white,
      cardColor: const Color(0xFFFFF3E0),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFFE0B2),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      iconTheme: const IconThemeData(color: Color(0xFFF57C00)),
      colorScheme: ColorScheme.light(
        primary: Color(0xFFF57C00),
        secondary: Color(0xFFFFB74D),
        surface: Color(0xFFFFE0B2),
      ),
      dividerColor: const Color(0xFFFFCC80),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFFFFCC80)),
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.purple,
      scaffoldBackgroundColor: Colors.white,
      cardColor: const Color(0xFFF3E5F5),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFE1BEE7),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      iconTheme: const IconThemeData(color: Color(0xFF8E24AA)),
      colorScheme: ColorScheme.light(
        primary: Color(0xFF8E24AA),
        secondary: Color(0xFFCE93D8),
        surface: Color(0xFFE1BEE7),
      ),
      dividerColor: const Color(0xFFCE93D8),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFFCE93D8)),
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.teal,
      scaffoldBackgroundColor: Colors.white,
      cardColor: const Color(0xFFE0F2F1),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFB2DFDB),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      iconTheme: const IconThemeData(color: Color(0xFF00897B)),
      colorScheme: ColorScheme.light(
        primary: Color(0xFF00897B),
        secondary: Color(0xFF80CBC4),
        surface: Color(0xFFB2DFDB),
      ),
      dividerColor: const Color(0xFF80CBC4),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF80CBC4)),
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.amber,
      scaffoldBackgroundColor: Colors.white,
      cardColor: const Color(0xFFFFF8E1),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFFECB3),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      iconTheme: const IconThemeData(color: Color(0xFFFFA000)),
      colorScheme: ColorScheme.light(
        primary: Color(0xFFFFA000),
        secondary: Color(0xFFFFD54F),
        surface: Color(0xFFFFECB3),
      ),
      dividerColor: const Color(0xFFFFD54F),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFFFFD54F)),
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.cyan,
      scaffoldBackgroundColor: Colors.white,
      cardColor: const Color(0xFFE0F7FA),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFB2EBF2),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      iconTheme: const IconThemeData(color: Color(0xFF00ACC1)),
      colorScheme: ColorScheme.light(
        primary: Color(0xFF00ACC1),
        secondary: Color(0xFF4DD0E1),
        surface: Color(0xFFB2EBF2),
      ),
      dividerColor: const Color(0xFF4DD0E1),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF4DD0E1)),
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.lime,
      scaffoldBackgroundColor: Colors.white,
      cardColor: const Color(0xFFF9FBE7),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFF0F4C3),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      iconTheme: const IconThemeData(color: Color(0xFFAFB42B)),
      colorScheme: ColorScheme.light(
        primary: Color(0xFFAFB42B),
        secondary: Color(0xFFD4E157),
        surface: Color(0xFFF0F4C3),
      ),
      dividerColor: const Color(0xFFD4E157),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFFD4E157)),
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: Colors.white,
      cardColor: const Color(0xFFE8EAF6),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFC5CAE9),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      iconTheme: const IconThemeData(color: Color(0xFF3949AB)),
      colorScheme: ColorScheme.light(
        primary: Color(0xFF3949AB),
        secondary: Color(0xFF7986CB),
        surface: Color(0xFFC5CAE9),
      ),
      dividerColor: const Color(0xFF7986CB),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF7986CB)),
    ),
  ];

  // Temas escuros
  final List<ThemeData> _darkThemes = [
    ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF181829),
      cardColor: const Color(0xFF23234A),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF23234A)),
      iconTheme: const IconThemeData(color: Color(0xFF00FFC6)),
      colorScheme: ColorScheme.dark(
        primary: Color(0xFF00FFC6),
        secondary: Color(0xFF7C4DFF),
        surface: Color(0xFF23234A),
      ),
      dividerColor: const Color(0xFF7C4DFF),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF23234A)),
    ),
    ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF101F33),
      cardColor: const Color(0xFF1A2947),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1A2947)),
      iconTheme: const IconThemeData(color: Color(0xFFFF4081)),
      colorScheme: ColorScheme.dark(
        primary: Color(0xFFFF4081),
        secondary: Color(0xFF00B8D4),
        surface: Color(0xFF1A2947),
      ),
      dividerColor: const Color(0xFFFF4081),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF1A2947)),
    ),
    ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF16241D),
      cardColor: const Color(0xFF1E3A2F),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1E3A2F)),
      iconTheme: const IconThemeData(color: Color(0xFFFFA726)),
      colorScheme: ColorScheme.dark(
        primary: Color(0xFFFFA726),
        secondary: Color(0xFF43A047),
        surface: Color(0xFF1E3A2F),
      ),
      dividerColor: const Color(0xFFFFA726),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF1E3A2F)),
    ),
    ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF23272F),
      cardColor: const Color(0xFF313543),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF313543)),
      iconTheme: const IconThemeData(color: Color(0xFF00B8D4)),
      colorScheme: ColorScheme.dark(
        primary: Color(0xFF00B8D4),
        secondary: Color(0xFF00FFC6),
        surface: Color(0xFF313543),
      ),
      dividerColor: const Color(0xFF00B8D4),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF313543)),
    ),
    ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF2A183A),
      cardColor: const Color(0xFF3B2352),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF3B2352)),
      iconTheme: const IconThemeData(color: Color(0xFFD4E157)),
      colorScheme: ColorScheme.dark(
        primary: Color(0xFFD4E157),
        secondary: Color(0xFF7C4DFF),
        surface: Color(0xFF3B2352),
      ),
      dividerColor: const Color(0xFFD4E157),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF3B2352)),
    ),
    ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF2E2119),
      cardColor: const Color(0xFF4E342E),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF4E342E)),
      iconTheme: const IconThemeData(color: Color(0xFF80CBC4)),
      colorScheme: ColorScheme.dark(
        primary: Color(0xFF80CBC4),
        secondary: Color(0xFFFFA726),
        surface: Color(0xFF4E342E),
      ),
      dividerColor: const Color(0xFF80CBC4),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF4E342E)),
    ),
    ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF181818),
      cardColor: const Color(0xFF232323),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF232323)),
      iconTheme: const IconThemeData(color: Color(0xFFFF9800)),
      colorScheme: ColorScheme.dark(
        primary: Color(0xFFFF9800),
        secondary: Color(0xFFD32F2F),
        surface: Color(0xFF232323),
      ),
      dividerColor: const Color(0xFFFF9800),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF232323)),
    ),
    ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF263238),
      cardColor: const Color(0xFF37474F),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF37474F)),
      iconTheme: const IconThemeData(color: Color(0xFFD32F2F)),
      colorScheme: ColorScheme.dark(
        primary: Color(0xFFD32F2F),
        secondary: Color(0xFF00B8D4),
        surface: Color(0xFF37474F),
      ),
      dividerColor: const Color(0xFFD32F2F),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF37474F)),
    ),
    ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF22232B),
      cardColor: const Color(0xFF35354A),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF35354A)),
      iconTheme: const IconThemeData(color: Color(0xFFFF2D8A)),
      colorScheme: ColorScheme.dark(
        primary: Color(0xFFFF2D8A),
        secondary: Color(0xFF7C4DFF),
        surface: Color(0xFF35354A),
      ),
      dividerColor: const Color(0xFFFF2D8A),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF35354A)),
    ),
  ];

  // Nomes dos temas (claro + escuro)
  final List<String> _names = [
    'Romântico',
    'Azul',
    'Verde',
    'Laranja',
    'Roxo',
    'Turquesa',
    'Amarelo',
    'Ciano',
    'Lima',
    'Índigo',
    'Neon Escuro',
    'Meia-noite & Pink',
    'Floresta & Laranja',
    'Space & Cyan',
    'Roxo & Lima',
    'Marrom & Menta',
    'Preto & Laranja',
    'Azul Escuro & Vermelho',
    'Grafite & Magenta',
  ];

  // Lista geral (claro + escuro)
  late final List<ThemeData> _themes = [
    ..._lightThemes,
    ..._darkThemes,
  ];

  Future<void> _onThemeTap(int i) async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 600));
    setState(() {
      _selected = i;
      _loading = false;
    });
    Provider.of<ThemeNotifier>(context, listen: false).setTheme(_themes[i]);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Temas do App'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: theme.appBarTheme.backgroundColor,
        ),
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
        padding: const EdgeInsets.all(20),
    itemCount: _themes.length,
    separatorBuilder: (_, __) => const SizedBox(height: 16),
    itemBuilder: (context, i) {
    final t = _themes[i];
    return GestureDetector(
    onTap: () => _onThemeTap(i),
    child: AnimatedContainer(
    duration: const Duration(milliseconds: 250),
    curve: Curves.easeOutCubic,
    decoration: BoxDecoration(
    color: t.cardColor,
    borderRadius: BorderRadius.circular(18),
    border: Border.all(
    color: _selected == i
    ? theme.colorScheme.primary
        : Colors.transparent,
    width: 2.5,
    ),
      // dart
      boxShadow: [
        BoxShadow(
          color: t.cardColor.withOpacity(0.13),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        leading: _ColorDots(theme: t),
        title: Text(
          _names[i],
          style: TextStyle(
            color: t.iconTheme.color,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        trailing: _selected == i
            ? Icon(Icons.check_circle, color: theme.colorScheme.primary)
            : null,
      ),
    ),
    );
    },
        ),
    );
  }
}

class _ColorDots extends StatelessWidget {
  final ThemeData theme;
  const _ColorDots({required this.theme});

  @override
  Widget build(BuildContext context) {
    final colors = [
      theme.colorScheme.primary,
      theme.colorScheme.secondary,
      theme.cardColor,
      theme.scaffoldBackgroundColor,
    ];
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: colors
          .map((c) => Container(
        width: 18,
        height: 18,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: c,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
      ))
          .toList(),
    );
  }
}

