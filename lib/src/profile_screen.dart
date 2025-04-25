import 'package:flutter/material.dart';
import 'user_data_screen.dart';
import 'couple_screen.dart';
import 'about_app_screen.dart';
import 'theme_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const SizedBox(height: 30),
          const CircleAvatar(
            radius: 50,
            child: Icon(Icons.person, size: 60),
          ),
          const SizedBox(height: 20),
          _ProfileScreenItem(
            texto: 'Meus Dados',
            descricao: 'Gerencie suas informações pessoais.',
            icone: Icons.person,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserDataScreen()),
              );
            },
          ),
          _ProfileScreenItem(
            texto: 'Sobre o Casal',
            descricao: 'Veja e edite detalhes do casal.',
            icone: Icons.favorite,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CoupleScreen()),
              );
            },
          ),
          _ProfileScreenItem(
            texto: 'Temas do App',
            descricao: 'Personalize as cores do aplicativo.',
            icone: Icons.color_lens,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ThemeScreen()),
              );
            },
          ),
          _ProfileScreenItem(
            texto: 'Sobre o App',
            descricao: 'Informações e versão do aplicativo.',
            icone: Icons.info,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutAppScreen()),
              );
            },
          ),
          const SizedBox(height: 30),
          const Spacer(),
          const Text(
            'ID: 00001',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _ProfileScreenItem extends StatelessWidget {
  final String texto;
  final String descricao;
  final IconData icone;
  final VoidCallback onPressed;

  const _ProfileScreenItem({
    super.key,
    required this.texto,
    required this.descricao,
    required this.icone,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icone, color: Colors.pink),
        title: Text(texto, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(descricao),
        trailing: const Icon(Icons.arrow_forward),
        onTap: onPressed,
      ),
    );
  }
}