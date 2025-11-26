import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({super.key});

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen>
    with SingleTickerProviderStateMixin {
  int count = 0;
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _loadCount();

    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.9).animate(_controller);
  }

  Future<void> _loadCount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      count = prefs.getInt("tasbihCount") ?? 0;
    });
  }

  Future<void> _increment() async {
    setState(() {
      count++;
    });
    _controller.forward().then((_) => _controller.reverse());

    // Vibrate on press (works on Android/iOS)
    HapticFeedback.selectionClick();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("tasbihCount", count);
  }

  Future<void> _reset() async {
    setState(() {
      count = 0;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("tasbihCount", 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasbih Mode"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reset,
          )
        ],
      ),
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnim,
          child: GestureDetector(
            onTap: _increment,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: isDark ? Colors.green[700] : Colors.green[400],
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 2,
                  )
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                "$count",
                style: GoogleFonts.poppins(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
