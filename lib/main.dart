import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:myapp/src/theme_notifier.dart';
import 'package:myapp/src/home_screen.dart';
import 'package:myapp/src/notification_screen.dart';
import 'package:myapp/src/calendar_screen.dart';
import 'package:myapp/src/profile_screen.dart';
import 'package:myapp/src/login_screen.dart';
import 'components/bottom_nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);

  final romanticTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.pink,
    scaffoldBackgroundColor: Colors.white,
    cardColor: const Color(0xFFFFE5E0),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFADCD9),
    ),
    iconTheme: const IconThemeData(color: Color(0xFFE5738A)),
    colorScheme: ColorScheme.light(
      primary: const Color(0xFFE5738A),
      secondary: const Color(0xFFF8BBD0),
      surface: const Color(0xFFFADCD9),
    ),
    dividerColor: const Color(0xFFE8B9B2),
    bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFFE8B9B2)),
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(romanticTheme),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme.themeData,
          home: const LoginScreen(),
        );
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = const [
    HomeScreen(),
    NotificationScreen(),
    CalendarScreen(),
    ProfileScreen(),
  ];

  void _onTabChange(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: PageView(
          controller: _pageController,
          // Removido physics para permitir swipe lateral
          children: _pages,
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTabChange: _onTabChange,
      ),
    );
  }
}