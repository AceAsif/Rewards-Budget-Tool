import 'package:flutter/material.dart';
import 'rewards_budget_tool_page.dart';

void main() {
  runApp(const RewardsBudgetToolApp());
}

class RewardsBudgetToolApp extends StatelessWidget {
  const RewardsBudgetToolApp({super.key});

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
      themeMode: ThemeMode.system, // 👈 Auto-switches based on device setting
      home: const RewardsBudgetToolPage(title: 'Rewards Budget Tool'),
    );
  }
}
