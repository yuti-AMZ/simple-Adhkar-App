import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:azkar_app/models/hadith_model.dart' as hadith_model;

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  hadith_model.Hadith? hadith;
  bool loading = true;
  int savedCount = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      await _checkReset();
      await _loadCount();

      // Load from local JSON assets as a simple fallback
      final data = await rootBundle.loadString('assets/hadith.json');
      final jsonData = jsonDecode(data) as List;
      
      if (jsonData.isEmpty) {
        throw Exception('Hadith data is empty');
      }
      
      jsonData.shuffle();
      final random = jsonData.first as Map<String, dynamic>;

      setState(() {
        hadith = hadith_model.Hadith(
          arabic: random['arabic'] ?? '…',
          translation: random['translation'] ?? '…',
        );
        loading = false;
      });
    } catch (e) {
      // Handle errors gracefully
      setState(() {
        hadith = hadith_model.Hadith(
          arabic: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
          translation: 'In the name of Allah, the Most Gracious, the Most Merciful',
        );
        loading = false;
      });
    }
  }

  // Auto-reset count every day
  Future<void> _checkReset() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toString().substring(0, 10);
    final savedDate = prefs.getString("savedDate");

    if (savedDate != today) {
      await prefs.setString("savedDate", today);
      await prefs.setInt("count", 0);

      // Optional: save in full history
      List<String> history = prefs.getStringList("history") ?? [];
      if (savedDate != null) {
        history.add('$savedDate: ${prefs.getInt("count") ?? 0}');
      }
      await prefs.setStringList("history", history);
    }
  }

  Future<void> _loadCount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedCount = prefs.getInt("count") ?? 0;
    });
  }

  void _updateCount(int newCount) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("count", newCount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Today’s Adhkar"),
        actions: [
          IconButton(
              onPressed: () async {
                // toggle dark/light
                // ignore: use_build_context_synchronously
                await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Switch Theme"),
                      content: const Text("Switch dark/light mode?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel")),
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            // Use ThemeManager toggle
                          },
                          child: const Text("Switch"),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.brightness_6)),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    hadith!.arabic,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    hadith!.translation,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Text('Count: $savedCount', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        savedCount++;
                      });
                      _updateCount(savedCount);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F8D42),
                    ),
                    child: const Text('Increment'),
                  ),
                ],
              ),
            ),
    );
  }
}
