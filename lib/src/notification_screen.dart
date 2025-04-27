import 'dart:async';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with SingleTickerProviderStateMixin {
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 30;
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  bool _isTimerRunning = false;
  Timer? _timer;
  int _remainingMilliseconds = 30000;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _remainingMilliseconds),
    )..addListener(() {
      setState(() {});
    });
    _scaleAnim = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
  }

  void _startTimer() {
    if (_isTimerRunning || (_hours == 0 && _minutes == 0 && _seconds == 0)) return;
    setState(() {
      _remainingMilliseconds = Duration(hours: _hours, minutes: _minutes, seconds: _seconds).inMilliseconds;
      _isTimerRunning = true;
      _controller.duration = Duration(milliseconds: _remainingMilliseconds);
      _controller.reverse(from: 1.0);
    });

    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_remainingMilliseconds > 0) {
        setState(() {
          _remainingMilliseconds -= 100;
          _hours = _remainingMilliseconds ~/ 3600000;
          _minutes = (_remainingMilliseconds % 3600000) ~/ 60000;
          _seconds = (_remainingMilliseconds % 60000) ~/ 1000;
        });
      } else {
        _stopTimer();
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _controller.stop();
    setState(() => _isTimerRunning = false);
  }

  void _editTime() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Selecione o Tempo", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTimePicker("Horas", _hours, (val) => setState(() => _hours = val)),
                  _buildTimePicker("Minutos", _minutes, (val) => setState(() => _minutes = val)),
                  _buildTimePicker("Segundos", _seconds, (val) => setState(() => _seconds = val)),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_hours == 0 && _minutes == 0 && _seconds == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("O tempo não pode ser zero!")),
                    );
                    return;
                  }
                  setState(() => _remainingMilliseconds = Duration(hours: _hours, minutes: _minutes, seconds: _seconds).inMilliseconds);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
                child: const Text("Confirmar", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = theme.colorScheme.surface.withOpacity(0.95);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          GestureDetector(
            onTap: _editTime,
            child: AnimatedScale(
              scale: _isTimerRunning ? _scaleAnim.value : 1.0,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOutCubic,
              child: SizedBox(
                width: 260,
                height: 260,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: TimerPainter(
                        progress: _controller.value,
                        backgroundColor: theme.colorScheme.surface.withOpacity(0.5),
                        progressColor: theme.colorScheme.primary.withOpacity(0.85),
                        glowColor: theme.colorScheme.primary.withOpacity(0.25),
                      ),
                      child: Center(
                        child: Text(
                          "${_hours.toString().padLeft(2, '0')}:${_minutes.toString().padLeft(2, '0')}:${_seconds.toString().padLeft(2, '0')}",
                          style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                            shadows: [
                              Shadow(
                                color: theme.colorScheme.primary.withOpacity(0.18),
                                blurRadius: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _isTimerRunning ? _stopTimer : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.error.withOpacity(0.9),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 0,
                ),
                icon: const Icon(Icons.stop, color: Colors.white),
                label: const Text('Parar', style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton.icon(
                onPressed: _startTimer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.9),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 0,
                ),
                icon: const Icon(Icons.play_arrow, color: Colors.white),
                label: const Text('Iniciar', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimePicker(String label, int value, ValueChanged<int> onChanged) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 120,
          width: 80,
          child: ListWheelScrollView.useDelegate(
            controller: FixedExtentScrollController(initialItem: value),
            itemExtent: 40,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (val) => onChanged(val),
            childDelegate: ListWheelChildLoopingListDelegate(
              children: List.generate(60, (index) => Center(child: Text(index.toString().padLeft(2, '0')))),
            ),
          ),
        ),
      ],
    );
  }
}

class TimerPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;
  final Color glowColor;

  TimerPainter({
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
    required this.glowColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke;

    final Paint progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 6);

    final Paint glowPaint = Paint()
      ..color = glowColor
      ..strokeWidth = 28
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 18);

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;

    // Glow
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.5,
      2 * 3.14 * progress,
      false,
      glowPaint,
    );
    // Progress
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.5,
      2 * 3.14 * progress,
      false,
      progressPaint,
    );
    // Background
    canvas.drawCircle(center, radius, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}