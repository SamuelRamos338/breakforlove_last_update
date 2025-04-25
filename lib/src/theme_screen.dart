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
  late final PageController _pageController = PageController(
    initialPage: _selected,
    viewportFraction: 0.48,
  );

  late final List<ThemeData> _allThemes = [
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.pink,
      scaffoldBackgroundColor: Colors.white,
      cardColor: const Color(0xFFFFE5E0),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFADCD9),
      ),
      iconTheme: const IconThemeData(color: Color(0xFFE5738A)), // Corrigido aqui
      colorScheme: ColorScheme.light(
        primary: const Color(0xFFE5738A),
        secondary: const Color(0xFFF8BBD0),
        surface: const Color(0xFFFADCD9),
      ),
      dividerColor: const Color(0xFFE8B9B2),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFFE8B9B2)),
    ),
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
      bottomAppBarTheme: BottomAppBarTheme(color: const Color(0xFFF5F5F5)),
    ),
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
      bottomAppBarTheme: BottomAppBarTheme(color: const Color(0xFFC8E6C9)),
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.orange,
      scaffoldBackgroundColor: const Color(0xFFFFF3E0),
      cardColor: const Color(0xFFFFE0B2),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFFFE0B2)),
      iconTheme: const IconThemeData(color: Colors.orange),
      colorScheme: ColorScheme.light(
        primary: Colors.orange,
        secondary: Colors.orangeAccent,
        surface: const Color(0xFFFFE0B2),
      ),
      dividerColor: Colors.orange,
      bottomAppBarTheme: BottomAppBarTheme(color: const Color(0xFFFFE0B2)),
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.purple,
      scaffoldBackgroundColor: const Color(0xFFF3E5F5),
      cardColor: const Color(0xFFE1BEE7),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFE1BEE7)),
      iconTheme: const IconThemeData(color: Colors.purple),
      colorScheme: ColorScheme.light(
        primary: Colors.purple,
        secondary: Colors.deepPurpleAccent,
        surface: const Color(0xFFE1BEE7),
      ),
      dividerColor: Colors.purple,
      bottomAppBarTheme: BottomAppBarTheme(color: const Color(0xFFE1BEE7)),
    ),
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
      bottomAppBarTheme: BottomAppBarTheme(color: const Color(0xFFB2DFDB)),
    ),
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
      bottomAppBarTheme: BottomAppBarTheme(color: const Color(0xFFFFCDD2)),
    ),
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
      bottomAppBarTheme: BottomAppBarTheme(color: const Color(0xFFC5CAE9)),
    ),
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
      bottomAppBarTheme: BottomAppBarTheme(color: const Color(0xFFBCAAA4)),
    ),
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
      bottomAppBarTheme: BottomAppBarTheme(color: const Color(0xFFB2EBF2)),
    ),
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
      bottomAppBarTheme: BottomAppBarTheme(color: const Color(0xFFF0F4C3)),
    ),
    // Tema para daltônicos
    ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      cardColor: const Color(0xFFF7F7F7),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFF7F7F7)),
      iconTheme: const IconThemeData(color: Color(0xFF0072B2)),
      colorScheme: ColorScheme.light(
        primary: const Color(0xFF0072B2),
        secondary: const Color(0xFFE69F00),
        surface: const Color(0xFFF7F7F7),
        onSurface: Colors.black,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
      ),
      dividerColor: const Color(0xFF009E73),
      bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFFF7F7F7)),
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.black),
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black),
      ),
    ),
  ];

  final List<String> _allThemeNames = [
    'Romântico',
    'Claro',
    'Verde',
    'Laranja',
    'Roxo',
    'Turquesa',
    'Vermelho',
    'Índigo',
    'Marrom',
    'Ciano',
    'Lima',
    'Daltônico',
  ];

  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Temas do App')),
      backgroundColor: currentTheme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Escolha um tema:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 28),
            SizedBox(
              height: 240,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _allThemes.length,
                onPageChanged: (i) {
                  setState(() => _selected = i);
                  Provider.of<ThemeNotifier>(context, listen: false).setTheme(_allThemes[i]);
                },
                itemBuilder: (context, i) {
                  final theme = _allThemes[i];
                  final isSelected = _selected == i;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOutCubic,
                    margin: EdgeInsets.symmetric(horizontal: isSelected ? 8 : 18, vertical: isSelected ? 0 : 18),
                    width: 200,
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: isSelected ? theme.colorScheme.primary : Colors.grey.shade300,
                        width: isSelected ? 3 : 1.5,
                      ),
                      boxShadow: [
                        if (isSelected)
                          BoxShadow(
                            color: theme.colorScheme.primary.withOpacity(0.18),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                      ],
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(28),
                      onTap: () {
                        setState(() => _selected = i);
                        Provider.of<ThemeNotifier>(context, listen: false).setTheme(_allThemes[i]);
                        _pageController.animateToPage(
                          i,
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeInOutCubic,
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _ColorDots(
                            primary: theme.colorScheme.primary,
                            secondary: theme.colorScheme.secondary,
                          ),
                          const SizedBox(height: 18),
                          Text(
                            _allThemeNames[i],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: theme.iconTheme.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
      mainAxisAlignment: MainAxisAlignment.center,
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