import 'package:flutter/material.dart';

class CoupleScreen extends StatelessWidget {
  const CoupleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre o Casal')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage('assets/profile1.jpg'),
                ),
                SizedBox(width: 16),
                Icon(Icons.favorite, color: Colors.pink, size: 32),
                SizedBox(width: 16),
                CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage('assets/profile2.jpg'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Samuel & Maria',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Juntos desde: 14/02/2024',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Card(
              child: ListTile(
                leading: const Icon(Icons.cake, color: Colors.pink),
                title: const Text('Próximo aniversário de namoro'),
                subtitle: const Text('14/03/2024'),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.location_on, color: Colors.pink),
                title: const Text('Local favorito do casal'),
                subtitle: const Text('Parque Central'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}