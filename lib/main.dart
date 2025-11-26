import 'package:flutter/material.dart';
import 'screens/today_screen.dart' as today_screen;
import 'screens/history_screen.dart' as history_screen;
import 'screens/tasbih_screen.dart' as tasbih_screen;


void main() {
  runApp(const DailyAdhkarApp());
}

class DailyAdhkarApp extends StatelessWidget {
  const DailyAdhkarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Adhkar Tracker',
      theme: ThemeData(
        primaryColor: const Color(0xFF0F8D42),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFFD4A017),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    today_screen.TodayScreen(),
    history_screen.HistoryScreen(),
    tasbih_screen.TasbihScreen(),
  ];

  final List<String> _titles = [
    "Today",
    "History",
    "Tasbih Mode",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        backgroundColor: const Color(0xFF0F8D42),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF0F8D42),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: "Today",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.repeat),
            label: "Tasbih",
          ),
        ],
      ),
    );
  }
}
