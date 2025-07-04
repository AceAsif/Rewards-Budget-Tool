import 'package:flutter/material.dart';
import 'rewards_budget_tool_page.dart';

void main() {
  runApp(const RewardsBudgetToolApp());
}

class RewardsBudgetToolApp extends StatefulWidget {
  const RewardsBudgetToolApp({super.key});

  @override
  State<RewardsBudgetToolApp> createState() => _RewardsBudgetToolAppState();
}

class _RewardsBudgetToolAppState extends State<RewardsBudgetToolApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme(ThemeMode newMode) {
    setState(() {
      _themeMode = newMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rewards Budget Tool',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: _themeMode,
      home: RewardsBudgetToolPage(
        title: 'Rewards Budget Tool',
        onThemeChanged: _toggleTheme, // 👈 Pass toggle function to page
        currentThemeMode: _themeMode,
      ),
    );
  }
}
