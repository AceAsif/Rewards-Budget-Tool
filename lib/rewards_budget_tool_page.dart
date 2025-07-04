import 'package:flutter/material.dart';

class RewardsBudgetToolPage extends StatefulWidget {
  const RewardsBudgetToolPage({super.key, required this.title});
  final String title;

  @override
  State<RewardsBudgetToolPage> createState() => _RewardsBudgetToolPageState();
}

class _RewardsBudgetToolPageState extends State<RewardsBudgetToolPage> {
  final TextEditingController _budgetController = TextEditingController(text: '1500');
  final TextEditingController _usersController = TextEditingController(text: '10');
  final TextEditingController _rewardController = TextEditingController(text: '50');

  double? _maxRewardPerUser;
  int? _maxUsersCovered;
  double? _totalCostIfAllUsersSucceed;

  void _calculate() {
    final double budget = double.tryParse(_budgetController.text) ?? 0;
    final int users = int.tryParse(_usersController.text) ?? 0;
    final double reward = double.tryParse(_rewardController.text) ?? 0;

    setState(() {
      _maxRewardPerUser = users > 0 ? budget / users : 0;
      _maxUsersCovered = reward > 0 ? (budget ~/ reward) : 0;
      _totalCostIfAllUsersSucceed = users * reward;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Enter Your Budget Settings:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _budgetController,
              decoration: const InputDecoration(labelText: 'Total Budget (\$)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _usersController,
              decoration: const InputDecoration(labelText: 'Total Users'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _rewardController,
              decoration: const InputDecoration(labelText: 'Reward Per User (\$)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculate,
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 24),
            if (_maxRewardPerUser != null) ...[
              Text('Max Reward per User: \$${_maxRewardPerUser!.toStringAsFixed(2)}'),
              Text('Max Users You Can Reward: $_maxUsersCovered'),
              Text('Total Cost if All Users Redeem: \$${_totalCostIfAllUsersSucceed!.toStringAsFixed(2)}'),
              const SizedBox(height: 12),
              if (_totalCostIfAllUsersSucceed! <= (double.tryParse(_budgetController.text) ?? 0))
                const Text('✅ Your plan is within the budget.', style: TextStyle(color: Colors.green))
              else
                const Text('⚠️ Warning: Budget may be exceeded!', style: TextStyle(color: Colors.red)),
            ]
          ],
        ),
      ),
    );
  }
}
