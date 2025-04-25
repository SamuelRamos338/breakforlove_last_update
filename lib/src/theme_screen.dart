import 'package:flutter/material.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Temas do App')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Escolha um tema:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.light_mode, color: Colors.amber),
              title: const Text('Claro'),
              onTap: () {
                // Lógica para tema claro
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tema claro selecionado!')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode, color: Colors.blueGrey),
              title: const Text('Escuro'),
              onTap: () {
                // Lógica para tema escuro
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tema escuro selecionado!')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.pink),
              title: const Text('Romântico'),
              onTap: () {
                // Lógica para tema romântico
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tema romântico selecionado!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}