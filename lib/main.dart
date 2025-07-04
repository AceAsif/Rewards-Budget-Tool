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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const RewardsBudgetToolPage(title: 'Rewards Budget Tool'),
    );
  }
}
