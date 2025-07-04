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

  void _reset() {
    setState(() {
      _budgetController.text = '1500';
      _usersController.text = '10';
      _rewardController.text = '50';
      _maxRewardPerUser = null;
      _maxUsersCovered = null;
      _totalCostIfAllUsersSucceed = null;
    });
  }

  Widget _buildResultRow(String label, String value) {
    return RichText(
      text: TextSpan(
        text: '$label ',
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
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
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _calculate,
                    child: const Text('Calculate'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _reset,
                    child: const Text('Reset'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (_maxRewardPerUser != null) ...[
              Card(
                margin: const EdgeInsets.symmetric(vertical: 16),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildResultRow(
                          '💡 Max Affordable Reward per User (within budget):',
                          '\$${_maxRewardPerUser!.toStringAsFixed(2)}'),
                      const SizedBox(height: 8),
                      _buildResultRow(
                          '🎯 Max Users You Can Fully Reward (within budget):',
                          '$_maxUsersCovered'),
                      const SizedBox(height: 8),
                      _buildResultRow(
                          '📅 Planned Total Cost (All Users Redeem):',
                          '\$${_totalCostIfAllUsersSucceed!.toStringAsFixed(2)}'),
                    ],
                  ),
                ),
              ),
              Center(
                child: Text(
                  _totalCostIfAllUsersSucceed! <= (double.tryParse(_budgetController.text) ?? 0)
                      ? '✅ Your plan is within the budget.'
                      : '⚠️ Warning: Your current plan would exceed your budget.\nPlease reduce rewards, users, or increase your budget.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _totalCostIfAllUsersSucceed! <= (double.tryParse(_budgetController.text) ?? 0)
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
