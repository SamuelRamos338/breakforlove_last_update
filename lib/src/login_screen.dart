import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  late final AnimationController _logoAnimController;
  late final Animation<double> _logoScale;
  bool _showForm = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _logoAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _logoScale = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _logoAnimController, curve: Curves.easeOutBack),
    );
    Future.delayed(const Duration(milliseconds: 150), () {
      _logoAnimController.forward().then((_) {
        setState(() => _showForm = true);
      });
    });
  }

  @override
  void dispose() {
    _logoAnimController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() => _isLoading = true);
    try {
      final response = await http.post(
        Uri.parse('http://192.168.0.104:3000/api/usuarioRoute/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'usuario': _userController.text,
          'senha': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['msg'] == 'Login realizado com sucesso') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainPage()),
          );
        } else {
          _showError(data['msg']);
        }
      } else {
        _showError('Erro: ${response.statusCode}');
      }
    } catch (e) {
      _showError('Erro ao conectar ao servidor. Tente novamente.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final secondary = theme.colorScheme.secondary;

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primary,
              secondary,
              primary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  AnimatedBuilder(
                    animation: _logoAnimController,
                    builder: (context, child) => AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: _logoAnimController.value,
                      child: Transform.scale(
                        scale: _logoScale.value,
                        child: child,
                      ),
                    ),
                    child: Image.asset(
                      'assets/logoApp.png',
                      width: 280,
                      height: 200,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Bem-vindo!',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: _showForm ? 1 : 0,
                    curve: Curves.easeOutCubic,
                    child: AnimatedSlide(
                      duration: const Duration(milliseconds: 400),
                      offset: _showForm ? Offset(0, 0) : Offset(0, 0.15),
                      curve: Curves.easeOutCubic,
                      child: _LoginScreenForm(
                        userController: _userController,
                        passwordController: _passwordController,
                        onLoginTap: _login,
                        isLoading: _isLoading,
                        onRegisterTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterScreen()),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginScreenForm extends StatelessWidget {
  final TextEditingController userController;
  final TextEditingController passwordController;
  final VoidCallback onLoginTap;
  final VoidCallback onRegisterTap;
  final bool isLoading;

  const _LoginScreenForm({
    required this.userController,
    required this.passwordController,
    required this.onLoginTap,
    required this.onRegisterTap,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final iconColor = Theme.of(context).iconTheme.color;
    return Column(
      children: [
        Card(
          color: Colors.white,
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: userController,
                  decoration: InputDecoration(
                    labelText: 'Usuário',
                    prefixIcon: Icon(Icons.person, color: iconColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: Icon(Icons.lock, color: iconColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: isLoading ? null : onLoginTap,
                        child: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                          'Entrar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: onRegisterTap,
                  child: const Text(
                    'Não tem conta? Cadastre-se',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}