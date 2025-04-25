import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabChange;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTabChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: GNav(
          selectedIndex: currentIndex,
          onTabChange: onTabChange,
          color: Colors.black,
          activeColor: Colors.black,
          tabBackgroundColor: Colors.pink.shade100,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), // Aumentei o padding para maior área de toque
          gap: 8, // Espaçamento ligeiramente maior entre os ícones e textos
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          tabs: const [
            GButton(icon: Icons.home, text: 'Início'),
            GButton(icon: Icons.notifications, text: 'Notificações'),
            GButton(icon: Icons.calendar_month, text: 'Calendário'),
            GButton(icon: Icons.account_circle, text: 'Perfil'),
          ],
        ),
      ),
    );
  }
}